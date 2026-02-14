---
name: root-cause-analysis
description: Perform root cause analysis using the "5 Whys" technique (from the Open Practice Library) when a bug, failure, or anti-pattern is encountered.
version: 1.0.0
tier: 0
---

# Root Cause Analysis

Use this skill when a problem is encountered and the surface-level fix would only treat the symptom. Anti-patterns compound — a workaround left in place attracts more workarounds. Find and fix the root cause.

## When to Trigger

- A bug keeps recurring or has been "fixed" before.
- A workaround or hack is being considered.
- An anti-pattern is discovered during development or review.
- A CI/CD failure has no obvious cause.
- A design decision feels wrong but the reason is unclear.

## The Whys (a.k.a. "5 Whys")

> Origin: [Open Practice Library — The 5 Whys](https://openpracticelibrary.com/practice/5-whys/). The number five is a rule of thumb, not a hard limit — ask as many (or as few) "whys" as it takes to reach the structural cause.

Ask "why" repeatedly until you reach the structural cause. Stop when the answer points to something you can change.

### Template

```
Problem: [Describe the observable symptom]

1. Why? → [First-level cause]
2. Why? → [Deeper cause]
3. Why? → [Deeper cause]
...continue until you reach the root cause...
N. Why? → [Root cause — the thing to actually fix]
```

### Rules

- Each answer must be factual, not speculative. If you don't know, investigate before proceeding.
- You may need fewer or more than five iterations. Five is a starting suggestion, not a rule.
- If the chain branches (multiple causes), follow the most impactful branch first, then revisit.
- The root cause should be something **actionable** — a code change, a design fix, a process change, or a missing test.
- If the root cause is outside your control (e.g., upstream bug, org policy), document it and identify the best compensating action.

## Workflow

1. **State the problem** clearly. What is the observable symptom?
2. **Run the Whys.** Ask "why" iteratively and document each step.
3. **Identify the root cause.** Is it a code defect, a missing test, a design flaw, a process gap, or an environmental issue?
4. **Propose the fix** at the root cause level, not the symptom level.
5. **Verify the fix** resolves the original symptom and doesn't introduce new issues.
6. **Add a test** that would have caught the root cause. Prevent regression.
7. **Check for siblings.** If this root cause could manifest elsewhere, scan for similar instances.

## Anti-Pattern Awareness

When the root cause is an anti-pattern:

- **Name it.** If it has a known name (God Object, Shotgun Surgery, Lava Flow, etc.), call it out.
- **Trace the chain.** Anti-patterns attract more anti-patterns. Identify any secondary anti-patterns that grew around the original one.
- **Fix from the bottom.** Resolve the deepest anti-pattern first; the secondary ones may resolve themselves or become trivial.
- **Document in an ADR** if the fix changes architectural direction (invoke the `adr-writing` skill).

## Quality Checks

- [ ] Root cause identified (not just the symptom)
- [ ] "Why?" chain documented (as many iterations as needed)
- [ ] Fix addresses the root cause, not a workaround
- [ ] Regression test added
- [ ] Sibling instances checked
- [ ] ADR created if architectural change was needed
