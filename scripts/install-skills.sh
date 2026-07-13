#!/usr/bin/env bash
# Install this pack's Agent Skills into the local Hermes skills directory.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HERMES_HOME="${HERMES_HOME:-${HOME}/.hermes}"
CATEGORY="${HERMES_SKILLS_CATEGORY:-productivity}"
DEST_ROOT="${HERMES_SKILLS_DIR:-${HERMES_HOME}/skills/${CATEGORY}}"
LINK="${HERMES_SKILLS_LINK:-0}"   # 1 = symlink for live editing

blue()  { printf '\033[1;34m%s\033[0m\n' "$*"; }
green() { printf '\033[1;32m%s\033[0m\n' "$*"; }
yellow(){ printf '\033[1;33m%s\033[0m\n' "$*"; }
red()   { printf '\033[1;31m%s\033[0m\n' "$*"; }

SKILLS=(
  content-progression
  daily-self-review
  github-morning-digest
)

blue "==> Install Hermes Daily skills → ${DEST_ROOT}"
mkdir -p "${DEST_ROOT}"

for name in "${SKILLS[@]}"; do
  src="${ROOT}/skills/${name}"
  dest="${DEST_ROOT}/${name}"
  if [[ ! -f "${src}/SKILL.md" ]]; then
    red "Missing ${src}/SKILL.md — skip"
    continue
  fi
  # basic frontmatter check
  if ! head -1 "${src}/SKILL.md" | grep -q '^---'; then
    yellow "WARN: ${name}/SKILL.md has no YAML frontmatter"
  fi

  if [[ -e "${dest}" || -L "${dest}" ]]; then
    rm -rf "${dest}"
  fi

  if [[ "${LINK}" == "1" ]]; then
    ln -s "${src}" "${dest}"
    echo "    link  ${dest} -> ${src}"
  else
    mkdir -p "${dest}"
    # copy tree but skip junk
    if command -v rsync >/dev/null 2>&1; then
      rsync -a --exclude '.DS_Store' "${src}/" "${dest}/"
    else
      cp -R "${src}/." "${dest}/"
    fi
    echo "    copy  ${dest}"
  fi
done

green "==> Done. Skills installed under ${DEST_ROOT}"
echo
echo "    hermes skills list | grep -E 'content-progression|daily-self-review|github-morning'"
echo "    # Live-edit mode next time: HERMES_SKILLS_LINK=1 $0"
echo
