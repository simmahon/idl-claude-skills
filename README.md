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

…and you get a fully branded multi-page `.html` saved to your local outputs folder, ready to print as PDF. Like this:

<p align="center">
  <a href="assets/sample-qc-report.html"><img src="assets/sample-qc-cover.png" alt="QC Inspection Report — cover page" width="32%"></a>
  <a href="assets/sample-qc-report.html"><img src="assets/sample-qc-page2.png" alt="QC Inspection Report — inspection summary &amp; test results" width="32%"></a>
  <a href="assets/sample-qc-report.html"><img src="assets/sample-qc-page3.png" alt="QC Inspection Report — defects &amp; corrective actions" width="32%"></a>
</p>

<p align="center"><sub>Real output — three-page A4 QC Inspection Report. <a href="assets/sample-qc-report.html">View the full HTML</a> · open in Chrome → ⌘P / Ctrl+P → Save as PDF.</sub></p>

---

## Install — proven SOP

Each step says *what to do* and *what you should see*. If something doesn't match, stop and message Sim before going further.

### 1. Install the Claude desktop app

**Do:** Download from https://claude.ai/download (Mac or Windows). Sign in once.

**See:** The Claude app opens. Bundled Claude Code is included — no separate installation.

### 2. Open a terminal and paste the install command

**Mac:** Press `⌘ + Space` → type `Terminal` → hit Enter.
**Windows:** Press the `Windows` key → type `PowerShell` → hit Enter.

In the window that opens, paste the line below (single line — don't break it). Press Enter.

```
claude plugin marketplace add simmahon/idl-claude-skills && claude plugin install idl-brand-documents@ideal-direct
```

**See (over ~10 seconds):**

```
✔ Successfully added marketplace: ideal-direct
✔ Successfully installed plugin: idl-brand-documents@ideal-direct (scope: user)
```

> **Windows prerequisite:** Git must be installed. If the install command fails with `git: command not found` or similar, install [Git for Windows](https://git-scm.com/download/win) (free, one-click installer, accept all defaults), then re-run the command. Macs already have git via Xcode Command Line Tools.

> **Note:** The Claude desktop app's Code tab does NOT support `/plugin` slash commands — installation must happen in the terminal. Once installed, the skill works identically in both the desktop app's Code tab and the terminal CLI.

### 3. Verify the install

**Do:** Quit the Claude app fully — **Mac:** `⌘ + Q`. **Windows:** right-click the Claude icon in the system tray (bottom-right) and pick **Quit**, *or* close all Claude windows and end the process from Task Manager. Reopen the app to force a plugin re-scan.

Then click **Customize** in the left sidebar.

**See:** Under "Personal plugins" → `Idl brand documents` with the toggle switched ON. Click it; the right panel shows the skill registered with `/idl-brand-documents`.

### 4. Create your IDL working folder (one time, ~5 seconds)

This is the folder you'll open every time you start a Claude Code session. Keeping it consistent prevents Claude from accidentally loading context from unrelated projects.

**Mac:** Finder → click **Documents** in the sidebar → right-click empty space → **New Folder** → name it `IDL-Claude`.

**Windows:** File Explorer → click **Documents** → right-click empty space → **New** → **Folder** → name it `IDL-Claude`.

> **If you already have a dedicated IDL working folder** (from previous Claude or Cowork work), skip this step and use that folder instead.

### 5. Run the one-time onboarding

**Do:** Click **Code** at the top → **+ New session** → pick the `IDL-Claude` folder you just made (or your existing IDL folder). Type:

```
start the IDL onboarding
```

**See:** Claude asks 11 questions (~5 minutes). Answer them, confirm the summary. You're set up.

> From now on, **always open the same folder** when starting a Claude Code session. This keeps your context clean and your tokens cheap.

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

Files save to the location you chose during onboarding. The default depends on your OS:
- **Mac:** `~/Ideal Direct Outputs/{your-role}/{YYYY-MM}/`
- **Windows:** `C:\Users\{your-username}\Ideal Direct Outputs\{your-role}\{YYYY-MM}\`

To turn the saved `.html` into a PDF: open it in Google Chrome → **⌘P** (Mac) or **Ctrl+P** (Windows) → Destination: **Save as PDF** → Margins: **None** → Background graphics: **on** → **Save**.

### Check or change your profile

Your IDL profile (saved during onboarding) lives at:
- **Mac:** `~/.claude/idl-profile.json`
- **Windows:** `C:\Users\{your-username}\.claude\idl-profile.json`

To inspect or change it without opening any files manually:

- *show my IDL profile* — Claude reads the file and gives you a clean summary
- *redo my IDL onboarding* — runs the 11 questions again and overwrites your profile

---

## Updates

When we push changes to this repo, the plugin auto-updates on your next Claude Code startup. To force an immediate update:

```
/plugin marketplace update ideal-direct
```

Your interview answers (saved at `~/.claude/idl-profile.json`) are kept across updates.

---

## Where things live on your computer

| What | Mac path | Windows path |
|---|---|---|
| The plugin (managed by Claude Code, don't touch) | `~/.claude/plugins/cache/ideal-direct/idl-brand-documents/` | `%USERPROFILE%\.claude\plugins\cache\ideal-direct\idl-brand-documents\` |
| Your interview answers (IDL profile) | `~/.claude/idl-profile.json` | `%USERPROFILE%\.claude\idl-profile.json` |
| Your IDL working folder (session) | `~/Documents/IDL-Claude/` | `%USERPROFILE%\Documents\IDL-Claude\` |
| Your finished documents | The save path you chose during onboarding | The save path you chose during onboarding |

> **Tip:** In Windows File Explorer, paste `%USERPROFILE%\.claude` into the address bar to jump to the hidden Claude config folder. On Mac, in Finder press `⌘ + Shift + G` and paste `~/.claude`.

---

## Troubleshooting

| Problem | Fix |
|---|---|
| Terminal/PowerShell says `command not found: claude` (or `'claude' is not recognized`) | The Claude desktop app isn't installed, or its bundled CLI isn't on PATH. Install from https://claude.ai/download, then re-run. On Windows you may need to **sign out and back in** (or restart) after installing for PATH to update. |
| `/plugin ...` typed in Code tab returns "isn't available in this environment" | The Code tab doesn't expose `/plugin` commands. Plugins must be installed via the terminal CLI (see Step 2). The skill works in the Code tab once installed. |
| Customize panel doesn't show the plugin after install | Quit the Claude app fully (Mac: `⌘ + Q`. Windows: right-click tray icon → Quit), reopen, check Customize again. The app re-scans plugins on startup. |
| Install fails with `git: command not found` (or `'git' is not recognized` on Windows) | **Windows:** install [Git for Windows](https://git-scm.com/download/win) (free, one-click installer, accept defaults), then re-run. **Mac:** when prompted, click Install to get Xcode Command Line Tools. |
| PowerShell shows a security warning when you paste the install command | Windows sometimes gates pasted commands. Just accept (Y) or paste again. If it blocks execution policy, run PowerShell as Administrator and try again. |
| Onboarding asks the same question twice | Quit Claude Code, restart, try again. If it persists, message Sim. |
| Generated file doesn't appear | Read Claude's last message — it tells you the exact path. Most often the save folder hasn't been created yet. |
| Want to re-do onboarding (e.g. role change) | Type: `redo my IDL onboarding`. Claude will overwrite your existing profile. |
| File paths look wrong on Windows (`~/something`) | The `~` shorthand is Mac/Linux. On Windows it expands to `C:\Users\{your-username}\`. Modern tools usually translate it automatically; if not, type the full Windows path. |

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
