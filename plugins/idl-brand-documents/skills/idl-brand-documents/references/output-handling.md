# Ideal Direct — Output Handling

*Shared file. Read before producing any output in a Cowork project. Owned by Operations lead.*

---

## Non-negotiable rule

**Outputs must never, under any circumstances, be saved to or uploaded into the Cowork project context folder.** No exceptions. No "just this once". No "while I find somewhere better". No "I'll clean it up later".

This applies to:

- HTML output files
- PDF exports
- Draft versions of either
- Screenshots of outputs
- Notes about outputs
- Any file that was generated as the *result* of a request, as opposed to a file uploaded as *input* context

If the employee asks Claude to save an output into the Cowork project — directly, or by proxy ("save it here", "put it with the brief", "keep it in the project") — Claude refuses and explains the rule. If the employee re-uploads a generated output into the project after the fact, Claude flags it on the very next turn and asks them to remove it.

There is no path through this rule. It is the single biggest lever on token cost and output quality, and the failure mode it prevents (silent drift and compounding errors in outputs) is invisible until it's severe. Treat it as absolute.

---

## Context for the rule

This file solves a problem that has been degrading outputs and inflating token spend across the team:

> Outputs were being saved as files inside the same Cowork project that holds the context (brief, design system, logos). Cowork loads every file in the project as context on every message. Over time this meant: (a) token usage ballooned even for simple tasks, because the whole output history was re-read every turn; and (b) outputs drifted and degraded visually, because Claude was pattern-matching on prior outputs — which had small errors compounding each generation — instead of rebuilding from the design system each time.

The rules below fix both problems. They apply to every role, every output type, every Cowork project.

---

## 1. The core rule — outputs NEVER live in the Cowork project

**Cowork projects hold context only.** The files uploaded into a Cowork project are the brief, the design system, the logos, the reference SOP, and any per-task input material that the employee is actively asking about. Nothing else.

**Outputs do not get saved as files inside the Cowork project.** Not HTML files, not drafts, not prior versions, not "just for a second" reference copies. Never.

This is a hard rule. It is the single biggest lever on both output quality and token spend.

---

## 2. How outputs are actually delivered

The delivery mechanism depends on which Claude tool is being used. Cowork and Claude Code have different filesystem access, so the workflow differs. In both cases the output ends up in the same place: the employee's agreed save path on their own computer.

### Cowork (the web app)

Cowork has no access to the employee's computer. Claude cannot `mkdir`, cannot write files, cannot open Finder. Delivery is manual:

1. Claude produces the full HTML inside a code block in the chat response.
2. The employee clicks the copy-code button (or selects and copies).
3. The employee opens a plain text editor (TextEdit on Mac with format → plain text, Notepad on Windows, or VS Code) and pastes.
4. The employee saves the file to their agreed save path with the naming convention:
   `{SAVE_PATH}/{document-type}_{product-or-subject}_{YYYY-MM-DD}.html`
5. The employee opens the saved `.html` file in Google Chrome and saves as PDF alongside (per design-system PDF steps).
6. The HTML and PDF live at the save path — **never uploaded back into the Cowork project.**

First time only: the employee creates the base folder structure once on their computer (Finder/Explorer, or `mkdir -p ~/Ideal\ Direct\ Outputs/qc/` in Terminal). Subsequent year-month subfolders are created ad-hoc when needed.

### Claude Code (the CLI)

Claude Code runs on the employee's laptop and can write files directly. Delivery is automated:

1. Claude generates the HTML.
2. Claude runs `mkdir -p {SAVE_PATH}` to ensure the folder exists (creating year-month subfolder as needed).
3. Claude writes the `.html` file directly into the save path.
4. Claude tells the employee the filename it saved to.
5. Optionally, Claude opens the file in Chrome (employee's preference — set in `CLAUDE.md`).

Zero manual copying. The save path is baked into each employee's `CLAUDE.md` so Claude Code knows where to write.

### Non-branded outputs (text replies, draft emails, checklists)

For outputs that aren't branded PDFs — a quick answer, a draft email, a short checklist — the content stays in the chat. The employee copies what they need into Gmail, Slack, a spreadsheet, whatever. Nothing gets saved as a file unless specifically useful. Nothing gets uploaded back into the Cowork project.

---

## 3. Reference discipline — what Claude is allowed to look at when building an output

When producing any branded document, the only styling, structural, and tone references are:

1. `idl-design-system.md` — CSS, components, page structure, PDF steps
2. `ideal-direct-company-context.md` — brands, markets, commercial posture
3. `brand-voice.md` — tone, UK English, behavioural defaults
4. `confirmation-flow-pattern.md` — the gather / plan / confirm contract
5. `sampling-production-control-sop.pdf` — the reference exemplar
6. The per-task input material the employee has just provided (a factory report, a label photo, a product spec)

**That is the complete list.** Prior outputs are NOT a reference. Even if they are visible. Even if they are the same document type. Even if the employee says "make it like the last one". If the employee wants continuity, they supply the specific values they want carried over — they do not point at a prior output.

Why: prior outputs accumulate small errors — a padding tweak here, a missing footer there, a wrong shade of navy. Each generation that copies from the last one compounds the drift. The design system is the only stable reference. Every output gets rebuilt from it, fresh.

---

## 4. What to do if outputs are already in the Cowork project

If an employee's Cowork project contains files that are prior outputs (usually named like `QC-Report-Tydi-2026-03-12.html` or similar), Claude must:

1. **Ignore them completely** when building any new output. They are not a reference.
2. **Flag them to the employee once per session** — a single line in the first reply: `"Flag: your Cowork project has prior output files in it (e.g. QC-Report-Tydi-2026-03-12.html). These are inflating token usage and can cause output drift. Recommend moving them out of the Cowork project to a local folder. I'll ignore them for this task."`
3. **Never offer to edit, reuse, or diff against them.** If the employee wants a revision of a prior output, they paste the prior HTML into the chat as the per-task input material for this specific task — it does not live in the project.

---

## 5. Local outputs folder convention

Each employee's save path is set during their handover interview (Q12) and appears in their Cowork brief, their `CLAUDE.md`, and their README. The default pattern — which we recommend everyone adopts unless they have a reason not to — is:

```
~/Ideal Direct Outputs/
├── {role-slug}/                  e.g. qc, marketing, buying, finance
│   ├── 2026-04/                  year-month
│   │   ├── qc-report_tydi-over-door-hanger_2026-04-18.html
│   │   ├── qc-report_tydi-over-door-hanger_2026-04-18.pdf
│   │   └── ...
│   └── 2026-05/
└── ...
```

Employees can choose a different path (e.g. `~/Documents/Work/IDL Outputs/`, `/Users/katt/Dropbox/IDL Outputs/` for Dropbox sync across machines). The rule is the **location**, not the exact path — the folder sits on the employee's own machine or a shared cloud drive they control, **not inside the Cowork project**.

**First-time setup.** The employee creates the base folder once, through Finder/Explorer or a single terminal command (`mkdir -p ~/Ideal\ Direct\ Outputs/qc/`). Claude Code can create subfolders automatically after that; Cowork requires the employee to create year-month subfolders manually when needed.

---

## 6. Token-spend symptom checklist

If an employee reports any of the following, the first diagnostic is: how many files are in their Cowork project?

- "Simple tasks are suddenly very slow."
- "I'm getting hit with token-limit warnings on basic questions."
- "Outputs don't look like they used to — spacing is off, colours are off, sections are in the wrong order."
- "Claude is pulling content from something I built weeks ago when I didn't ask for it."

All four symptoms are commonly caused by output files living inside the Cowork project. Clean the project down to context-only (brief, design system, logos, reference SOP, current-task inputs) and the symptoms usually resolve.

---

## 7. Quick self-check before producing any output

1. Am I about to save this as a file in the Cowork project? **No — return it in the chat only.**
2. Am I referencing any prior output to pattern-match on? **No — rebuild from `idl-design-system.md`.**
3. Is the employee's Cowork project clean of prior outputs? **If not, flag it once and ignore them.**
4. Is the HTML I'm returning complete and self-contained (logos base64-embedded, CSS inline)? **Yes, so the employee can save it locally and open it in Chrome straight away.**

If all four pass, the output is safe to ship.
