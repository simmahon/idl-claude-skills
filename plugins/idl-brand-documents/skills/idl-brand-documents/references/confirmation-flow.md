# Confirmation Flow — Gather, Plan, Confirm

*Shared file. The interaction contract followed on every branded output. Owned by Operations.*

Every time you are asked to produce a branded Ideal Direct document, follow this three-step flow before building anything. This applies across every role — QC, Marketing, Buying, Ops, Finance, and any future family.

---

## Why this exists

Branded documents are slow to produce and expensive to rework. A thirty-second check at the start prevents a five-minute rebuild at the end. It also forces the brief to be specific, which makes the output specific — on-voice per `brand-voice.md`.

---

## The three steps

### Step 1 — Gather

Check whether the request has enough detail to produce a correct document. If not, ask. Do not guess.

The role template will give you a **typical gaps for this role** list — the specific things that tend to be missing in requests for that role's outputs. Probe those first.

Generic gaps that apply across every role:

- **What is this about?** — product, brand, campaign, supplier, market, period covered. Name the subject.
- **Who is it for?** — internal team, supplier, Amazon, external auditor, public. Audience changes tone and what goes in the footer.
- **Which brand?** — if the request is ambiguous between brands, ask. Never default.
- **Which market(s)?** — UK, EU, US, or all. Default UK if nothing else is said, but flag the assumption.
- **Deadline or cadence?** — one-off or part of a recurring series.
- **Anything sensitive?** — prior issues, known risks, confidentiality beyond the default.

### Step 2 — Plan

Before building, present a short plan and wait for approval. The plan is:

- **Document type and proposed title** — one line.
- **Page structure** — what goes on each page, named against the design-system components (e.g. "Page 2: card-grid of product details, then data-table of test results").
- **Key content you'll include** — bullet list, two to six items.
- **Assumptions you're making** — anything you decided by default rather than from the brief.
- **Anything you'd recommend adding** based on your domain knowledge — optional, but often valuable.

Keep the plan under 15 lines. It should be quick to read and quick to approve.

### Step 3 — Confirm

Wait for the employee to approve, adjust, or add. Only then build the document. If they reply with changes, incorporate them and either confirm once more (for big changes) or proceed (for small tweaks).

---

## When to keep it light

If the employee's brief is already complete — brand, market, subject, audience, deadline all clear — a one-line check is enough. Format:

> `"I'll create a {pages}-page {document type} for the {subject} — go ahead?"`

Example, QC:
> `"I'll create a 3-page QC Inspection Report for the Tydi over-door hanger from Ningbo Factory — go ahead?"`

Example, Marketing:
> `"I'll draft a 2-page product launch brief for Deer & Oak's new bath pillow targeting Amazon UK — go ahead?"`

Example, Buying:
> `"I'll put together a 2-page supplier shortlist for the Pest X Pro insect trap with UK lead-time and MOQ columns — go ahead?"`

The role template ships with one such example for that role.

## Override — "just do it"

If the employee says **"just do it"**, **"skip confirmation"**, **"no need to confirm"**, **"go ahead"** at the start of a request, skip Steps 1-3 and proceed directly. Respect the override — don't re-ask.

## When in doubt, lean on the gather

A document produced from a thin brief is almost always worse than one produced after a 30-second probe. If you're unsure whether you have enough detail, you don't. Ask.

---

## How this interacts with other shared files

- The **typical-gaps list** in Step 1 comes from the role template (see `role-template-spec.md`, section 8).
- The **tone of the plan and the document** follows `brand-voice.md` — direct, specific, no filler.
- The **component names** used in the Step 2 page structure come from `idl-design-system.md`.
- The **subject-naming discipline** (brand, product, market named explicitly) comes from `brand-voice.md` section 3.

---

## One-paragraph version (to embed in a role template if needed)

> Before producing any branded document, run Gather → Plan → Confirm. In Gather, check whether the brief has what you need to produce a correct document; if not, ask, using the role's typical-gaps list. In Plan, present the document type, page structure, key content, assumptions, and any recommended additions — under 15 lines. In Confirm, wait for approval, then build. If the brief is already complete, a one-line check is enough. If the employee says "just do it", proceed directly.
