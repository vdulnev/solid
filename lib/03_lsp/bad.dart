// =============================================================================
// L — Liskov Substitution Principle (LSP)
// "Objects of a subclass must be substitutable for objects of their superclass
//  WITHOUT altering the correctness of the program."
//
// BAD EXAMPLE — the classic Rectangle / Square problem
// ----------------------------------------------------
// Mathematically a square IS-A rectangle, so it seems natural to extend
// Rectangle. But Square overrides setWidth / setHeight in a way that
// VIOLATES the contract callers rely on:
//
//   "Setting width leaves height unchanged."
//   "Setting height leaves width unchanged."
//
// Any code written against Rectangle breaks silently when a Square is passed
// in its place — that is a Liskov violation.
// =============================================================================

class Rectangle {
  double width;
  double height;

  Rectangle(this.width, this.height);

  double get area => width * height;
}

// Square "is-a" Rectangle mathematically, but NOT behaviourally. ❌
class Square extends Rectangle {
  Square(double side) : super(side, side);

  // Overriding setters breaks the Rectangle contract:
  // changing width also changes height, which callers do NOT expect.
  @override
  set width(double value) {
    super.width = value;
    super.height = value; // surprise side-effect!
  }

  @override
  set height(double value) {
    super.height = value;
    super.width = value; // surprise side-effect!
  }
}

/// This function is written against Rectangle and has a clear expectation:
/// after setting width = 5 the height must remain what it was.
void printExpectedArea(Rectangle rect) {
  rect.width = 5;
  rect.height = 4;
  // Expected area: 5 * 4 = 20
  // Actual area with Square: 4 * 4 = 16  ← LSP violation!
  print('  Expected area: 20, Actual area: ${rect.area}');
}

void runBad() {
  print('--- LSP BAD ---');
  print('  With Rectangle:');
  printExpectedArea(Rectangle(3, 3)); // prints 20 ✓

  print('  With Square (substituted for Rectangle):');
  printExpectedArea(Square(3)); // prints 16 ✗ — program breaks!
}
