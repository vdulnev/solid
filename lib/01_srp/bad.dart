// =============================================================================
// S — Single Responsibility Principle (SRP)
// "A class should have only ONE reason to change."
//
// BAD EXAMPLE
// -----------
// The UserManager class does three completely different jobs:
//   1. Manages user data (domain logic)
//   2. Validates user input (validation logic)
//   3. Persists data to a database (infrastructure logic)
//   4. Sends welcome emails (communication logic)
//
// If the database changes, the validation rules change, OR the email template
// changes — all three force us to touch the SAME class. That is three reasons
// to change, which violates SRP.
// =============================================================================

class UserManager {
  final List<Map<String, String>> _db = [];

  // Reason 1 to change: domain / business rules around what a User is.
  String get displayName => 'UserManager';

  // Reason 2 to change: validation rules.
  bool _isValidEmail(String email) => email.contains('@');
  bool _isValidPassword(String password) => password.length >= 8;

  // Reason 3 to change: persistence strategy (SQL → NoSQL, file, etc.).
  void _saveToDatabase(Map<String, String> record) {
    _db.add(record);
    print('[DB] Saved user: ${record['email']}');
  }

  // Reason 4 to change: email content / delivery service.
  void _sendWelcomeEmail(String email) {
    print('[Email] Sending welcome email to $email');
  }

  // All reasons are tangled inside a single public method.
  void registerUser(String email, String password) {
    if (!_isValidEmail(email)) {
      throw ArgumentError('Invalid email: $email');
    }
    if (!_isValidPassword(password)) {
      throw ArgumentError('Password must be at least 8 characters.');
    }

    _saveToDatabase({'email': email, 'password': password});
    _sendWelcomeEmail(email);

    print('[UserManager] User $email registered successfully.');
  }
}

void runBad() {
  print('--- SRP BAD ---');
  final manager = UserManager();
  manager.registerUser('alice@example.com', 'securePass123');
}
