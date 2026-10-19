import re
from pathlib import Path


def main():
    root_dir = Path(__file__).resolve().parent
    pattern = re.compile(r"private(?:\r\n|\r|\n)[ \t]+(Array|bool|double|State|void)\b")
    modified_count = 0
    for file_path in root_dir.rglob("*.zs"):
        try:
            original = file_path.read_text(encoding="utf-8")
            updated = pattern.sub(r"private \1", original)
            if updated != original:
                file_path.write_text(updated, encoding="utf-8")
                modified_count += 1
                print(f"수정됨: {file_path.relative_to(root_dir)}")
        except (OSError, UnicodeError) as e:
            print(f"오류: {file_path} - {e}")
    print(f"\n완료: 총 {modified_count}개 파일 수정")


if __name__ == "__main__":
    main()
