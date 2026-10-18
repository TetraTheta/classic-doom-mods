class DSCleanMapQueueFlusher : Actor {
  Default {
    +NOINTERACTION
    +NOBLOCKMAP
    +NOGRAVITY
    RenderStyle "None";
  }
  States {
  Spawn:
    TNT1 A -1;
    Stop;
  }
}

class DSCleanMapHandler : StaticEventHandler {
  private Array<Thinker> initialAutoDecals;
  private Array<Thinker> initialPermanentDecals;
  private Array<Actor> initialRemains;
  private bool hasInitialState;

  private bool IsActorClass(Actor actor, Name className) {
    let actorClass = Object.FindClass(className, "Actor");
    return actorClass != null && actor is actorClass;
  }
  private bool IsBrutalDoomTrace(Actor actor) {
    String className = actor.GetClassName();
    className = className.MakeLower();
    bool namedRemains =
      className.IndexOf("xdeath") == 0 ||
      className.IndexOf("dead") == 0 ||
      className.IndexOf("brutalizeddead") >= 0 ||
      className.IndexOf("corpse") >= 0 ||
      className.IndexOf("gib") >= 0;
    bool goreClass =
      IsActorClass(actor, 'BigGibBase') ||
      IsActorClass(actor, 'TinyGib') ||
      IsActorClass(actor, 'BasicGib') ||
      IsActorClass(actor, 'XDeath1') ||
      IsActorClass(actor, 'XDeath1Blue') ||
      IsActorClass(actor, 'XDeath1Green') ||
      IsActorClass(actor, 'MeatDeath') ||
      IsActorClass(actor, 'BlueMeatDeath') ||
      IsActorClass(actor, 'MuchMeatDeath');
    bool bloodMark = IsActorClass(actor, 'Brutal_BloodSpot') || IsActorClass(actor, 'Blue_BloodSpot') || IsActorClass(actor, 'Green_BloodSpot');
    return namedRemains || goreClass || bloodMark;
  }
  private bool IsRemains(Actor actor) {
    bool hostileCorpse = actor.bIsMonster && !actor.bFriendly && actor.bKilled;
    return actor.bCorpse || hostileCorpse || IsBrutalDoomTrace(actor);
  }
  private void CaptureInitialActors(bool clientSide) {
    let iterator = ThinkerIterator.Create("Actor", Thinker.MAX_STATNUM + 1, clientSide);
    Actor actor;
    while ((actor = Actor(iterator.Next())) != null) {
      if (IsRemains(actor)) {
        // Keep recognized map-start remains out of the later force-only queue flush.
        actor.A_DeQueueCorpse();
        initialRemains.Push(actor);
      }
    }
  }
  private void CaptureInitialState() {
    initialAutoDecals.Clear();
    initialPermanentDecals.Clear();
    initialRemains.Clear();
    let autoIterator = ThinkerIterator.Create("Thinker", Thinker.STAT_AUTODECAL);
    Thinker decal;
    while ((decal = autoIterator.Next()) != null) {
      initialAutoDecals.Push(decal);
    }
    let permanentIterator = ThinkerIterator.Create("Thinker", Thinker.STAT_DECAL);
    while ((decal = permanentIterator.Next()) != null) {
      initialPermanentDecals.Push(decal);
    }
    CaptureInitialActors(false);
    CaptureInitialActors(true);
    hasInitialState = true;
  }
  private void CleanCorpseQueue() {
    let queueSizeCVar = CVar.FindCVar("sv_corpsequeuesize");
    if (queueSizeCVar == null) {
      return;
    }
    int queueSize = queueSizeCVar.GetInt();
    if (queueSize <= 0) {
      return;
    }
    Array<Actor> flushers;
    for (int index = 0; index < queueSize; index++) {
      let flusher = Actor.Spawn("DSCleanMapQueueFlusher");
      if (flusher == null) {
        break;
      }
      flushers.Push(flusher);
      flusher.A_QueueCorpse();
    }
    for (uint index = 0; index < flushers.Size(); index++) {
      let flusher = flushers[index];
      if (flusher != null && !flusher.bDestroyed) {
        flusher.A_DeQueueCorpse();
        flusher.Destroy();
      }
    }
  }
  private void CleanDecals(bool force) {
    let autoIterator = ThinkerIterator.Create("Thinker", Thinker.STAT_AUTODECAL);
    Thinker decal;
    while ((decal = autoIterator.Next()) != null) {
      if (force || initialAutoDecals.Find(decal) == initialAutoDecals.Size()) {
        // shortcut: UZDoom exposes no gameplay-safe decal counter reset; a save reload recalculates it.
        decal.Destroy();
      }
    }
    let iterator = ThinkerIterator.Create("Thinker", Thinker.STAT_DECAL);
    while ((decal = iterator.Next()) != null) {
      if (force || initialPermanentDecals.Find(decal) == initialPermanentDecals.Size()) {
        decal.Destroy();
      }
    }
  }
  private void CleanActors(bool clientSide, bool force) {
    let iterator = ThinkerIterator.Create("Actor", Thinker.MAX_STATNUM + 1, clientSide);
    Actor actor;
    while ((actor = Actor(iterator.Next())) != null) {
      if (IsRemains(actor) && (force || initialRemains.Find(actor) == initialRemains.Size())) {
        actor.A_DeQueueCorpse();
        actor.Destroy();
      }
    }
  }
  override void WorldLoaded(WorldEvent event) {
    if ((event.IsSaveGame || event.IsReopen) && hasInitialState) {
      return;
    }
    CaptureInitialState();
  }
  override void NetworkProcess(ConsoleEvent event) {
    bool force = event.Name == "cleanmap_force";
    if (event.Name != "cleanmap" && !force) {
      return;
    }
    CleanActors(false, force);
    CleanActors(true, force);
    if (force) {
      CleanCorpseQueue();
    }
    CleanDecals(force);
  }
}
