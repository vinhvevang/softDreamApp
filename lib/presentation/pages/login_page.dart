/*
Use box.get() to read data is passed
box.put() to save  data is passed/ saved key-value in Box
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController taxController;
  late final TextEditingController userNameController;
  late final TextEditingController passWordController;

  @override
  void initState() {
    super.initState();
    final state = context.read<AuthBloc>().state;
    taxController = TextEditingController(text: state.tax);
    userNameController = TextEditingController(text: state.userName);
    passWordController = TextEditingController(text: state.password);
  }

  @override
  void dispose() {
    taxController.dispose();
    userNameController.dispose();
    passWordController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      label: Text(label),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
        borderRadius: BorderRadius.circular(3),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFF24E1E), width: 1),
        borderRadius: BorderRadius.circular(3),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFF24E1E), width: 1),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _errorText(String? text) {
    if (text == null) return const SizedBox.shrink();
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: const TextStyle(color: Colors.red, fontSize: 13),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.status != current.status || previous.message != current.message,
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
            (route) => false,
          );
        }

        if (state.status == AuthStatus.failure &&
            state.message != null &&
            state.message == 'Khong hop le') {
          showDialog(
            context: context,
            builder: (dialogContext) {
              return AlertDialog(
                title: const Text("Thong bao"),
                content: const Text("Khong hop le"),
                actions: [
                  IconButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    icon: const Icon(Icons.close),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, c) {
            final authState = context.watch<AuthBloc>().state;

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: c.maxHeight),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: SvgPicture.asset("assets/iconLogin.svg"),
                      ),
                      const Text(
                        "Mã số Thuế",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: taxController,
                        onChanged: (value) {
                          context.read<AuthBloc>().add(TaxChanged(value));
                        },
                        decoration: _buildInputDecoration("Mã số thuế"),
                      ),
                      _errorText(authState.taxError),
                      const SizedBox(height: 30),
                      const Text(
                        "Tài khoản",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: userNameController,
                        onChanged: (value) {
                          context.read<AuthBloc>().add(UserNameChanged(value));
                        },
                        decoration: _buildInputDecoration("Tài khoản"),
                      ),
                      _errorText(authState.nameError),
                      const SizedBox(height: 30),
                      const Text(
                        "Mật khẩu",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        obscureText: authState.isObscured,
                        obscuringCharacter: "*",
                        controller: passWordController,
                        onChanged: (value) {
                          context.read<AuthBloc>().add(PasswordChanged(value));
                        },
                        decoration: _buildInputDecoration("Mật khẩu").copyWith(
                          suffixIcon: IconButton(
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(PasswordVisibilityToggled());
                            },
                            icon: Icon(
                              authState.isObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                      ),
                      _errorText(authState.passwordError),
                      const SizedBox(height: 50),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF24E1E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          onPressed: () {
                            context.read<AuthBloc>().add(LoginSubmitted());
                          },
                          child: const Center(
                            child: Text(
                              "Đăng nhập",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 150),
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 25,
                                    height: 25,
                                    child:
                                        SvgPicture.asset("assets/headphone.svg"),
                                  ),
                                  const Text("Tro giup"),
                                ],
                              ),
                            ),
                            const SizedBox(width: 7),
                            Container(
                              height: 50,
                              width: 100,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: SvgPicture.asset(
                                        "assets/Social link.svg"),
                                  ),
                                  const Text("Group"),
                                ],
                              ),
                            ),
                            const SizedBox(width: 7),
                            Container(
                              height: 50,
                              width: 100,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: SvgPicture.asset(
                                        "assets/search-normal.svg"),
                                  ),
                                  const Text("Tra cuu"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}