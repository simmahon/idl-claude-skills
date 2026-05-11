# IDL Branded Document — Design System Reference

Upload this file to your Cowork project alongside the project brief.

---

## Fonts

Montserrat (Google Fonts) — weights: 300 light, 400 regular, 500 medium, 700 bold

```html
<link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,300;0,400;0,500;0,700;0,900;1,500&display=swap" rel="stylesheet">
```

## Colours

| Token | Hex | Usage |
|-------|-----|-------|
| `--navy` | `#0E2132` | Cover background, headings, table headers |
| `--blue` | `#393e77` | Secondary accent, sub-headers |
| `--vermillion` | `#DF3918` | Section labels, highlights, FAIL status |
| `--light-bg` | `#F4F4F6` | Card backgrounds, category rows |
| `--white` | `#FFFFFF` | Page backgrounds |
| `--text` | `#2A2A2A` | Body text |
| `--text-light` | `#6B7280` | Descriptions, notes, footers |
| `--border` | `#E5E7EB` | Table borders, dividers |

## Logos

Two logo PNGs are uploaded to this project:
- **Navy background version** — use on the cover page
- **Transparent version** — use in content page headers

Base64-encode both PNGs and embed as `data:image/png;base64,...` in img src attributes so the HTML is fully self-contained.

## Page Frame

Every document is built from `<div class="a4">` blocks — each is exactly 210mm x 297mm (one A4 page).

```css
@page { size: A4; margin: 0; }

.a4 {
  width: 210mm;
  height: 297mm;
  margin: 20px auto;
  background: var(--white);
  position: relative;
  overflow: hidden;
  box-shadow: 0 4px 24px rgba(0,0,0,0.15);
}

@media print {
  body { background: white; }
  .a4 { margin: 0; box-shadow: none; page-break-after: always; }
  .a4:last-child { page-break-after: auto; }
}
```

Content must fit within each page. If it overflows, split into additional `.a4` divs.

## Page Types

### 1. Cover Page
Navy background, gradient orbs (decorative circles), IDL logo top-left, content centred vertically.

```css
.cover {
  width: 100%; height: 100%; background: var(--navy);
  display: flex; flex-direction: column; justify-content: space-between;
  padding: 52px 60px; position: relative; overflow: hidden;
}
.cover::before {
  content: ''; position: absolute; top: -180px; right: -180px;
  width: 600px; height: 600px;
  background: linear-gradient(45deg, #393e77 20%, #DF3918 100%);
  border-radius: 50%; opacity: 0.12;
}
.cover::after {
  content: ''; position: absolute; bottom: -80px; left: -80px;
  width: 350px; height: 350px;
  background: linear-gradient(45deg, #393e77 20%, #DF3918 100%);
  border-radius: 50%; opacity: 0.07;
}
.cover-logo { position: relative; z-index: 1; }
.cover-logo img { height: 44px; }
.cover-content {
  position: relative; z-index: 1; flex: 1;
  display: flex; flex-direction: column; justify-content: center; max-width: 520px;
}
.cover-label {
  font-size: 11px; font-weight: 500; letter-spacing: 3px;
  text-transform: uppercase; color: var(--vermillion); margin-bottom: 20px;
}
.cover-title {
  font-size: 44px; font-weight: 700; color: var(--white);
  line-height: 1.1; margin-bottom: 14px;
}
.cover-subtitle {
  font-size: 16px; font-weight: 300; color: rgba(255,255,255,0.65);
}
.cover-meta {
  position: relative; z-index: 1;
  display: grid; grid-template-columns: repeat(3, 1fr);
  gap: 24px 32px; border-top: 1px solid rgba(255,255,255,0.12); padding-top: 28px;
}
.cover-meta-item label {
  display: block; font-size: 9px; font-weight: 500;
  letter-spacing: 1.5px; text-transform: uppercase;
  color: rgba(255,255,255,0.35); margin-bottom: 4px;
}
.cover-meta-item span {
  font-size: 12px; font-weight: 400; color: var(--white); line-height: 1.4;
}
```

### 2. Content Pages
White background, header bar with logo + doc title + page number, footer.

```css
.content {
  width: 100%; height: 100%; padding: 36px 50px 32px;
  display: flex; flex-direction: column;
}
.page-header {
  display: flex; justify-content: space-between; align-items: center;
  padding-bottom: 12px; margin-bottom: 20px;
  border-bottom: 2px solid var(--navy); flex-shrink: 0;
}
.page-header img { height: 22px; }
.page-header-right { display: flex; align-items: center; gap: 14px; }
.page-header-title {
  font-size: 9px; font-weight: 500; letter-spacing: 1.5px;
  text-transform: uppercase; color: var(--text-light);
}
.page-num {
  font-size: 9px; font-weight: 600; color: var(--navy);
  background: var(--light-bg); width: 22px; height: 22px;
  border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.page-footer {
  margin-top: auto; padding-top: 10px;
  border-top: 1px solid var(--border);
  display: flex; justify-content: space-between;
  font-size: 8px; color: var(--text-light); flex-shrink: 0;
}
```

## Section Headings

```css
.section-number {
  font-size: 9px; font-weight: 700; letter-spacing: 2px;
  text-transform: uppercase; color: var(--vermillion); margin-bottom: 4px;
}
.section-title {
  font-size: 20px; font-weight: 700; color: var(--navy);
  margin-bottom: 4px; line-height: 1.2;
}
.section-desc {
  font-size: 11px; color: var(--text-light); margin-bottom: 16px;
  max-width: 500px; line-height: 1.6;
}
```

## Stage Blocks (for SOPs, sequential processes)

```css
.stage-label {
  font-size: 9px; font-weight: 700; letter-spacing: 1.5px;
  text-transform: uppercase; color: var(--vermillion);
  margin-bottom: 2px; margin-top: 14px;
}
.stage-title {
  font-size: 14px; font-weight: 700; color: var(--navy);
  margin-bottom: 2px; line-height: 1.25;
}
.stage-meta {
  font-size: 9px; color: var(--text-light); margin-bottom: 6px;
}
.stage-meta strong { color: var(--navy); font-weight: 600; }
.stage-desc {
  font-size: 10px; color: var(--text); margin-bottom: 8px; line-height: 1.5;
}
```

## Components

### Card Grid (3-column feature cards)
Use for: key principles, summary stats, inspection overview

```css
.card-grid {
  display: grid; grid-template-columns: repeat(3, 1fr);
  gap: 10px; margin-bottom: 16px;
}
.card { padding: 12px; background: var(--light-bg); border-radius: 5px; }
.card-icon {
  width: 28px; height: 28px;
  background: linear-gradient(45deg, #393e77 20%, #DF3918 100%);
  border-radius: 50%; display: flex; align-items: center; justify-content: center;
  margin-bottom: 8px; color: white; font-size: 13px;
}
.card h5 { font-size: 10px; font-weight: 700; color: var(--navy); margin-bottom: 3px; }
.card p { font-size: 9px; color: var(--text-light); line-height: 1.45; }
```

### Data Table
Use for: test results, defect lists, document registers, any tabular data

```css
.data-table {
  width: 100%; border-collapse: collapse; font-size: 9.5px; margin-bottom: 12px;
}
.data-table thead th {
  background: var(--navy); color: var(--white); font-weight: 500;
  font-size: 8px; letter-spacing: 1px; text-transform: uppercase;
  padding: 4px 8px; text-align: left;
}
.data-table tbody td {
  padding: 3px 8px; border-bottom: 1px solid var(--border); vertical-align: top;
}
.data-table .cat td {
  background: var(--light-bg); font-weight: 700; font-size: 9px;
  color: var(--navy); padding: 3px 8px; border-bottom: none;
}
```

### Info Box (callout)
Use for: critical warnings, key rules, verdicts

```css
.info-box {
  background: var(--light-bg); border-radius: 5px;
  padding: 10px 14px; margin-bottom: 12px;
  border-left: 4px solid var(--vermillion);
}
.info-box h4 { font-size: 10px; font-weight: 700; color: var(--navy); margin-bottom: 4px; }
.info-box p { font-size: 9.5px; color: var(--text-light); line-height: 1.5; }
```

For secondary/informational callouts, override the border colour:
```html
<div class="info-box" style="border-left-color: var(--blue)">
```

### Two-Column Grid
Use for: pass/fail summaries, requirement vs status, side-by-side comparisons

```css
.two-col-grid {
  display: grid; grid-template-columns: 1fr 1fr;
  gap: 8px; margin-bottom: 12px;
}
.grid-card { padding: 10px 14px; border: 1px solid var(--border); border-radius: 5px; }
.grid-card h5 { font-size: 10px; font-weight: 700; color: var(--navy); margin-bottom: 3px; }
.grid-card p { font-size: 9.5px; color: var(--text-light); line-height: 1.45; }
```

### Signature Block
Use for: documents needing sign-off (audit reports, supplier agreements)

```css
.sig-section { padding-top: 20px; border-top: 2px solid var(--navy); }
.sig-section h3 { font-size: 18px; font-weight: 700; color: var(--navy); margin-bottom: 4px; }
.sig-section > p { font-size: 11px; color: var(--text-light); margin-bottom: 24px; }
.sig-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 40px; }
.sig-block h5 {
  font-size: 11px; font-weight: 700; color: var(--navy);
  margin-bottom: 16px; padding-bottom: 6px; border-bottom: 2px solid var(--vermillion);
}
.sig-line { margin-bottom: 16px; }
.sig-line label { display: block; font-size: 9px; font-weight: 500; color: var(--text-light); margin-bottom: 4px; }
.sig-line .line { border-bottom: 1px solid var(--border); height: 28px; }
```

### Bullet Lists

```css
.bullet-list {
  margin: 4px 0 8px 16px; font-size: 9.5px; color: var(--text); line-height: 1.6;
}
.bullet-list li { margin-bottom: 1px; }
```

## Sizing Quick Reference

| Element | Size |
|---------|------|
| Cover title | 44px bold |
| Section title | 20px bold |
| Stage title | 14px bold |
| Body text | 10-11px |
| Table text | 9.5px |
| Table headers | 8px uppercase |
| Footer | 8px |
| Table cell padding | 3-5px |

## PDF Generation

Open the HTML file in Google Chrome, then:
1. Press **Ctrl+P** (Windows) or **Cmd+P** (Mac)
2. Set Destination to **Save as PDF**
3. Set Margins to **None**
4. Tick **Background graphics**
5. Click **Save**

## Spacing Tips

- If content overflows a page, first try reducing padding/margins before adding a new page
- Rate tables with many rows: reduce font-size to 9px and padding to 3px
- Feature cards can be compacted: padding 10px, icon 24px, text 9px
- Terms grid: gap 8px, card padding 10px 14px, text 9.5px
- Always check the last item on every page renders fully
