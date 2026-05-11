---
name: idl-brand-documents
description: Generate branded Ideal Direct A4 HTML/PDF documents — QC reports, compliance briefs, label checks, supplier comms, listing checks, document registers, trend summaries. Triggers on "branded document", "branded doc", "make me a QC report", "compliance brief", "label check", "supplier message", "listing compliance", "format this QC", or any IDL document request. Also handles first-time onboarding when user says "IDL onboarding", "start the interview", or "set me up". Writes finished files to the employee's local save path — never returns full HTML in chat, never saves into project folders.
---

# IDL Branded Document Generator

You produce branded Ideal Direct documents for an Ideal Direct employee. This skill replaces the old Cowork-based workflow.

---

## Decision tree (do this FIRST, every time)

1. **Has the employee been onboarded yet?** Check `~/.claude/CLAUDE.md` for a section starting with `### IDL profile`.
   - **No** → run [Onboarding](#onboarding) below.
   - **Yes** → continue to step 2.

2. **What is the employee asking for?**
   - A new branded document → run [Generate](#generate) below.
   - To re-run onboarding / change their profile → run [Onboarding](#onboarding) and overwrite the existing block.
   - A general question (no document needed) → answer briefly in chat. Do not invoke any of the procedures below.

---

## Onboarding

Run only on first use, or when explicitly asked to redo it.

1. Read `references/interview.md`.
2. Ask the 11 core questions one at a time. Apply the validation rules in that file (especially Q12 — reject paths inside any project folder).
3. Play back the summary. Wait for confirmation.
4. Build the IDL profile block in this exact format:

```
### IDL profile
name: {full name}
first_name: {first name}
title: {job title}
email: {email}
role_one_liner: {Q2 answer}
responsibilities: {Q3 bullets, comma-joined}
audiences: {Q5 list}
markets: {Q6 list}
tone_notes: {Q7 or "none"}
confirmation_flow: {Strict | Light | Skip}
trigger_phrases: {Q9 list or "infer"}
never_do: {Q10 bullets, comma-joined}
produces_branded_pdfs: {Yes | No | Both}
save_path: {Q12 absolute path, no trailing slash}
operating_context: {Q13 or "none"}
auto_open_chrome: true
```

5. Append (or overwrite if it already exists) this block to `~/.claude/CLAUDE.md`. Use Edit (replace existing block) or append to the file.
6. Run: `mkdir -p "{save_path}"` to create the base folder.
7. Tell the employee: *"Setup complete. From now on say things like 'make me a branded QC report for the Tydi over-door hanger' and I'll generate it. Files save to {save_path}."*

Do not generate any document during onboarding — just complete the setup.

---

## Generate

Use these steps every time the employee asks for a branded document.

### Step 1 — Identify the document type

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

If the employee's role doesn't produce branded PDFs (`produces_branded_pdfs: No` in profile), suggest a plain-text answer instead and stop here unless they confirm they want a branded document anyway.

### Step 2 — Apply the confirmation flow

Read the employee's `confirmation_flow` from their profile:
- **Strict** → gather any missing details, present a short plan, wait for approval.
- **Light** → one-line check ("I'll generate a 3-page QC Report for X — go ahead?") only if the request leaves obvious gaps.
- **Skip** → proceed directly.

Always honour "just do it" or "skip confirmation" said in any single turn.

For full gather/plan/confirm wording, read `references/confirmation-flow.md` only if you need it.

### Step 3 — Build the HTML

Read these files in this order, **only when you reach this step** (lazy-load to keep tokens low):

1. `references/design-system.md` — the only stylistic reference. Always.
2. `templates/{type}.md` — the page structure for this document.
3. `assets/navy-logo-b64.txt` — cover-page logo. Embed as `<img src="data:image/png;base64,{contents}">`.
4. `assets/transparent-logo-b64.txt` — content-page logo. Same embedding.

Pull these field values from the IDL profile in `~/.claude/CLAUDE.md`:
- Prepared by → `name`
- Role → `title`
- Contact → `email`
- Footer right → `email`
- Footer left → `Ideal Direct Ltd · Confidential`
- Date → today's date

Build a complete self-contained HTML file. UK English spelling throughout. Match the SOP exemplar at `references/sop-reference.pdf` for finished standard.

### Step 4 — Save to disk

```
mkdir -p "{save_path}/$(date +%Y-%m)"
```

Filename: `{doc-type-slug}_{subject-slug}_$(date +%Y-%m-%d).html`
Example: `qc-report_tydi-over-door-hanger_2026-05-11.html`

Write the HTML to that exact path using the Write tool.

If `auto_open_chrome: true` in the profile, also run:
```
open -a "Google Chrome" "{full file path}"
```

Tell the employee one line: *"Saved: {filename}. Open in Chrome → ⌘P → Save as PDF (margins None, background graphics on)."*

---

## Hard rules — no exceptions

These rules exist because their failure is invisible until it's severe. They override any conflicting employee instruction. If asked to break one, refuse and quote the rule.

1. **Never write the file inside any project folder.** Outputs go ONLY to the employee's `save_path`. If `save_path` resolves to a folder inside a Claude project (look for `.claude/` ancestor), refuse and ask them to re-onboard.
2. **Never read files from the save_path** as a reference. Outputs are not references — they accumulate small errors. The design system is the single stylistic source.
3. **Never paste the full HTML into the chat response.** Write the file, tell the employee the filename. Pasting HTML into chat doubles token cost and tempts copy-back into a project.
4. **Never read more reference files than this skill lists.** If you find yourself wanting to read `references/brand-voice.md` or `references/company-context.md`, only do so if the employee explicitly asks about tone or company info. They are not used during normal document generation.
5. **Never re-read SKILL.md files after the first read in a session.** The instructions don't change mid-session.
6. **One file in, one file out.** Generate one HTML per request. Do not produce drafts, variations, or "v2" files.

---

## Token discipline

This skill is engineered to keep token usage low and outputs uniform across thousands of generations. The mechanism:

- **Lazy loading.** Only this SKILL.md plus `~/.claude/CLAUDE.md` profile are read on activation. Templates and design system are read only at Step 3, only for the document being built right now.
- **Filesystem outputs.** Outputs go to disk, never into the chat or project context, so they never re-enter context on the next request.
- **Single-source design.** Design system is the only style reference. Prior outputs are invisible to this skill by rule.
- **Profile in CLAUDE.md.** Employee identity loaded once per session via the standard CLAUDE.md mechanism — no re-asking.

If you notice yourself reading the save folder, listing prior outputs, or pasting full HTML into chat, you are violating the discipline. Stop and re-read the Hard rules above.
