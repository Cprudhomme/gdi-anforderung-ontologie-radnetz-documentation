#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

WIDOCO_VERSION="1.4.21"
WIDOCO_DIR="${REPO_ROOT}/.widoco/bin"
WIDOCO_JAR="${WIDOCO_DIR}/widoco.jar"
WIDOCO_URL="https://github.com/dgarijo/Widoco/releases/download/v${WIDOCO_VERSION}/widoco-${WIDOCO_VERSION}-jar-with-dependencies.jar"

ONTOLOGY_FILE="${REPO_ROOT}/radnetz_ontology.ttl"
CONFIG_FILE="${REPO_ROOT}/.widoco/widoco.properties"
OUTPUT_DIR="${REPO_ROOT}/docs"

# 1. Check for Java
if ! command -v java >/dev/null 2>&1; then
  echo "Error: Java Runtime is not installed or not in PATH."
  echo "Please install a Java Development Kit (JDK 11+), e.g. via Homebrew: 'brew install openjdk'"
  exit 1
fi

# Verify java actually runs
if ! java -version >/dev/null 2>&1; then
  echo "Error: Java binary found but no functional Java Runtime located."
  echo "On macOS, ensure a JDK is installed and configured (e.g. 'brew install openjdk')."
  exit 1
fi

# 2. Download Widoco JAR if not present
if [ ! -f "${WIDOCO_JAR}" ]; then
  echo "Downloading WIDOCO v${WIDOCO_VERSION}..."
  mkdir -p "${WIDOCO_DIR}"
  curl -sSL "${WIDOCO_URL}" -o "${WIDOCO_JAR}"
  echo "Downloaded WIDOCO to ${WIDOCO_JAR}"
fi

# 3. Generate documentation
echo "Generating WIDOCO documentation for radnetz_ontology.ttl..."
mkdir -p "${OUTPUT_DIR}"

java -Djava.awt.headless=true -jar "${WIDOCO_JAR}" \
  -ontFile "${ONTOLOGY_FILE}" \
  -outFolder "${OUTPUT_DIR}" \
  -confFile "${CONFIG_FILE}" \
  -rewriteAll \
  -webVowl \
  -lang de-en \
  -includeAnnotationProperties

# Ensure index.html exists
if [ ! -f "${OUTPUT_DIR}/index.html" ]; then
  if [ -f "${OUTPUT_DIR}/index-de.html" ]; then
    cp "${OUTPUT_DIR}/index-de.html" "${OUTPUT_DIR}/index.html"
  elif [ -f "${OUTPUT_DIR}/index-en.html" ]; then
    cp "${OUTPUT_DIR}/index-en.html" "${OUTPUT_DIR}/index.html"
  fi
fi

touch "${OUTPUT_DIR}/.nojekyll"

echo ""
echo "Documentation successfully generated in: ${OUTPUT_DIR}"
echo "Open ${OUTPUT_DIR}/index.html in your browser to preview."
