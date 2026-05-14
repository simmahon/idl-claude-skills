---
name: goal
description: Set a completion condition; Claude keeps working until met without handing back. Emulates the built-in /goal command (https://code.claude.com/docs/en/goal) for environments where it isn't available — like the Claude desktop Code tab or Claude Code < 2.1.x. Triggers on `/goal`, `/goal <condition>`, `/goal clear`, `/goal stop`.
---

# /goal — keep working toward a completion condition

Set a completion condition. Claude keeps working in one long response —
across tool calls, reasoning steps, sub-agent spawns — until the condition
holds, instead of stopping at the first plausible "I think I'm done."

This skill emulates the built-in `/goal` command documented at
<https://code.claude.com/docs/en/goal>. **If the built-in is available in
the current environment, prefer it** — the built-in uses a separate evaluator
model on each turn boundary, which is more rigorous than in-turn self-evaluation.
This skill only runs when the user explicitly invokes it (typically because
they're in an environment where the built-in isn't present, such as the
Claude desktop Code tab on Claude Code below 2.1.x).

## Arguments

| Invocation | Behaviour |
|---|---|
| `/goal <condition>` | Set or replace the active goal. Start work immediately in the same response. |
| `/goal` | Print the current goal status. |
| `/goal clear` (or `stop`, `off`, `reset`, `none`, `cancel`) | Clear the active goal. |

## Goal state file

The active goal lives at `.claude/active-goal.md` in the current working
directory. Create the `.claude/` directory if it doesn't exist. Add the
file to `.gitignore` if `.gitignore` exists and doesn't already exclude it.

Format:

```markdown
---
condition: <one-line summary of the condition>
started_at: <ISO 8601 timestamp>
iterations: <integer, starts at 0>
status: active        # active | blocked | complete | cleared
last_evaluation: <free text — the most recent evaluator reasoning>
---

# Active goal

<full condition text, can span multiple paragraphs>
```

## Behaviour on `/goal <condition>` (set)

1. Parse the condition (everything after `/goal `). Up to 4,000 characters.
   If empty or whitespace-only, treat as the status-check case.
2. Write `.claude/active-goal.md` with the condition, `started_at` = now,
   `iterations` = 0, `status` = active.
3. Ensure `.claude/active-goal.md` is gitignored (add to project `.gitignore`
   if not already excluded).
4. **Do not hand back to the user yet.** Begin work on the condition
   immediately in the same response. Treat the condition itself as the
   directive.
5. After each substantive action (tool call, sub-agent return, or major
   reasoning step), perform an in-turn self-evaluation. See **Evaluator
   loop** below.

## Evaluator loop

After each iteration:

1. **Does the condition demonstrably hold** based on the state of the
   codebase, the artifacts produced, the verification commands run, or the
   visual evidence you've gathered? Be honest — sycophantic
   self-evaluation defeats the point of /goal. If you wrote the test and
   it now passes, that's evidence. If you haven't run any verification,
   you don't know yet.
2. **Are you blocked on the user?** Credentials, ambiguous design choice,
   irreversible destructive action, missing context only the user has.
3. **Have you made zero progress for 3 consecutive iterations?** Same
   error, same dead-end, no new information acquired.

Branch:

- **(1) Condition met**: increment iterations, set `status: complete`,
  write `last_evaluation` summarising the evidence, delete the goal file,
  hand back to the user with a clear success report including the proof.
- **(2) Blocked on user**: increment iterations, set `status: blocked`,
  save the goal file with a clear blocker description in `last_evaluation`,
  hand back. Tell the user explicitly what input you need.
- **(3) Stuck (no progress × 3)**: same as (2) but `last_evaluation`
  should describe the stuck pattern, not pretend it's just blocked.
- **Otherwise**: increment iterations, save the goal file, **stay in the
  response** and proceed to the next reasonable action.

## Behaviour on `/goal` (status check)

Read `.claude/active-goal.md`. If it exists, print:

- The condition (verbatim)
- Time since `started_at` (human-readable, e.g. "12 minutes ago")
- Iteration count
- Status (`active` | `blocked` | `complete` | `cleared`)
- The most recent `last_evaluation` reasoning

If the file doesn't exist, print: `No active goal in this project.`

## Behaviour on `/goal clear` (or aliases)

Aliases: `clear`, `stop`, `off`, `reset`, `none`, `cancel`.

1. If `.claude/active-goal.md` exists, delete it.
2. Confirm to the user: `Goal cleared.`
3. Hand back.

## Resuming after a new conversation

If you start a fresh conversation in a project and discover
`.claude/active-goal.md` exists with `status: active` or `blocked`, **do not
auto-resume work**. On your first response, mention that an active goal
exists and ask:

> There's an active goal in this project from <relative time>:
> "<condition>". Resume work on it, clear it, or leave it as-is?

Only resume after the user explicitly says so.

## Writing an effective condition (passed through from built-in docs)

A condition that holds up across many iterations usually has:

- **One measurable end state** — a test result, a build exit code, a file
  count, an empty queue, a visual artifact at a specific path.
- **A stated check** — how Claude should prove it, e.g. `npm test exits 0`,
  `git status is clean`, `the binary at build/foo.app launches without
  crashing`.
- **Constraints that matter** — anything that must not change on the way
  there: `no other test file is modified`, `commit history stays linear`.
- **Optional turn/time bound** — to prevent runaway loops:
  `or stop after 20 iterations`, `or stop after 30 minutes`.

If the condition is loose ("make the code better"), the evaluator can't
make a clean call and the loop drifts. Tighter is better.

## Differences from the built-in

| Aspect | Built-in /goal (Claude Code 2.1.x+) | This skill |
|---|---|---|
| Evaluator | Separate small-fast model after each turn | Same model self-evaluates in-turn |
| Turn boundary | New turn started automatically | Single long response, in-turn continuation |
| Persistence | Session state, survives `--resume` | File on disk, survives forever until cleared |
| Status indicator | UI shows `◎ /goal active` | Status via `/goal` with no args |
| Cost | Evaluator tokens negligible | Same main-model rate throughout |
| Resume protocol | Auto on `--resume` | Prompts user on first response in a new conversation |

In-turn self-evaluation has a known sycophancy bias — Claude can talk
itself into "yes the condition is met" prematurely. Mitigate by always
running a verification step (test, build, screenshot, file check) before
declaring the condition met. Don't trust internal reasoning alone.

## When NOT to use /goal

- Tasks that don't have a measurable end state ("clean up the docs a bit")
- Tasks the user will want to review at each step ("refactor this carefully")
- Open-ended exploration ("look around and tell me what you think")

For those, leave the conversation natural — don't lock into a goal loop.
