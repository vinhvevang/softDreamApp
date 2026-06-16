enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  failure,
}

class AuthState {
  final String tax;
  final String userName;
  final String password;

  final String? taxError;
  final String? nameError;
  final String? passwordError;

  final bool isObscured;
  final AuthStatus status;
  final String? message;

  const AuthState({
    this.tax = '',
    this.userName = '',
    this.password = '',
    this.taxError,
    this.nameError,
    this.passwordError,
    this.isObscured = true,
    this.status = AuthStatus.initial,
    this.message,
  });

  AuthState copyWith({
    String? tax,
    String? userName,
    String? password,
    String? taxError,
    String? nameError,
    String? passwordError,
    bool? isObscured,
    AuthStatus? status,
    String? message,
    bool clearMessage = false,
    bool clearErrors = false,
  }) {
    return AuthState(
      tax: tax ?? this.tax,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      taxError: clearErrors ? null : (taxError ?? this.taxError),
      nameError: clearErrors ? null : (nameError ?? this.nameError),
      passwordError: clearErrors ? null : (passwordError ?? this.passwordError),
      isObscured: isObscured ?? this.isObscured,
      status: status ?? this.status,
      message: clearMessage ? null : (message ?? this.message),
    );
  }
}