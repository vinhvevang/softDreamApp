import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_fresher_training/presentation/bloc/auth/auth_state.dart';

import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/product_repository.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/auth/auth_event.dart';
import 'presentation/bloc/product/product_bloc.dart';
import 'presentation/bloc/product/product_event.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('loginBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepository>(
          create: (_) => ProductRepositoryImpl(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(Hive.box('loginBox')),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(context.read<AuthRepository>())
              ..add(AuthStarted()),
          ),
          BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(context.read<ProductRepository>())
              ..add(LoadProducts()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthBloc, dynamic>(
            builder: (context, state) {
              final authState = context.read<AuthBloc>().state;
              return authState.status == AuthStatus.authenticated
                  ? const HomePage()
                  : const LoginPage();
            },
          ),
        ),
      ),
    );
  }
}