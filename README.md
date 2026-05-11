<p align="center">
  <img src="assets/repo-banner.png" alt="IDL Branded Documents — Claude Code marketplace for Ideal Direct staff" width="100%" />
</p>

<p align="center">
  <a href="#install-3-steps-7-minutes-total"><img src="https://img.shields.io/badge/install-2_commands-DF3918?style=flat-square&labelColor=0E2132" alt="Install"></a>
  <a href="#daily-use"><img src="https://img.shields.io/badge/onboarding-5_min-393e77?style=flat-square&labelColor=0E2132" alt="Onboarding"></a>
  <a href="#updates"><img src="https://img.shields.io/badge/updates-auto_on_git_push-22c55e?style=flat-square&labelColor=0E2132" alt="Updates"></a>
  <img src="https://img.shields.io/badge/platform-macOS_%7C_Windows-6B7280?style=flat-square&labelColor=0E2132" alt="Platform">
</p>

---

# Ideal Direct — Claude Code Skills

Internal Claude Code marketplace for Ideal Direct staff. Currently distributes one plugin: **`idl-brand-documents`**.

---

## What this gives you

After a one-time install (~30 seconds) and a one-time onboarding interview (~5 minutes), you can generate branded Ideal Direct documents directly from the Claude desktop app or terminal.

Just say something like:

> make me a branded QC report for the Tydi over-door hanger from Ningbo Factory — 50/200 inspected, 2 minor stitching defects

…and you get a fully branded `.html` saved to your local outputs folder, ready to print as PDF.

---

## Install — proven SOP

Each step says *what to do* and *what you should see*. If something doesn't match, stop and message Sim before going further.

### 1. Install the Claude desktop app

**Do:** Download from https://claude.ai/download (Mac or Windows). Sign in once.

**See:** The Claude app opens. Bundled Claude Code is included — no separate installation.

### 2. Open Terminal and paste the install command

**Do:** Press `⌘ + Space`, type `Terminal`, hit Enter. Paste the line below (single line — don't break it). Press Enter.

```
claude plugin marketplace add simmahon/idl-claude-skills && claude plugin install idl-brand-documents@ideal-direct
```

**See (over ~10 seconds):**

```
✔ Successfully added marketplace: ideal-direct
✔ Successfully installed plugin: idl-brand-documents@ideal-direct (scope: user)
```

> **Note:** The Claude desktop app's Code tab does NOT support `/plugin` slash commands — installation must happen in Terminal. Once installed, the skill works identically in both the desktop app's Code tab and the Terminal CLI.

### 3. Verify the install

**Do:** In the Claude desktop app, click **Customize** in the left sidebar. (Quit and reopen the app first with `⌘ + Q` if you had it open during install — forces a re-scan.)

**See:** Under "Personal plugins" → `Idl brand documents` with the toggle switched ON. Click it; the right panel shows the skill registered with `/idl-brand-documents`.

### 4. Run the one-time onboarding

**Do:** Click **Code** at the top → **+ New session** → pick your home folder when prompted. Type:

```
start the IDL onboarding
```

**See:** Claude asks 11 questions (~5 minutes). Answer them, confirm the summary. You're set up.

---

## Daily use

Everything below this line stays inside the Claude desktop app's **Code** tab — no Terminal needed ever again.

Say what you need in plain English. Trigger phrases include "branded document", "branded doc", "QC report", "compliance brief", "label check", "supplier message", "listing check".

Examples:

- *make me a branded QC report for the Tydi over-door hanger from Ningbo Factory — passed inspection, no defects*
- *draft a branded supplier message to Yiwu Factory about Q2 carton labelling*
- *branded label compliance check for our new pest spray for UK and EU — text version of the back panel attached*
- *branded pre-launch compliance brief for the new iMedic blood pressure monitor — UK launch in July*
- *format this QC report for me* (paste raw factory data underneath)

Files save to the location you chose during onboarding (default: `~/Ideal Direct Outputs/{your-role}/{YYYY-MM}/`).

To turn the saved `.html` into a PDF: open it in Google Chrome → **⌘P** (Mac) or **Ctrl+P** (Windows) → Destination: **Save as PDF** → Margins: **None** → Background graphics: **on** → **Save**.

---

## Updates

When we push changes to this repo, the plugin auto-updates on your next Claude Code startup. To force an immediate update:

```
/plugin marketplace update ideal-direct
```

Your interview answers (in `~/.claude/CLAUDE.md`) are kept across updates.

---

## Where things live on your computer

| What | Where |
|---|---|
| The plugin (managed by Claude Code, don't touch) | `~/.claude/plugins/cache/ideal-direct/idl-brand-documents/` |
| Your interview answers (your IDL profile) | `~/.claude/CLAUDE.md` (in an `### IDL profile` block) |
| Your finished documents | The save path you chose during onboarding |

---

## Troubleshooting

| Problem | Fix |
|---|---|
| Terminal says `command not found: claude` | The Claude desktop app isn't installed (or its bundled CLI isn't on PATH). Install from https://claude.ai/download, then re-run the install command. |
| `/plugin ...` typed in Code tab returns "isn't available in this environment" | The Code tab doesn't expose `/plugin` commands. Plugins must be installed via the Terminal CLI (see Step 2). The skill works in the Code tab once installed. |
| Customize panel doesn't show the plugin after install | Quit the Claude app fully (`⌘ + Q`), reopen, check Customize again. The app re-scans plugins on startup. |
| Plugin install fails on Windows with `git: command not found` | Install [Git for Windows](https://git-scm.com/download/win) (free, one-click installer), then re-run the install command. |
| Onboarding asks the same question twice | Quit Claude Code, restart, try again. If it persists, message Sim. |
| Generated file doesn't appear | Read Claude's last message — it tells you the exact path. Most often the save folder hasn't been created yet. |
| Want to re-do onboarding (e.g., role change) | Type: `redo my IDL onboarding`. Claude will overwrite your existing profile. |

If you're stuck for more than a couple of minutes, message Sim with a screenshot.

---

## For maintainers

Repo structure:

```
.
├── README.md
├── .claude-plugin/
│   └── marketplace.json          ← marketplace catalogue
└── plugins/
    └── idl-brand-documents/
        ├── .claude-plugin/
        │   └── plugin.json       ← plugin manifest (version omitted = every commit = new version)
        └── skills/
            └── idl-brand-documents/
                ├── SKILL.md      ← what triggers the skill, what to do
                ├── references/   ← lazy-loaded — design system, brand voice, interview, etc.
                ├── templates/    ← lazy-loaded — one per document type
                └── assets/       ← lazy-loaded — base64 logos
```

To validate locally before pushing: `claude plugin validate .` from the repo root.

To test locally without pushing:
```
/plugin marketplace add ./path/to/this/repo
/plugin install idl-brand-documents@ideal-direct
```
