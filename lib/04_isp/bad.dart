// =============================================================================
// I — Interface Segregation Principle (ISP)
// "Clients should not be forced to depend on interfaces they do not use."
//
// BAD EXAMPLE — the "fat interface" anti-pattern
// -----------------------------------------------
// Worker is a single large interface that bundles completely unrelated
// capabilities. Human workers can do everything, but Robot workers CAN'T eat
// — yet they are forced to implement eat() anyway, which leads to either:
//   • A meaningless stub that throws at runtime.
//   • A lie (empty body that silently does nothing).
//
// This also means RobotWorker has a compile-time dependency on a method it
// will NEVER use, creating unnecessary coupling.
// =============================================================================

abstract interface class Worker {
  void work();
  void eat();   // Robots don't eat — why are they forced to know about this? ❌
  void sleep(); // Robots don't sleep either! ❌
}

class HumanWorker implements Worker {
  final String name;
  HumanWorker(this.name);

  @override
  void work() => print('  $name is working.');

  @override
  void eat() => print('  $name is eating lunch.');

  @override
  void sleep() => print('  $name is sleeping.');
}

// RobotWorker is forced to implement methods it cannot meaningfully support.
class RobotWorker implements Worker {
  final String id;
  RobotWorker(this.id);

  @override
  void work() => print('  Robot $id is working.');

  @override
  void eat() => throw UnsupportedError('Robots do not eat!'); // ❌ runtime bomb

  @override
  void sleep() => throw UnsupportedError('Robots do not sleep!'); // ❌
}

void runBad() {
  print('--- ISP BAD ---');
  final workers = <Worker>[HumanWorker('Alice'), RobotWorker('R2D2')];

  for (final w in workers) {
    w.work();
    // Calling eat() on robot crashes at runtime — client code cannot safely
    // call this method on the Worker abstraction.
    try {
      w.eat();
    } on UnsupportedError catch (e) {
      print('  ERROR: $e');
    }
  }
}
