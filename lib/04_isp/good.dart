// =============================================================================
// I — Interface Segregation Principle (ISP)
// "Clients should not be forced to depend on interfaces they do not use."
//
// GOOD EXAMPLE
// ------------
// We split the fat Worker interface into small, focused roles. Each type only
// implements the interfaces relevant to it:
//
//   Workable  →  anything that can do work (humans AND robots).
//   Feedable  →  anything that needs food (humans only).
//   Restable  →  anything that needs rest (humans only).
//
// Now:
//   • RobotWorker implements ONLY Workable — no stubs, no runtime bombs. ✅
//   • HumanWorker implements all three — correctly, without compromise. ✅
//   • Managers can accept Workable and call work() safely on any worker. ✅
// =============================================================================

// ---------------------------------------------------------------------------
// Small, focused interfaces — one per capability.
// ---------------------------------------------------------------------------
abstract interface class Workable {
  void work();
}

abstract interface class Feedable {
  void eat();
}

abstract interface class Restable {
  void sleep();
}

// ---------------------------------------------------------------------------
// Concrete types implement only what they support.
// ---------------------------------------------------------------------------
class HumanWorker implements Workable, Feedable, Restable {
  final String name;
  HumanWorker(this.name);

  @override
  void work() => print('  $name is working.');

  @override
  void eat() => print('  $name is eating lunch.');

  @override
  void sleep() => print('  $name is sleeping.');
}

// RobotWorker only needs Workable — clean, no stubs. ✅
class RobotWorker implements Workable {
  final String id;
  RobotWorker(this.id);

  @override
  void work() => print('  Robot $id is working.');
}

// ---------------------------------------------------------------------------
// Client code — depends only on the interface it actually uses.
// ---------------------------------------------------------------------------
class WorkManager {
  final List<Workable> _workers;
  WorkManager(this._workers);

  void startShift() {
    for (final w in _workers) {
      w.work(); // safe to call on ANY Workable ✅
    }
  }
}

class BreakManager {
  final List<Feedable> _feedable;
  BreakManager(this._feedable);

  void lunchBreak() {
    for (final f in _feedable) {
      f.eat(); // only called on workers that actually eat ✅
    }
  }
}

void runGood() {
  print('--- ISP GOOD ---');
  final alice = HumanWorker('Alice');
  final bob = HumanWorker('Bob');
  final r2d2 = RobotWorker('R2D2');

  final workManager = WorkManager([alice, bob, r2d2]);
  workManager.startShift();

  // BreakManager only knows about Feedable — robot is never passed in.
  final breakManager = BreakManager([alice, bob]);
  breakManager.lunchBreak();
}
