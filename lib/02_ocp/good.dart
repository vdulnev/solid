// =============================================================================
// O — Open/Closed Principle (OCP)
// "Software entities should be OPEN for extension, CLOSED for modification."
//
// GOOD EXAMPLE
// ------------
// We introduce a DiscountStrategy abstraction. Each customer tier is a
// separate class that implements the abstraction. To add a new tier we simply
// create a NEW class — we never touch existing, tested code.
//
//   DiscountCalculator  →  closed for modification ✅
//   New tiers           →  open for extension via new subclasses ✅
// =============================================================================

// ---------------------------------------------------------------------------
// Abstraction — the contract every discount strategy must fulfil.
// ---------------------------------------------------------------------------
abstract interface class DiscountStrategy {
  /// Returns the discount AMOUNT (not percentage) for [price].
  double calculate(double price);

  /// Human-readable label for logging / UI.
  String get label;
}

// ---------------------------------------------------------------------------
// Concrete strategies — one class per tier. Adding a new tier = new class.
// ---------------------------------------------------------------------------
class NoDiscount implements DiscountStrategy {
  @override
  String get label => 'Regular';

  @override
  double calculate(double price) => 0.0;
}

class SilverDiscount implements DiscountStrategy {
  @override
  String get label => 'Silver';

  @override
  double calculate(double price) => price * 0.10;
}

class GoldDiscount implements DiscountStrategy {
  @override
  String get label => 'Gold';

  @override
  double calculate(double price) => price * 0.20;
}

class PlatinumDiscount implements DiscountStrategy {
  @override
  String get label => 'Platinum';

  @override
  double calculate(double price) => price * 0.30;
}

// NEW tier added WITHOUT touching any existing class. ✅
class EmployeeDiscount implements DiscountStrategy {
  @override
  String get label => 'Employee';

  @override
  double calculate(double price) => price * 0.40;
}

// ---------------------------------------------------------------------------
// Calculator — closed for modification; works with ANY DiscountStrategy.
// ---------------------------------------------------------------------------
class DiscountCalculator {
  double apply(DiscountStrategy strategy, double price) {
    return strategy.calculate(price);
  }
}

void runGood() {
  print('--- OCP GOOD ---');
  final calculator = DiscountCalculator();
  const price = 100.0;

  final strategies = <DiscountStrategy>[
    NoDiscount(),
    SilverDiscount(),
    GoldDiscount(),
    PlatinumDiscount(),
    EmployeeDiscount(), // extended without modifying DiscountCalculator
  ];

  for (final strategy in strategies) {
    final discount = calculator.apply(strategy, price);
    print(
      '  ${strategy.label} → discount: \$$discount '
      '(pays \$${price - discount})',
    );
  }
}

void main() => runGood();
