// =============================================================================
// S — Single Responsibility Principle (SRP)
// "A class should have only ONE reason to change."
//
// GOOD EXAMPLE
// ------------
// Each class now has exactly one job and one reason to change:
//
//   UserValidator   → changes only when validation rules change.
//   UserRepository  → changes only when the storage strategy changes.
//   EmailService    → changes only when email delivery / content changes.
//   UserService     → orchestrates the others; changes only when the
//                     registration workflow itself changes.
//
// Benefits:
//   • Every class is small, focused, and easy to test in isolation.
//   • Swapping the database? Touch only UserRepository.
//   • New validation rule? Touch only UserValidator.
//   • Different email provider? Touch only EmailService.
// =============================================================================

// ---------------------------------------------------------------------------
// 1. Validation — one reason to change: validation rules.
// ---------------------------------------------------------------------------
class UserValidator {
  void validate(String email, String password) {
    if (!email.contains('@')) {
      throw ArgumentError('Invalid email: $email');
    }
    if (password.length < 8) {
      throw ArgumentError('Password must be at least 8 characters.');
    }
  }
}

// ---------------------------------------------------------------------------
// 2. Persistence — one reason to change: storage strategy.
// ---------------------------------------------------------------------------
class UserRepository {
  final List<Map<String, String>> _store = [];

  void save(String email, String password) {
    _store.add({'email': email, 'password': password});
    print('[DB] Saved user: $email');
  }
}

// ---------------------------------------------------------------------------
// 3. Email — one reason to change: email content or delivery service.
// ---------------------------------------------------------------------------
class EmailService {
  void sendWelcome(String email) {
    print('[Email] Sending welcome email to $email');
  }
}

// ---------------------------------------------------------------------------
// 4. Orchestration — one reason to change: the registration workflow.
//    It coordinates the three focused classes above.
// ---------------------------------------------------------------------------
class UserService {
  final UserValidator _validator;
  final UserRepository _repository;
  final EmailService _email;

  UserService(this._validator, this._repository, this._email);

  void register(String email, String password) {
    _validator.validate(email, password);
    _repository.save(email, password);
    _email.sendWelcome(email);
    print('[UserService] User $email registered successfully.');
  }
}

void runGood() {
  print('--- SRP GOOD ---');
  final service = UserService(
    UserValidator(),
    UserRepository(),
    EmailService(),
  );
  service.register('alice@example.com', 'securePass123');
}

void main() => runGood();
