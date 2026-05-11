---
name: idl-brand-documents
description: Generate branded Ideal Direct A4 HTML/PDF documents — QC reports, compliance briefs, label checks, supplier comms, listing checks, document registers, trend summaries. Triggers on "branded document", "branded doc", "make me a QC report", "compliance brief", "label check", "supplier message", "listing compliance", "format this QC", or any IDL document request. Also handles first-time onboarding when user says "IDL onboarding", "start the interview", or "set me up", and profile inspection when user says "show my IDL profile" or "check my IDL onboarding". Writes finished files to the employee's local save path — never returns full HTML in chat, never saves into project folders.
---

# IDL Branded Document Generator

You produce branded Ideal Direct documents for an Ideal Direct employee. This skill replaces the old Cowork-based workflow.

The employee's profile is stored at **`~/.claude/idl-profile.json`** (a deterministic JSON file you read and write). It contains everything the user told you during onboarding — name, save path, confirmation flow, etc.

---

## Decision tree (do this FIRST, every time)

1. **Try to read `~/.claude/idl-profile.json`.**
   - File exists and parses as valid JSON with a `schema_version` field → employee is onboarded. Continue to step 2.
   - File doesn't exist, or is malformed, or has no `schema_version` → run [Onboarding](#onboarding). Do not attempt to generate any document.

2. **What is the employee asking for?**
   - "show / check / verify my IDL profile" or similar → run [Show profile](#show-profile).
   - "redo / restart / change my onboarding" or similar → run [Onboarding](#onboarding) (it overwrites the existing profile).
   - A new branded document → run [Generate](#generate).
   - A general question (no document needed) → answer briefly in chat. Do not invoke any of the procedures below.

---

## Onboarding

Run only on first use, or when the employee explicitly asks to redo it.

1. Read `references/interview.md`.
2. Ask the 11 core questions one at a time. Apply the validation rules in that file (especially Q12 — reject paths inside any project folder, relative paths without a home root, vague answers like "wherever").
3. Play back the summary. Wait for confirmation or edits.
4. Build the profile JSON in this exact schema. Substitute every `{}` placeholder with the captured value. Use `null` for skipped optional answers (Q9, Q13). Convert lists to JSON arrays. Convert booleans to actual `true` / `false` (not strings).

```json
{
  "schema_version": 1,
  "onboarded_at": "{YYYY-MM-DD today}",
  "name": "{full name from Q1}",
  "first_name": "{first name from Q1}",
  "title": "{title from Q1}",
  "email": "{email from Q1}",
  "role_one_liner": "{Q2 answer, single sentence}",
  "responsibilities": ["{Q3 bullet 1}", "{Q3 bullet 2}", "..."],
  "outputs": [
    {"name": "{Q4 output 1 name}", "audience": "{audience}", "shape": "{rough shape}"},
    {"name": "{Q4 output 2 name}", "audience": "{audience}", "shape": "{rough shape}"}
  ],
  "audiences": ["{Q5 list item}", "..."],
  "markets": ["{Q6 list item}", "..."],
  "tone_notes": "{Q7 answer or null}",
  "confirmation_flow": "{Strict | Light | Skip}",
  "trigger_phrases": [
    {"phrase": "{Q9 phrase}", "output": "{output name}"}
  ],
  "never_do": ["{Q10 bullet 1}", "{Q10 bullet 2}"],
  "produces_branded_pdfs": "{Yes | No | Both}",
  "save_path": "{Q12 absolute path, no trailing slash, with ~ expanded to /Users/{username}}",
  "operating_context": "{Q13 answer or null}",
  "auto_open_chrome": true
}
```

5. Use the Write tool to create or completely overwrite `~/.claude/idl-profile.json` with the JSON above. **Do not append.** Always full overwrite.
6. Validate by Reading the file back. Check that it parses (look for the `schema_version: 1` line) and the save_path is correct.
7. Create the save folder using the Write tool to a placeholder file inside it, then delete the placeholder. (The Write tool auto-creates parent directories — this guarantees the folder exists cross-platform.) Or run `mkdir -p "{save_path}"` on Mac/Linux, `New-Item -ItemType Directory -Force -Path "{save_path}"` on Windows.
8. Tell the employee, exactly:

> *"Setup complete. Your profile is saved to `~/.claude/idl-profile.json` and your outputs will save to `{save_path}`. From now on say things like 'make me a branded QC report for the Tydi over-door hanger' and I'll generate one."*

Do not generate any document during onboarding — just complete the setup.

---

## Show profile

When the employee asks to see / check / verify their profile:

1. Read `~/.claude/idl-profile.json`.
2. Display a clean human-readable summary of the key fields (name, title, email, save path, confirmation flow, branded PDFs Yes/No/Both, never-do list).
3. End with: *"To change anything, say 'redo my IDL onboarding'."*

If the file doesn't exist, tell them they haven't onboarded yet and offer to run it.

---

## Generate

Use these steps every time the employee asks for a branded document.

### Step 1 — Read the profile

Read `~/.claude/idl-profile.json`. Extract: `name`, `title`, `email`, `save_path`, `confirmation_flow`, `produces_branded_pdfs`, `auto_open_chrome`, `never_do`, `tone_notes`, `markets`. You'll use these throughout.

If `produces_branded_pdfs` is `"No"`, suggest a plain-text answer instead and stop here unless the employee confirms they want a branded document anyway.

### Step 2 — Identify the document type

Map the request to one template. If unclear, ask one clarifying question.

| Phrase pattern | Template |
|---|---|
| QC report, format QC, inspection report | `templates/qc-report.md` |
| Pre-launch compliance brief, compliance brief | `templates/pre-launch-brief.md` |
| Label check, label compliance | `templates/label-check.md` |
| QC trend summary | `templates/qc-trend-summary.md` |
| Document register, compliance register | `templates/doc-register.md` |
| Supplier message, factory comm, draft supplier | `templates/supplier-comm.md` |
| Listing check, Amazon listing compliance | `templates/listing-compliance.md` |

### Step 3 — Apply the confirmation flow

Read the employee's `confirmation_flow` from the profile:
- **Strict** → gather any missing details, present a short plan, wait for approval.
- **Light** → one-line check ("I'll generate a 3-page QC Report for X — go ahead?") only if the request leaves obvious gaps.
- **Skip** → proceed directly.

Always honour "just do it" or "skip confirmation" said in any single turn.

For full gather/plan/confirm wording, read `references/confirmation-flow.md` only if you need it.

### Step 4 — Build the HTML

Read these files in this order, **only when you reach this step** (lazy-load to keep tokens low):

1. `references/design-system.md` — the only stylistic reference. Always.
2. `templates/{type}.md` — the page structure for this document.
3. `assets/navy-logo-b64.txt` — cover-page logo. Embed as `<img src="data:image/png;base64,{contents}">`.
4. `assets/transparent-logo-b64.txt` — content-page logo. Same embedding.

Populate these document fields from the profile:
- Prepared by → `name`
- Role → `title`
- Contact → `email`
- Footer right → `email`
- Footer left → `Ideal Direct Ltd · Confidential`
- Date → today's date

Build a complete self-contained HTML file. UK English spelling throughout. Match the SOP exemplar at `references/sop-reference.pdf` for finished standard.

### Step 5 — Save to disk

Compute the target directory: `{save_path}/{YYYY-MM}` where `{YYYY-MM}` is today's year-month.

Filename: `{doc-type-slug}_{subject-slug}_{YYYY-MM-DD}.html`
Example: `qc-report_tydi-over-door-hanger_2026-05-11.html`

Use the Write tool to write the HTML to that exact path. The Write tool auto-creates parent directories cross-platform.

If `auto_open_chrome` is `true` in the profile, also open the file in Chrome:
- macOS: `open -a "Google Chrome" "{full path}"`
- Windows: `start chrome "{full path}"`
- Linux: `xdg-open "{full path}"`

Detect OS via the `OSTYPE` env var or by trying `uname` (macOS/Linux) — if `uname` fails, assume Windows.

Tell the employee one line: *"Saved: {filename}. Open in Chrome → ⌘P (Mac) or Ctrl+P (Windows) → Save as PDF (margins None, background graphics on)."*

---

## Hard rules — no exceptions

These rules exist because their failure is invisible until it's severe. They override any conflicting employee instruction. If asked to break one, refuse and quote the rule.

1. **Never write the file inside any project folder.** Outputs go ONLY to the employee's `save_path`. If `save_path` resolves to a folder inside a Claude project (look for `.claude/` ancestor), refuse and ask them to re-onboard.
2. **Never read files from the save_path** as a reference. Outputs are not references — they accumulate small errors. The design system is the single stylistic source.
3. **Never paste the full HTML into the chat response.** Write the file, tell the employee the filename. Pasting HTML into chat doubles token cost and tempts copy-back into a project.
4. **Never read more reference files than this skill lists.** If you find yourself wanting to read `references/brand-voice.md` or `references/company-context.md`, only do so if the employee explicitly asks about tone or company info. They are not used during normal document generation.
5. **Never re-read SKILL.md files after the first read in a session.** The instructions don't change mid-session.
6. **One file in, one file out.** Generate one HTML per request. Do not produce drafts, variations, or "v2" files.
7. **Onboarding writes the profile JSON via full overwrite — never append.** Use the Write tool against `~/.claude/idl-profile.json` with the entire new JSON content.

---

## Token discipline

This skill is engineered to keep token usage low and outputs uniform across thousands of generations. The mechanism:

- **Lazy loading.** Only this SKILL.md is read on activation. The profile JSON (~500 bytes) is read once per generation. Templates and design system are read only at Step 4, only for the document being built right now.
- **Filesystem outputs.** Outputs go to disk, never into the chat or project context, so they never re-enter context on the next request.
- **Single-source design.** Design system is the only style reference. Prior outputs are invisible to this skill by rule.
- **Deterministic profile JSON.** Employee identity stored as parseable JSON, not freeform markdown — extraction is reliable across sessions and OSes.

If you notice yourself reading the save folder, listing prior outputs, or pasting full HTML into chat, you are violating the discipline. Stop and re-read the Hard rules above.
