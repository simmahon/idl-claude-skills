# Interview — IDL Handover Builder

Ask these 11 core questions one at a time, plus two optional ones. Wait for the answer before moving to the next. Skip optionals if the employee says "I don't know".

Never assume the employee's role. Question 2 is where the role comes from. Every later question adapts to that answer.

Record answers in a working summary. At the end, play back a one-screen summary and ask them to confirm or edit before you generate anything.

---

## Q1 — Identity

**Ask:** "What's your name, work email, and the job title you use on internal docs?"

**Why:** Fills the `Prepared by`, `Role`, `Contact`, and `Footer right` rows of every branded document, plus the `Who you are working with` section.

**Shape:** First name, full name, email, title. Example: *"Katt Navarro, katt@idealdirect.co.uk, QC Specialist."*

**Maps to:** Cowork brief §2 and §8 Document Defaults; `CLAUDE.md` identity line.

---

## Q2 — Role in one line

**Ask:** "In one sentence, what do you do at Ideal Direct? Think of how you'd describe your job to a new hire."

**Why:** This is the master input. It tells you the Role Domain (used in the `# Project: Ideal Direct — <Role Domain>` title) and the one-paragraph `Your role` section. Everything else builds on this.

**Shape:** One or two sentences. Examples:
- *"I'm the QC Specialist — I handle product compliance, label checks, factory QC reports, and supplier follow-ups across all 9 brands."*
- *"I run performance marketing for Pest X Pro and Fly-Bye — Amazon PPC, Meta ads, and monthly reporting for the leadership team."*
- *"I'm the bookkeeper — I handle payables, receivables, VAT returns, and monthly management accounts."*

**Maps to:** Cowork brief title and §3 `Your role`.

---

## Q3 — Responsibilities

**Ask:** "List your main day-to-day and week-to-week responsibilities. Four to eight bullets is fine. Use your own words — don't try to write it like a job description."

**Why:** Fills the `Core responsibilities` section. This is the backbone of the brief.

**Shape:** Bullet list. Examples:
- *"Pre-launch compliance briefs for new products."*
- *"Monthly PPC spend reports for leadership."*
- *"Chase overdue supplier invoices."*
- *"Draft UK/EU CE marking declarations."*

**Maps to:** Cowork brief §4 `Core responsibilities`.

---

## Q4 — Outputs you produce

**Ask:** "What specific things do you regularly create — documents, reports, messages, decks, emails, spreadsheets? For each, give it a name, say who reads it, and roughly what's in it. If you don't produce formal documents, just say so."

**Why:** Drives the `Output Formats` section and the `Prompt triggers` table. Also decides whether the `Branded Document Output` section appears (see Q11). This is where employees describe their own outputs — not where Claude decides for them.

**Shape:** Per output: name, audience, rough shape. Examples:
- *"QC Inspection Report — internal team — cover + 2 pages of test results and defects."*
- *"Monthly PPC Report — leadership — summary, spend table, ROAS by brand, recommendations."*
- *"VAT return checklist — just for me — a checklist I tick through each quarter."*
- *"Supplier payment email — external suppliers — short email confirming a payment has been released."*

**Maps to:** Cowork brief §9 `Output Formats`; `Prompt triggers` table seed.

---

## Q5 — Audiences

**Ask:** "Who do you mainly write for or talk to in your work? Tick as many as apply: internal team, suppliers, factories, Amazon, customers, regulators, press, board, external partners, other."

**Why:** Shapes tone modifiers and the `How to behave` section. Supplier comms need "firm, collaborative"; customer comms need "warm"; board comms need "tight, numbers-first".

**Shape:** Comma-separated list. *"Internal team, suppliers, factories."* or *"Customers and Amazon seller support."*

**Maps to:** Cowork brief §6 `How to behave` tone modifiers.

---

## Q6 — Markets

**Ask:** "Which markets do you work in — UK, EU, US, or others? And are there market-specific rules you follow?"

**Why:** Fills `Markets` section. Flags which regulatory bodies, spelling, currency, and tax rules apply.

**Shape:** List + notes. *"UK primary, EU (mostly Germany and France). UK — UKCA and PSR 2017. EU — CE and GPSR."* or *"UK only."*

**Maps to:** Cowork brief §5 `Markets`; `Important context` §11 where relevant.

---

## Q7 — Tone rules specific to your role

**Ask:** "Ideal Direct's default tone is professional, clear, no jargon, no factory-speak. Is there anything extra for your role — e.g. firm with suppliers, warm with customers, numbers-first with leadership, confidential about pricing? Skip if nothing special."

**Why:** Layers role-specific tone on top of the shared brand voice without overwriting it.

**Shape:** Short bullet list or "nothing specific". *"Firm but collaborative with suppliers. Never casual — we chase money sometimes."*

**Maps to:** Cowork brief §6 `How to behave`.

---

## Q8 — Confirmation flow strictness

**Ask:** "When you ask Claude to build something, should it gather the details and confirm with you first, or just do it? Three settings: **Strict** (always gather + plan + confirm), **Light** (one-line check only if obvious), **Skip** (just do it). Default is Strict — you can say 'just do it' at any time to skip for that one task."

**Why:** Sets the confirmation-flow intensity across the brief. Most roles benefit from Strict. Fast-moving operational roles (customer service, social media) might prefer Light.

**Shape:** Strict / Light / Skip.

**Maps to:** Cowork brief §7 `Confirmation Flow`.

---

## Q9 — Trigger phrases *(optional)*

**Ask:** "Do you want short phrases that trigger specific outputs? For example, Katt says 'format this QC report' and Claude produces a QC Inspection Report. Give me pairs like `phrase → output`. Or skip this and I'll suggest sensible ones based on your outputs — you can edit them later."

**Why:** Speeds up daily use. Not essential — Claude can infer decent defaults from Q4.

**Shape:** Table or list of `phrase → output name` pairs. Or "skip".

**Maps to:** Cowork brief §10 `Prompt triggers`.

---

## Q10 — Things Claude should never do in your role

**Ask:** "Is there anything Claude should never do when helping you? Examples: never quote a price without you confirming, never auto-send an email, never make a compliance claim without citing the source, never post to a brand account. Skip if nothing comes to mind."

**Why:** Fills the `Important context` section and the `Never do` list in `CLAUDE.md`. Catches role-specific guardrails.

**Shape:** Bullet list. *"Never commit a supplier price. Never make a regulatory claim without citing the regulation by number."*

**Maps to:** Cowork brief §11 `Important context`; `CLAUDE.md` Never-do list.

---

## Q11 — Do you produce branded PDFs?

**Ask:** "Do you produce branded Ideal Direct PDF documents — the proper cover-page, A4, navy-header ones — or is your work mostly plain text, emails, spreadsheets, code, or messages? Yes, No, or Both."

**Why:** Decides whether to include §8 `Branded Document Output` and §9 `Output Formats` sections, and whether the README includes branded-document setup. Pure operational roles (customer service, finance bookkeeping) often answer No.

**Shape:** Yes / No / Both.

**Maps to:** Whether Cowork brief §8 and §9 exist; README §1 scope.

---

## Q12 — Where outputs save on your computer

**Ask:** "When Claude finishes a document, where on your computer should the file be saved?

**Rules for this path:**
- It must be a folder **on your own computer** (or a cloud-synced folder you own like Dropbox / iCloud / Google Drive).
- It must be **outside the Cowork project** — Cowork is context only, outputs never go there.
- Use a full path, not 'my documents' or 'the usual place'.

**Default (recommended, say `default` to accept):**
`~/Ideal Direct Outputs/{your-role-slug}/{year-month}/`
e.g. `~/Ideal Direct Outputs/qc/2026-04/` or `~/Ideal Direct Outputs/marketing/2026-04/`

**If you want a custom path, here's what a valid answer looks like:**
- Mac (home folder): `~/Documents/IDL Outputs/` or `/Users/katt/Documents/IDL Outputs/`
- Mac (Dropbox): `~/Dropbox/Ideal Direct/Outputs/` or `/Users/katt/Dropbox/Ideal Direct/Outputs/`
- Mac (iCloud Drive): `~/Library/Mobile Documents/com~apple~CloudDocs/IDL Outputs/`
- Windows: `C:\Users\Katt\Documents\IDL Outputs\` or `C:\Users\Katt\Dropbox\IDL Outputs\`
- Shared drive mapped on Windows: `Z:\Team\IDL Outputs\`

What I need from you: a single folder path in one of the formats above, or the word `default`. If you're not sure, say `default` — we'll go with the recommended path."

**Also say briefly after the question:** "Quick note on how this actually works — in Cowork (the web app), Claude can't save to your computer directly, so it returns the HTML in the chat and you drop it into this folder yourself. In Claude Code on your laptop, it saves to this folder automatically. Either way, this folder is the one place outputs live."

**Why:** Each employee gets a named, agreed location that appears in their brief, CLAUDE.md, and README. Keeps outputs off the Cowork project, off the desktop, off a random Downloads folder. Makes it easy to find old files later.

**Shape:** A full absolute folder path (with `/` or `\`), or the word `default`. Examples above.

**Validation — reject these answers and re-ask:**
- Anything that references the Cowork project ("the project", "in Cowork", "with the context files", "same folder as the brief") — explain the rule and re-ask with the examples.
- A relative path like `./outputs` or `outputs/` without a home or drive root — re-ask for a full path.
- A path inside a Claude Code project directory they already mentioned (risk of context-folder drift if that project is also a Cowork-like context) — gently check: "That folder is inside a project you work in — outputs should live outside any project. Can you name a folder outside it?"
- Vague answers ("somewhere in documents", "wherever") — offer the default again with: "Happy to use the default `~/Ideal Direct Outputs/{role}/{YYYY-MM}/` — say `default` and we'll go with that."

**Maps to:** Cowork brief §6 `How to behave` (output-handling bullet states the path); Cowork brief §8 `Branded Document Output > Where outputs live` (full workflow with their path); `CLAUDE.md` save-path line; README `Where outputs go` section.

---

## Q13 — Operating-context quirks *(optional)*

**Ask:** "Anything unusual about how your work arrives, what you standardise, or the tools you rely on? Examples: 'factory reports come in inconsistent formats and I clean them up', 'I pull data from Amazon Seller Central every Monday', 'I work mostly in Xero and HubSpot'. Skip if nothing notable."

**Why:** Fills the `Important context` section with useful operating nuance. Helps Claude understand the source material it's likely to receive.

**Shape:** Short paragraph or bullets. Or "skip".

**Maps to:** Cowork brief §11 `Important context`.

---

## Summary playback (after all questions)

Play back a one-screen summary in this format. Ask them to confirm or edit anything before you generate.

```
Name: {answer}
Title: {answer}
Email: {answer}
Role in one line: {answer}
Responsibilities: {n bullets}
Outputs: {n items, listed}
Audiences: {list}
Markets: {list}
Tone notes: {answer or "none"}
Confirmation flow: {Strict / Light / Skip}
Trigger phrases: {list or "infer from outputs"}
Never do: {list or "none"}
Branded PDFs: {Yes / No / Both}
Output save location: {path}
Operating context: {answer or "none"}
```

End with: *"Anything to edit before I build your package? Otherwise I'll generate now."*
