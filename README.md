# Ideal Direct — Claude Code Skills

Internal Claude Code marketplace for Ideal Direct staff. Currently distributes one plugin: **`idl-brand-documents`**.

---

## What this gives you

After a one-time install (~30 seconds) and a one-time onboarding interview (~5 minutes), you can generate branded Ideal Direct documents directly from the Claude desktop app or terminal.

Just say something like:

> make me a branded QC report for the Tydi over-door hanger from Ningbo Factory — 50/200 inspected, 2 minor stitching defects

…and you get a fully branded `.html` saved to your local outputs folder, ready to print as PDF.

---

## Install (3 steps, ~7 minutes total)

### 1. Install the Claude desktop app
Get it from https://claude.ai/download (Mac or Windows). The app includes Claude Code built in — no separate installation required.

Sign in once.

### 2. Install this skill
Open the Claude app → click the **Code** tab at the top → start a new session → in the chat box, type these two commands one after the other:

```
/plugin marketplace add simmahon/idl-claude-skills
```

```
/plugin install idl-brand-documents@ideal-direct
```

That's it. The skill is installed forever and updates automatically when we push changes.

### 3. Run the one-time onboarding
Still in the same Claude Code session, type:

```
start the IDL onboarding
```

Claude asks 11 questions (~5 minutes). Confirm the summary at the end. You're set up.

---

## Daily use

Open the Claude app's **Code** tab and say what you need in plain English. Trigger phrases include "branded document", "branded doc", "QC report", "compliance brief", "label check", "supplier message", "listing check".

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
| `/plugin marketplace add` says "command not found" | You're using the regular Claude chat, not the Code tab. Click the **Code** tab at the top of the Claude desktop app, start a new session, then try again. |
| Marketplace adds but Claude doesn't recognise "branded document" | Run `/plugin install idl-brand-documents@ideal-direct` to install the plugin from the marketplace. Adding the marketplace alone doesn't install plugins. |
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
