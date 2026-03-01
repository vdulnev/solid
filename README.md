# SOLID Principles in Dart

A hands-on course covering all five SOLID principles with **bad** and **good**
Dart examples for each one.

---

## Run the course

```bash
dart run bin/main.dart
```

---

## Project layout

```
solid/
├── bin/
│   └── main.dart                 # Entry point — runs all examples
└── lib/
    ├── 01_srp/
    │   ├── bad.dart              # God-class UserManager
    │   └── good.dart             # UserValidator / UserRepository / EmailService / UserService
    ├── 02_ocp/
    │   ├── bad.dart              # if/else discount chain
    │   └── good.dart             # DiscountStrategy interface + concrete strategies
    ├── 03_lsp/
    │   ├── bad.dart              # Square extends Rectangle (broken contract)
    │   └── good.dart             # Shape abstraction — Rectangle, Square, Circle
    ├── 04_isp/
    │   ├── bad.dart              # Fat Worker interface forces robots to implement eat()
    │   └── good.dart             # Workable / Feedable / Restable split interfaces
    └── 05_dip/
        ├── bad.dart              # OrderService hard-codes MySQL + SMTP
        └── good.dart             # OrderRepository / Mailer abstractions + DI
```

---

## The Principles

### S — Single Responsibility Principle

> A class should have **only one reason to change**.

| | |
|---|---|
| **Bad** | `UserManager` validates, persists, AND sends emails. Three reasons to change. |
| **Good** | `UserValidator`, `UserRepository`, `EmailService`, `UserService` — one job each. |

**Key benefit:** changing the database doesn't risk breaking validation logic.

---

### O — Open / Closed Principle

> Software entities should be **open for extension, closed for modification**.

| | |
|---|---|
| **Bad** | `DiscountCalculator.calculate()` uses an if/else chain. Adding a new tier requires editing tested code. |
| **Good** | `DiscountStrategy` interface + one class per tier. New tier = new class, zero edits to existing code. |

**Key benefit:** production code stays untouched when business rules grow.

---

### L — Liskov Substitution Principle

> Objects of a subclass must be **substitutable** for their superclass without
> altering program correctness.

| | |
|---|---|
| **Bad** | `Square extends Rectangle` — overriding setters silently breaks callers' width/height assumptions. |
| **Good** | `Rectangle` and `Square` both implement the `Shape` interface. No broken contracts. |

**Key benefit:** polymorphism is safe and predictable everywhere in the codebase.

---

### I — Interface Segregation Principle

> Clients should **not be forced to depend** on interfaces they do not use.

| | |
|---|---|
| **Bad** | `Worker` bundles `work()`, `eat()`, `sleep()`. `RobotWorker` throws `UnsupportedError` on `eat()`. |
| **Good** | `Workable`, `Feedable`, `Restable` — each type implements only what it supports. |

**Key benefit:** no more runtime bombs from empty stubs or `UnsupportedError`.

---

### D — Dependency Inversion Principle

> High-level modules should **not depend on low-level modules**.
> Both should depend on **abstractions**.

| | |
|---|---|
| **Bad** | `OrderService` instantiates `MySqlDatabase` and `SmtpEmailSender` directly — untestable, tightly coupled. |
| **Good** | `OrderRepository` and `Mailer` abstractions injected via constructor — swap any implementation freely. |

**Key benefit:** `OrderService` can be unit-tested with in-memory fakes, no
real database or network required.

---

## Quick reference

| Letter | Principle | One-liner |
|--------|-----------|-----------|
| **S** | Single Responsibility | One class, one job, one reason to change. |
| **O** | Open / Closed | Extend with new code; don't edit old code. |
| **L** | Liskov Substitution | Subtypes must honour their supertype's contract. |
| **I** | Interface Segregation | Many small interfaces beat one fat interface. |
| **D** | Dependency Inversion | Depend on abstractions, not concretions. |
