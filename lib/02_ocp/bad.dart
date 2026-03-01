// =============================================================================
// O — Open/Closed Principle (OCP)
// "Software entities should be OPEN for extension, CLOSED for modification."
//
// BAD EXAMPLE
// -----------
// DiscountCalculator uses a chain of if/else (or switch) that checks the
// customer type at runtime. Every time a new customer tier is introduced
// (e.g., 'vip', 'employee') we must MODIFY this class — reopening tested,
// production code and risking regressions.
// =============================================================================

class DiscountCalculator {
  // Must be modified every time a new customer type is added. ❌
  double calculate(String customerType, double price) {
    if (customerType == 'regular') {
      return price * 0.0; // no discount
    } else if (customerType == 'silver') {
      return price * 0.10;
    } else if (customerType == 'gold') {
      return price * 0.20;
    } else if (customerType == 'platinum') {
      return price * 0.30;
    } else {
      throw ArgumentError('Unknown customer type: $customerType');
    }
  }
}

void runBad() {
  print('--- OCP BAD ---');
  final calculator = DiscountCalculator();
  const price = 100.0;

  for (final type in ['regular', 'silver', 'gold', 'platinum']) {
    final discount = calculator.calculate(type, price);
    print('  $type → discount: \$$discount (pays \$${price - discount})');
  }
}
