// =============================================================================
// D — Dependency Inversion Principle (DIP)
// "High-level modules should NOT depend on low-level modules.
//  Both should depend on ABSTRACTIONS.
//  Abstractions should not depend on details.
//  Details should depend on abstractions."
//
// BAD EXAMPLE
// -----------
// OrderService is a high-level module (business logic).
// MySqlDatabase and SmtpEmailSender are low-level modules (infrastructure).
//
// OrderService directly instantiates the low-level classes with `new`, making
// it IMPOSSIBLE to:
//   • Unit-test OrderService without a real database and SMTP server.
//   • Swap MySQL for PostgreSQL without editing OrderService.
//   • Send emails via SendGrid without editing OrderService.
//
// High-level module depends on LOW-LEVEL DETAILS — DIP violated. ❌
// =============================================================================

// Low-level module — infrastructure detail.
class MySqlDatabase {
  void save(String data) {
    print('  [MySQL] Saving: "$data"');
  }
}

// Another low-level module — infrastructure detail.
class SmtpEmailSender {
  void send(String to, String body) {
    print('  [SMTP] Sending email to $to: "$body"');
  }
}

// High-level module — business logic.
class OrderService {
  // Hard-coded dependency on concrete low-level classes. ❌
  final _db = MySqlDatabase();
  final _mailer = SmtpEmailSender();

  void placeOrder(String item, String customerEmail) {
    _db.save('Order: $item');
    _mailer.send(customerEmail, 'Your order for $item has been placed!');
    print('  [OrderService] Order placed for $item.');
  }
}

void runBad() {
  print('--- DIP BAD ---');
  // We cannot swap MySQL or SMTP — they are baked in.
  final service = OrderService();
  service.placeOrder('Dart Book', 'alice@example.com');
}

void main() => runBad();
