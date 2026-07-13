#!/usr/bin/env bash
# install-demo.sh — scaffold ~/.hermes/daily and optionally register the AI News cron job.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATA_HOME="${HERMES_DAILY_HOME:-${HOME}/.hermes/daily}"
LANG_CHOICE="${HERMES_DAILY_LANG:-zh}"   # zh | en
CREATE_CRON="${HERMES_DAILY_CREATE_CRON:-ask}"  # ask | yes | no
TODAY="$(date +%Y-%m-%d)"

blue()  { printf '\033[1;34m%s\033[0m\n' "$*"; }
green() { printf '\033[1;32m%s\033[0m\n' "$*"; }
yellow(){ printf '\033[1;33m%s\033[0m\n' "$*"; }
red()   { printf '\033[1;31m%s\033[0m\n' "$*"; }

blue "==> Hermes Daily Automation — demo installer"
echo "    repo:  $ROOT"
echo "    data:  $DATA_HOME"
echo "    lang:  $LANG_CHOICE"
echo

# --- directories -----------------------------------------------------------
JOBS=(
  ai-news learning interview thinking finance english
  github-digest tweet-draft code-reading topic-study daily-review
)

for j in "${JOBS[@]}"; do
  mkdir -p "${DATA_HOME}/${j}/history"
done

# --- seed plans (do not overwrite existing) --------------------------------
stamp_day1() {
  # Portable in-place Day 1 substitution (macOS/Linux)
  local file="$1"
  python3 -c "
import re, pathlib
p = pathlib.Path(r'''${file}''')
t = p.read_text(encoding='utf-8')
t2 = t.replace('Day 1 = YYYY-MM-DD', 'Day 1 = ${TODAY}')
t2 = re.sub(r'Day 1 = set this to your install date.*', 'Day 1 = ${TODAY}', t2)
if t2 != t:
    p.write_text(t2, encoding='utf-8')
"
}

seed() {
  local src="$1" dest="$2"
  if [[ -f "$dest" ]]; then
    echo "    keep  $dest"
  else
    cp "$src" "$dest"
    stamp_day1 "$dest"
    echo "    seed  $dest"
  fi
}

seed "${ROOT}/data/learning/plan.md"      "${DATA_HOME}/learning/plan.md"
seed "${ROOT}/data/finance/plan.md"       "${DATA_HOME}/finance/plan.md"
seed "${ROOT}/data/code-reading/plan.md"  "${DATA_HOME}/code-reading/plan.md"
seed "${ROOT}/data/topic-study/plan.md"   "${DATA_HOME}/topic-study/plan.md"

# interview start date marker
if [[ ! -f "${DATA_HOME}/interview/START_DATE" ]]; then
  echo "$TODAY" > "${DATA_HOME}/interview/START_DATE"
  echo "    seed  ${DATA_HOME}/interview/START_DATE"
fi

# optional memory file
touch "${DATA_HOME}/MEMORY.md"

# pointer for humans
cat > "${DATA_HOME}/README.md" <<EOF
# Hermes Daily data root

Created by hermes-daily-automation on ${TODAY}.

- Edit plans under \`*/plan.md\`
- Jobs append to \`*/history/\`
- Nightly review may update \`MEMORY.md\`

Repo: ${ROOT}
EOF

green "==> Data layout ready under ${DATA_HOME}"

# --- config hint -----------------------------------------------------------
if [[ ! -f "${HOME}/.hermes/config.yaml" ]]; then
  yellow "==> No ~/.hermes/config.yaml found"
  echo "    If this is a fresh Hermes install:"
  echo "      cp \"${ROOT}/config-template.yaml\" ~/.hermes/config.yaml"
  echo "      # then set provider/model + messaging via hermes setup"
fi

# --- pick prompt -----------------------------------------------------------
if [[ "$LANG_CHOICE" == "en" ]]; then
  PROMPT_FILE="${ROOT}/cron-jobs/en/ai-news.md"
else
  PROMPT_FILE="${ROOT}/cron-jobs/ai-news.md"
fi

if [[ ! -f "$PROMPT_FILE" ]]; then
  red "Prompt file missing: $PROMPT_FILE"
  exit 1
fi

# --- cron registration -----------------------------------------------------
create_cron() {
  if ! command -v hermes >/dev/null 2>&1; then
    yellow "==> hermes CLI not on PATH — skip cron create"
    echo "    Install: https://github.com/NousResearch/hermes-agent"
    echo "    Then run:"
    echo "      hermes cron create \"0 8 * * *\" --name \"AI News Demo\" --prompt \"\$(cat \"$PROMPT_FILE\")\""
    return 0
  fi

  blue "==> Registering demo cron: AI News (daily 08:00 local)"
  hermes cron create "0 8 * * *" --name "AI News Demo" --prompt "$(cat "$PROMPT_FILE")"
  green "==> Cron created. List with: hermes cron list"
  echo
  echo "    Test once now:"
  echo "      hermes cron list"
  echo "      hermes cron run <job_id>"
  echo
  echo "    Example output shape: ${ROOT}/examples/ai-news-sample.md"
}

case "$CREATE_CRON" in
  yes|YES|true|1)
    create_cron
    ;;
  no|NO|false|0)
    yellow "==> Skipping cron create (HERMES_DAILY_CREATE_CRON=no)"
    echo "    Manual:"
    echo "      hermes cron create \"0 8 * * *\" --name \"AI News Demo\" --prompt \"\$(cat \"$PROMPT_FILE\")\""
    ;;
  *)
    if [[ -t 0 ]]; then
      read -r -p "Register AI News demo cron now? [Y/n] " ans
      ans="${ans:-Y}"
      if [[ "$ans" =~ ^[Yy]$ ]]; then
        create_cron
      else
        yellow "Skipped cron create."
      fi
    else
      yellow "==> Non-interactive shell — skip cron create"
      echo "    Re-run with HERMES_DAILY_CREATE_CRON=yes to register."
    fi
    ;;
esac

# --- skills install --------------------------------------------------------
INSTALL_SKILLS="${HERMES_DAILY_INSTALL_SKILLS:-ask}"  # ask | yes | no
install_skills() {
  if [[ -x "${ROOT}/scripts/install-skills.sh" ]]; then
    blue "==> Installing Agent Skills into ~/.hermes/skills"
    "${ROOT}/scripts/install-skills.sh"
  else
    yellow "install-skills.sh missing — skip"
  fi
}

case "$INSTALL_SKILLS" in
  yes|YES|true|1) install_skills ;;
  no|NO|false|0)
    yellow "==> Skipping skills install (HERMES_DAILY_INSTALL_SKILLS=no)"
    echo "    Later: ${ROOT}/scripts/install-skills.sh"
    ;;
  *)
    if [[ -t 0 ]]; then
      read -r -p "Install Progressive Cron skills into ~/.hermes/skills? [Y/n] " sans
      sans="${sans:-Y}"
      if [[ "$sans" =~ ^[Yy]$ ]]; then
        install_skills
      else
        yellow "Skipped skills install."
      fi
    else
      yellow "==> Non-interactive — skip skills install (set HERMES_DAILY_INSTALL_SKILLS=yes)"
    fi
    ;;
esac

echo
green "Done. Next steps:"
echo "  1. Open ${DATA_HOME}/learning/plan.md and customize"
echo "  2. Read Progressive Cron: ${ROOT}/skills/content-progression/SKILL.md"
echo "  3. Browse examples/: ${ROOT}/examples/"
echo "  4. hermes skills list  # after install-skills"
echo "  5. Star the repo if this saved you time ⭐"
echo
