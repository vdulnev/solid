// =============================================================================
// D — Dependency Inversion Principle (DIP)
// "High-level modules should NOT depend on low-level modules.
//  Both should depend on ABSTRACTIONS."
//
// GOOD EXAMPLE
// ------------
// We introduce abstractions (interfaces) that both the high-level module
// AND the low-level implementations depend on.
//
//   OrderRepository  →  abstraction for data storage.
//   Mailer           →  abstraction for email delivery.
//
// OrderService now depends ONLY on the abstractions — never on concrete
// classes. The concrete implementations are injected from outside
// (Dependency Injection), making OrderService:
//   • Testable in isolation with mock/in-memory implementations. ✅
//   • Decoupled from any specific database or email provider. ✅
//   • Open for extension (swap implementations) without modification. ✅
// =============================================================================

// ---------------------------------------------------------------------------
// Abstractions — the "inversion" layer both sides depend on.
// ---------------------------------------------------------------------------
abstract interface class OrderRepository {
  void save(String data);
}

abstract interface class Mailer {
  void send(String to, String body);
}

// ---------------------------------------------------------------------------
// Low-level implementations — depend on the abstractions, not vice-versa.
// ---------------------------------------------------------------------------
class MySqlOrderRepository implements OrderRepository {
  @override
  void save(String data) => print('  [MySQL] Saving: "$data"');
}

class PostgresOrderRepository implements OrderRepository {
  @override
  void save(String data) => print('  [Postgres] Saving: "$data"');
}

class SmtpMailer implements Mailer {
  @override
  void send(String to, String body) =>
      print('  [SMTP] → $to: "$body"');
}

class SendGridMailer implements Mailer {
  @override
  void send(String to, String body) =>
      print('  [SendGrid] → $to: "$body"');
}

// In-memory stub for unit tests — no real DB or network needed. ✅
class InMemoryOrderRepository implements OrderRepository {
  final List<String> records = [];

  @override
  void save(String data) {
    records.add(data);
    print('  [InMemory] Saved: "$data"');
  }
}

// ---------------------------------------------------------------------------
// High-level module — depends ONLY on abstractions, injected via constructor.
// ---------------------------------------------------------------------------
class OrderService {
  final OrderRepository _repository;
  final Mailer _mailer;

  // Dependencies are injected — OrderService never calls `new` on concretes.
  OrderService(this._repository, this._mailer);

  void placeOrder(String item, String customerEmail) {
    _repository.save('Order: $item');
    _mailer.send(customerEmail, 'Your order for $item has been placed!');
    print('  [OrderService] Order placed for $item.');
  }
}

void runGood() {
  print('--- DIP GOOD ---');

  print('  Production setup (MySQL + SMTP):');
  final prodService = OrderService(MySqlOrderRepository(), SmtpMailer());
  prodService.placeOrder('Dart Book', 'alice@example.com');

  print('  Alternative setup (Postgres + SendGrid):');
  final altService = OrderService(PostgresOrderRepository(), SendGridMailer());
  altService.placeOrder('Flutter Book', 'bob@example.com');

  print('  Test setup (InMemory + no-op mailer):');
  final testRepo = InMemoryOrderRepository();
  final testService = OrderService(
    testRepo,
    // Anonymous implementation — great for tests.
    _NoOpMailer(),
  );
  testService.placeOrder('Unit Test Order', 'test@example.com');
  print('  Records in test repo: ${testRepo.records}');
}

class _NoOpMailer implements Mailer {
  @override
  void send(String to, String body) => print('  [NoOp] (email suppressed)');
}
