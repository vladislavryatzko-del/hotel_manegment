#!/usr/bin/env bash
# Перегенерация UML-диаграмм (PlantUML -> SVG + PNG).
# Требуется: Java, Graphviz (dot) и plantuml.jar.
# Путь к jar: переменная PLANTUML_JAR (по умолчанию ./plantuml.jar).
set -euo pipefail
cd "$(dirname "$0")/.."

JAR="${PLANTUML_JAR:-./plantuml.jar}"
SRC="docs/diagrams/src"
OUT="docs/diagrams/img"

if [[ ! -f "$JAR" ]]; then
  echo "plantuml.jar не найден: $JAR" >&2
  echo "Скачайте его с https://github.com/plantuml/plantuml/releases и задайте PLANTUML_JAR." >&2
  exit 1
fi

mkdir -p "$OUT"
for fmt in svg png; do
  java -jar "$JAR" -t"$fmt" -charset UTF-8 -o "../img" "$SRC"/[0-9]*.puml
done
echo "Готово: $OUT"
