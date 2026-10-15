# Adversarial Architecture & Red-Team Protocol

Use this playbook before implementing Tier-3 architectural changes, new APIs, database migrations, or security-sensitive workflows.

## 1. First-Principles Constraint Mapping
Define the non-negotiable invariants before choosing abstractions:
- **Data Integrity**: What state transitions must be atomic or idempotent?
- **Latency & Throughput**: What is the complexity ($O(n)$ vs. $O(1)$) and I/O fan-out (e.g., N+1 queries, unbounded loops)?
- **Compatibility**: Does this break existing API callers, serialized state, or CLI flags?

## 2. The 6-Point Red-Team Matrix
Challenge your proposed design against these six adversarial vectors:

1. **Boundary & Malformed Inputs**: Empty collections, `null`/`undefined`, Unicode/encoding edge cases, massive payloads, negative/zero numbers.
2. **Concurrency & Ordering**: Out-of-order events, double-submission (idempotency), deadlocks, stale reads.
3. **Partial Failure & Recovery**: What happens if step 2 of 3 fails? Is state left half-mutated, or does it roll back cleanly?
4. **Resource Exhaustion**: Memory leaks, unclosed file descriptors/connections, unbounded retries, missing pagination/timeouts.
5. **Security & Trust Boundaries**: AuthN/AuthZ bypass, injection surfaces (SQL, shell, XSS, prompt injection), SSRF, or sensitive data exposure in logs/errors.
6. **Cognitive & Maintenance Debt**: Can a future engineer understand this in 30 seconds without hidden side effects? Prefer explicit, flat control flow over clever abstractions.
