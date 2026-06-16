import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository)
      : super(
          AuthState(
            tax: repository.savedTax,
            userName: repository.savedUserName,
            password: repository.savedPassword,
            status: repository.isLoggedIn
                ? AuthStatus.authenticated
                : AuthStatus.unauthenticated,
          ),
        ) {
    on<AuthStarted>(_onStarted);
    on<TaxChanged>(_onTaxChanged);
    on<UserNameChanged>(_onUserNameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordVisibilityToggled>(_onTogglePassword);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
  }

  void _onStarted(AuthStarted event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      tax: repository.savedTax,
      userName: repository.savedUserName,
      password: repository.savedPassword,
      status: repository.isLoggedIn
          ? AuthStatus.authenticated
          : AuthStatus.unauthenticated,
      clearMessage: true,
      clearErrors: true,
    ));
  }

  void _onTaxChanged(TaxChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      tax: event.value,
      taxError: null,
      clearMessage: true,
    ));
  }

  void _onUserNameChanged(UserNameChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      userName: event.value,
      nameError: null,
      clearMessage: true,
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      password: event.value,
      passwordError: null,
      clearMessage: true,
    ));
  }

  void _onTogglePassword(
    PasswordVisibilityToggled event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isObscured: !state.isObscured));
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final tax = state.tax.trim();
    final userName = state.userName.trim();
    final password = state.password;

    String? taxError;
    String? nameError;
    String? passwordError;

    if (tax.length != 10) {
      taxError = "Cần đủ 10 ký tự";
    }

    if (userName.isEmpty) {
      nameError = "Tên đăng nhập không được để trống";
    }

    if (password.isEmpty || password.length < 8 || password.length > 50) {
      passwordError = "Mật khẩu phải từ 8 đến 50 ký tự";
    }

    if (taxError != null || nameError != null || passwordError != null) {
      emit(state.copyWith(
        taxError: taxError,
        nameError: nameError,
        passwordError: passwordError,
        status: AuthStatus.failure,
      ));
      return;
    }

    if (tax != '1111111111' ||
        userName != 'demo' ||
        password != '12345678') {
      emit(state.copyWith(
        status: AuthStatus.failure,
        message: 'Khong hop le',
      ));
      return;
    }

    emit(state.copyWith(
      status: AuthStatus.loading,
      clearErrors: true,
      clearMessage: true,
    ));

    await repository.saveSession(
      tax: tax,
      userName: userName,
      password: password,
    );

    emit(state.copyWith(
      status: AuthStatus.authenticated,
      clearErrors: true,
      clearMessage: true,
    ));
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await repository.logout();
    emit(state.copyWith(
      status: AuthStatus.unauthenticated,
      clearMessage: true,
      clearErrors: true,
    ));
  }
}