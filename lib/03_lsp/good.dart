// =============================================================================
// L — Liskov Substitution Principle (LSP)
// "Objects of a subclass must be substitutable for objects of their superclass
//  WITHOUT altering the correctness of the program."
//
// GOOD EXAMPLE
// ------------
// The fix is to model the REAL relationship:
//   • Rectangle and Square are both Shapes — they share a common abstraction.
//   • Neither extends the other; both are fully substitutable for Shape.
//   • Callers work against the Shape interface and are never surprised.
//
// Rule of thumb: prefer composition / abstraction over inheritance when
// the IS-A relationship is mathematical but NOT behavioural.
// =============================================================================

// ---------------------------------------------------------------------------
// Shared abstraction — the only guaranteed contract.
// ---------------------------------------------------------------------------
abstract interface class Shape {
  double get area;
  String get name;
}

// ---------------------------------------------------------------------------
// Rectangle — owns independent width and height, fulfils Shape contract.
// ---------------------------------------------------------------------------
class Rectangle implements Shape {
  final double width;
  final double height;

  const Rectangle(this.width, this.height);

  @override
  double get area => width * height;

  @override
  String get name => 'Rectangle(${width}x$height)';
}

// ---------------------------------------------------------------------------
// Square — owns a single side, fulfils the SAME Shape contract. ✅
// ---------------------------------------------------------------------------
class Square implements Shape {
  final double side;

  const Square(this.side);

  @override
  double get area => side * side;

  @override
  String get name => 'Square(${side}x$side)';
}

// ---------------------------------------------------------------------------
// Circle — a third shape; added without touching Rectangle or Square. ✅
// ---------------------------------------------------------------------------
class Circle implements Shape {
  final double radius;

  const Circle(this.radius);

  @override
  double get area => 3.14159 * radius * radius;

  @override
  String get name => 'Circle(r=$radius)';
}

/// Works correctly with ANY Shape — all subtypes are truly substitutable.
void printArea(Shape shape) {
  print('  ${shape.name} → area: ${shape.area.toStringAsFixed(2)}');
}

void runGood() {
  print('--- LSP GOOD ---');
  final shapes = <Shape>[
    Rectangle(5, 4),
    Square(4),
    Circle(3),
  ];

  for (final shape in shapes) {
    printArea(shape); // no surprises, no broken contracts ✅
  }
}
