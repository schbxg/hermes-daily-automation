#!/usr/bin/env bash
# install-pack.sh — scaffold data + register every cron job in a pack manifest.
#
# Usage:
#   ./scripts/install-pack.sh list
#   ./scripts/install-pack.sh morning-brief
#   ./scripts/install-pack.sh learning-os
#   ./scripts/install-pack.sh morning-brief --dry-run
#
# Env:
#   HERMES_DAILY_LANG=zh|en          prompt language (default: zh)
#   HERMES_DAILY_HOME=...            data root (default: ~/.hermes/daily)
#   HERMES_DAILY_INCLUDE_OPTIONAL=1  include jobs flagged "optional"
#   HERMES_DAILY_SEED=1              run install-demo seed (default: 1)
#   HERMES_DAILY_INSTALL_SKILLS=0|1  install skills after pack (default: ask / 0 if non-tty)
#   HERMES_DAILY_SKIP_HERMES=1       never call hermes (print commands only)
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKS_DIR="${ROOT}/packs"
DATA_HOME="${HERMES_DAILY_HOME:-${HOME}/.hermes/daily}"
LANG_CHOICE="${HERMES_DAILY_LANG:-zh}"
INCLUDE_OPTIONAL="${HERMES_DAILY_INCLUDE_OPTIONAL:-0}"
SEED="${HERMES_DAILY_SEED:-1}"
SKIP_HERMES="${HERMES_DAILY_SKIP_HERMES:-0}"
DRY_RUN=0

blue()  { printf '\033[1;34m%s\033[0m\n' "$*"; }
green() { printf '\033[1;32m%s\033[0m\n' "$*"; }
yellow(){ printf '\033[1;33m%s\033[0m\n' "$*"; }
red()   { printf '\033[1;31m%s\033[0m\n' "$*"; }

usage() {
  cat <<EOF
Usage: $(basename "$0") <pack|list> [--dry-run] [--with-optional] [--en]

Packs (see packs/*/manifest.tsv):
EOF
  for m in "${PACKS_DIR}"/*/manifest.tsv; do
    [[ -f "$m" ]] || continue
    local id
    id="$(basename "$(dirname "$m")")"
    printf '  %-18s %s\n' "$id" "$(grep -c -v -E '^\s*(#|$)' "$m" 2>/dev/null || echo 0) jobs"
  done
  cat <<EOF

Examples:
  $(basename "$0") list
  $(basename "$0") morning-brief
  $(basename "$0") learning-os --en --with-optional
  $(basename "$0") morning-brief --dry-run

Env: HERMES_DAILY_LANG HERMES_DAILY_HOME HERMES_DAILY_INCLUDE_OPTIONAL
     HERMES_DAILY_SEED HERMES_DAILY_SKIP_HERMES
EOF
}

list_packs() {
  blue "==> Available packs"
  for m in "${PACKS_DIR}"/*/manifest.tsv; do
    [[ -f "$m" ]] || continue
    local id readme
    id="$(basename "$(dirname "$m")")"
    readme="${PACKS_DIR}/${id}/README.md"
    echo
    green "  ${id}"
    if [[ -f "$readme" ]]; then
      # first non-empty non-heading line as blurb
      awk 'NF && !/^#/ {print "    "$0; exit}' "$readme"
    fi
    echo "    jobs:"
    while IFS= read -r line || [[ -n "$line" ]]; do
      [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
      local schedule name stem flags
      IFS='|' read -r schedule name stem flags <<<"$line"
      local opt=""
      [[ "$flags" == *optional* ]] && opt=" (optional)"
      printf '      • %-28s  cron=%-16s  template=%s%s\n' "$name" "$schedule" "$stem" "$opt"
    done < "$m"
  done
  echo
}

resolve_template() {
  local stem="$1"
  local path
  if [[ "$LANG_CHOICE" == "en" ]]; then
    path="${ROOT}/cron-jobs/en/${stem}.md"
    if [[ ! -f "$path" ]]; then
      path="${ROOT}/cron-jobs/${stem}.md"
    fi
  else
    path="${ROOT}/cron-jobs/${stem}.md"
  fi
  if [[ ! -f "$path" ]]; then
    return 1
  fi
  printf '%s' "$path"
}

flag_has() {
  local flags="$1" key="$2"
  [[ ",${flags}," == *",${key},"* ]] || [[ "$flags" == *"${key}"* ]]
}

ensure_seed() {
  if [[ "$SEED" != "1" && "$SEED" != "yes" && "$SEED" != "true" ]]; then
    yellow "==> Skip data seed (HERMES_DAILY_SEED=${SEED})"
    return 0
  fi
  blue "==> Seeding ~/.hermes/daily via install-demo.sh"
  HERMES_DAILY_HOME="${DATA_HOME}" \
  HERMES_DAILY_LANG="${LANG_CHOICE}" \
  HERMES_DAILY_CREATE_CRON=no \
  HERMES_DAILY_INSTALL_SKILLS=no \
    "${ROOT}/scripts/install-demo.sh"
}

create_job() {
  local schedule="$1" name="$2" prompt_file="$3" flags="$4"

  if flag_has "$flags" "optional" && [[ "$INCLUDE_OPTIONAL" != "1" && "$INCLUDE_OPTIONAL" != "yes" ]]; then
    yellow "    skip optional: ${name}  (pass --with-optional)"
    return 0
  fi

  if flag_has "$flags" "gh"; then
    if ! command -v gh >/dev/null 2>&1; then
      yellow "    warn: gh not on PATH — ${name} will need GitHub CLI later"
    elif ! gh auth status >/dev/null 2>&1; then
      yellow "    warn: gh not authenticated — run: gh auth login"
    fi
  fi

  # ensure plan flags mentioned exist (seed should have created them)
  if [[ "$flags" == *plan:* ]]; then
    local f
    for f in ${flags//,/ }; do
      case "$f" in
        plan:*)
          local plan_job="${f#plan:}"
          if [[ ! -f "${DATA_HOME}/${plan_job}/plan.md" ]]; then
            yellow "    warn: missing ${DATA_HOME}/${plan_job}/plan.md — edit after install"
          fi
          ;;
      esac
    done
  fi

  # Human-readable command (for dry-run / missing hermes)
  local cmd_display
  cmd_display="hermes cron create \"${schedule}\" --name \"${name}\" --prompt \"\$(cat ${prompt_file})\""

  if [[ "$DRY_RUN" == "1" || "$SKIP_HERMES" == "1" ]]; then
    echo "    [dry-run] ${cmd_display}"
    return 0
  fi

  if ! command -v hermes >/dev/null 2>&1; then
    yellow "    hermes not on PATH — print command only:"
    echo "    ${cmd_display}"
    return 0
  fi

  blue "    create: ${name}  (${schedule})"
  if hermes cron create "$schedule" --name "$name" --prompt "$(cat "$prompt_file")"; then
    green "    ok: ${name}"
  else
    red "    failed: ${name} (continuing)"
    return 0
  fi
}

install_pack() {
  local pack_id="$1"
  local manifest="${PACKS_DIR}/${pack_id}/manifest.tsv"

  if [[ ! -f "$manifest" ]]; then
    red "Unknown pack: ${pack_id}"
    echo
    usage
    exit 1
  fi

  blue "==> Pack: ${pack_id}"
  echo "    lang:     ${LANG_CHOICE}"
  echo "    data:     ${DATA_HOME}"
  echo "    optional: ${INCLUDE_OPTIONAL}"
  echo "    dry-run:  ${DRY_RUN}"
  echo "    manifest: ${manifest}"
  echo

  ensure_seed

  local created=0 skipped=0
  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
    local schedule name stem flags prompt
    IFS='|' read -r schedule name stem flags <<<"$line"
    schedule="$(echo "$schedule" | xargs)"
    name="$(echo "$name" | xargs)"
    stem="$(echo "$stem" | xargs)"
    flags="$(echo "${flags:-}" | xargs)"

    if ! prompt="$(resolve_template "$stem")"; then
      red "    missing template for stem=${stem}"
      skipped=$((skipped + 1))
      continue
    fi

    if flag_has "$flags" "optional" && [[ "$INCLUDE_OPTIONAL" != "1" && "$INCLUDE_OPTIONAL" != "yes" ]]; then
      yellow "    skip optional: ${name}"
      skipped=$((skipped + 1))
      continue
    fi

    create_job "$schedule" "$name" "$prompt" "$flags"
    created=$((created + 1))
  done < "$manifest"

  echo
  green "==> Pack '${pack_id}' done (processed=${created}, skipped_optional_or_missing≈ check log)"
  if command -v hermes >/dev/null 2>&1 && [[ "$DRY_RUN" != "1" && "$SKIP_HERMES" != "1" ]]; then
    echo "    hermes cron list"
  fi
  echo "    Customize plans under: ${DATA_HOME}"
  echo "    Docs: ${ROOT}/packs/${pack_id}/README.md"
  echo
}

# --- args ------------------------------------------------------------------
PACK_ID=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help) usage; exit 0 ;;
    list|ls) list_packs; exit 0 ;;
    --dry-run) DRY_RUN=1; shift ;;
    --with-optional) INCLUDE_OPTIONAL=1; shift ;;
    --en) LANG_CHOICE=en; shift ;;
    --zh) LANG_CHOICE=zh; shift ;;
    --skip-seed) SEED=0; shift ;;
    -*)
      red "Unknown flag: $1"
      usage
      exit 1
      ;;
    *)
      if [[ -z "$PACK_ID" ]]; then
        PACK_ID="$1"
      else
        red "Unexpected arg: $1"
        usage
        exit 1
      fi
      shift
      ;;
  esac
done

if [[ -z "$PACK_ID" ]]; then
  usage
  exit 1
fi

install_pack "$PACK_ID"
