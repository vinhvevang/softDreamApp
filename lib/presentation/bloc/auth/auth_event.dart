abstract class AuthEvent {}

class AuthStarted extends AuthEvent {}

class TaxChanged extends AuthEvent {
  final String value;
  TaxChanged(this.value);
}

class UserNameChanged extends AuthEvent {
  final String value;
  UserNameChanged(this.value);
}

class PasswordChanged extends AuthEvent {
  final String value;
  PasswordChanged(this.value);
}

class PasswordVisibilityToggled extends AuthEvent {}

class LoginSubmitted extends AuthEvent {}

class LogoutRequested extends AuthEvent {}