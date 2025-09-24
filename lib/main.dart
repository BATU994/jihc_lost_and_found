import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jihc_landf/src/features/auth/presentation/pages/login.dart';
import 'package:jihc_landf/src/features/auth/presentation/pages/register.dart';
import 'package:jihc_landf/src/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/user_repository_impl.dart';
import 'package:jihc_landf/src/features/home/presentation/pages/home.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => AuthBlocBloc(UserRepositoryImpl()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JIHC L&F',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BlocBuilder<AuthBlocBloc, AuthBlocState>(
        builder: (context, state) {
          if (state is AuthBlocLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthBlocAuthenticated) {
            return const HomePage();
          } else if (state is AuthBlocUnauthenticated || state is AuthBlocInitial) {
            return const LoginPage();
          } else if (state is AuthBlocSuccess) {
            return const HomePage();
          } else if (state is AuthFailed) {
            return Scaffold(
              body: Center(child: Text('Auth Error: ${state.failMessage}')),
            );
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
