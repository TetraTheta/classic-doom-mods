/*===========================================================================//
  Build Movement by Pato Fanático
  Universal version of Build Movement, originally an addon for Ashes 2063 and episodes
  Credits to:
  Nash Muhandes (Original Nashmove mod)
  Can't Sleep (Nobody Told Me About id mod, where some of the code was taken from)
  BROS_ETT_311 (UniversalPlayerMove mod, from where some of the code was taken from)
  Zdoom Wiki (Used for reference)
//===========================================================================*/
class BuildMoveHandler : StaticEventHandler {
  MoveManager move;
  override void WorldLoaded(WorldEvent e) {
    if (gamestate != GS_LEVEL) return;
    ThinkerIterator it = ThinkerIterator.Create("MoveManager", Thinker.MAX_STATNUM);
    move = MoveManager(it.Next());
    if (!move) {
      move = new ("MoveManager");
      move.ChangeStatNum(Thinker.MAX_STATNUM);
    }
  }
}

class MoveManager : Thinker {
  int fallState, fallTics, fallTics2, oldHealth, painTics, doorTics;
  float default_aircontrol;
  override void PostBeginPlay() {
    for (uint i = 0; i < MAXPLAYERS; ++i) {
      if (!playerInGame[i] || !players[i].mo) continue;
      let plr = players[i].mo;
      if (default_aircontrol == 0) default_aircontrol = level.aircontrol;
      string def_woolball_hero = "Hero", def_woolball_skate = "Skateboard";
      let woolball_skate = plr && plr is def_woolball_hero && plr.FindInventory(def_woolball_skate);
      if (woolball_skate) plr.A_TakeInventory(def_woolball_skate, 1);
    }
  }
  // Build Movement starts here
  override void Tick() {
    for (uint i = 0; i < MAXPLAYERS; ++i) {
      if (!playerInGame[i] || !players[i].mo) continue;
      bool bob = (players[i].WeaponState & WF_WEAPONBOBBING);
      bool doReset = ((!bob) || (players[i].attackdown) || (bob && !(players[i].vel ~ == (0, 0))));
      let plr = players[i].mo;
      let psp = players[i].GetPSPrite(PSP_WEAPON);
      let weap = players[i].ReadyWeapon;
      bool CanPinch = ((players[i].WeaponState & WF_WEAPONREADY) || (players[i].WeaponState & WF_WEAPONREADYALT) || (players[i].WeaponState & WF_WEAPONRELOADOK) || (players[i].WeaponState & WF_WEAPONZOOMOK) || (players[i].WeaponState & WF_WEAPONSWITCHOK));
      // COMPATIBILITY DEFINITIONS
      // Ashes 2063
      string def_ashes_bike = "motohandles", def_ashes_bike2 = "motohandles2", def_ashes_bike3 = "motohandlefake", def_ashes_lucy = "lucyhandles";
      let ashes_onvehicle = plr.FindInventory(def_ashes_bike) || plr.FindInventory(def_ashes_bike2) || plr.FindInventory(def_ashes_bike3) || plr.FindInventory(def_ashes_lucy);
      // Wool Ball
      string def_woolball_hero = "Hero", def_woolball_skate = "Skateboard";
      let woolball_skate = plr && plr is def_woolball_hero && plr.FindInventory(def_woolball_skate);
      let woolball_wind = plr && plr is def_woolball_hero && plr.curSector && ((plr.curSector.flags & 32) || (plr.curSector.flags & 84) || (plr.curSector.flags & 118) || (plr.curSector.flags & 4096) || (plr.curSector.flags & 6144) || (plr.curSector.flags & 201));
      let woolball_excepts = woolball_skate || woolball_wind;
      // Misc
      bool player_frozen = plr.Player.Cheats & CF_TOTALLYFROZEN;
      bool player_onice = plr.curSector && (plr.curSector.flags & 16);
      //------
      // Define exceptions
      let bmove_exceptions = ashes_onvehicle || woolball_excepts || player_onice || player_frozen;
      // Build Movement
      float buildmove_speed = plr.GetCVar("cl_buildmove_speed");
      if (!plr.GetCVar("cl_buildmove") || bmove_exceptions || (plr.pos.z != plr.floorz && !plr.GetCVar("cl_newairmove"))) {
        if (plr.speed != 1.0) {
          plr.A_SetSpeed(1.0);
          plr.vel.xy *= 1.0;
        }
      } else {
        if (!player_onice) {
          plr.A_SetSpeed(buildmove_speed);
          plr.vel.xy *= 0.88;
        }
      }
      if (plr.GetCVar("cl_always_squat")) plr.JumpZ = plr.Default.JumpZ * 1.00000000001;
      // Air Controller
      float newaircontrol_amount = plr.GetCVar("cl_newairmove_amount");
      if (!plr.GetCVar("cl_newairmove") || bmove_exceptions || !((plr.Pos.Z != plr.FloorZ) && (plr.vel.x != 0 || plr.vel.y != 0))) {
        if (level.aircontrol != default_aircontrol) {
          level.aircontrol = default_aircontrol;
          level.airfriction = 1;
        }
      } else if (level.aircontrol <= newaircontrol_amount) {
        if ((plr.Pos.Z != plr.FloorZ) && (plr.vel.x != 0 || plr.vel.y != 0)) {
          level.airControl = newaircontrol_amount;
          if (plr.GetCVar("cl_buildmove")) {
            level.airfriction = newaircontrol_amount * -0.0800 + 1.0200;
          } else {
            level.airfriction = newaircontrol_amount * -0.0941 + 1.0004;
          }
        }
      }
      // Roll reset
      if (plr.GetCVar("cl_roll_death")) {
        bool RollReset;
        if (!RollReset && plr.roll != 0 && plr.health > 0) {
          plr.A_SetRoll(0, SPF_INTERPOLATE);
          RollReset = true;
        } else {
          RollReset = false;
        }
        // Death roll
        bool RollDeath;
        if (plr.health <= 0 && !RollDeath) {
          if (plr.roll == 0) {
            plr.A_SetRoll(random(180, -180), SPF_INTERPOLATE);
            RollDeath = true;
          }
        } else if (plr.health > 0) {
          RollDeath = false;
        }
      }
      // Death flash
      if (plr.GetCVar("cl_death_flash")) {
        bool DeathFlashed;
        if (plr.health <= 0) {
          if (!DeathFlashed) {
            plr.A_SetBlend("Red", 0.5, 35, "Red", 0.025);
            DeathFlashed = true;
          }
        } else {
          DeathFlashed = false;
        }
      }
      // Flinch when falling (& weapon panning)
      float wpn_pan_amount = plr.GetCVar("cl_wpn_panning_amount");
      if (weap != Null && CanPinch && plr.GetCVar("cl_weapon_panning")) plr.A_WeaponOffset(0, fallTics2 * wpn_pan_amount, WOF_ADD | WOF_INTERPOLATE);
      int flinch_threshold = plr.GetCVar("cl_flinch_threshold");
      int flinch_dur = plr.GetCVar("cl_flinch_duration");
      int flinch_slowdur = flinch_dur - 4;
      float flinch_return = 1.0 / flinch_dur;
      float og_pitch;
      bool flinch_lowgrav = (plr.GetCVar("cl_noflinch_lowgrav") && plr.curSector.gravity >= 1) || !plr.GetCVar("cl_noflinch_lowgrav");
      if (!plr.waterLevel && !plr.bFly && flinch_lowgrav && plr.GetCVar("cl_cam_flinch")) {
        switch (fallState) {
        case (0): // Falling
          if (plr.vel.z < 0) {
            if (fallTics <= (flinch_threshold * 1000) / sv_gravity) {
              ++fallTics;
            } else {
              fallState = 1;
            }
          } else {
            fallTics = 0;
          }
          break;
        case (1): // Thud
          if (plr.pos.z <= plr.floorZ || plr.bOnMObj) {
            if (!ashes_onvehicle) {
              og_pitch = plr.viewPitch;
              plr.A_SetViewPitch(plr.viewPitch + (plr.GetCVar("cl_cam_flinch_amount")), SPF_Interpolate);
            }
            fallState = 2;
            fallTics = 0;
            fallTics2 += flinch_dur;
          }
          break;
        case (2): // Flinch
          if (fallTics2 > 0) {
            if (!ashes_onvehicle || plr.viewPitch != og_pitch) {
              if (fallTics2 > flinch_slowdur && plr.GetCVar("cl_flinch_slowdown") && !ashes_onvehicle) {
                plr.vel.xy *= 0.77;
              }
              plr.A_SetViewPitch(plr.viewPitch - (plr.GetCVar("cl_cam_flinch_amount") * flinch_return), SPF_Interpolate); // 0.8 //1.5
            }
            --fallTics2;
          } else {
            fallState = 0;
          }
          break;
        }
      }
    }
  }
}
