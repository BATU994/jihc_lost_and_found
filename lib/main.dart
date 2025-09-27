import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jihc_landf/navBuild.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/secure_storage.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/shared_preferences.dart';
import 'package:jihc_landf/src/features/auth/presentation/pages/login.dart';
import 'package:jihc_landf/src/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/user_repository_impl.dart';
import 'package:jihc_landf/src/features/home/data/repositories/itemRepositoryImpl.dart';
import 'package:jihc_landf/src/features/home/presentation/bloc/item_bloc.dart';
import 'package:dio/dio.dart';

void main() {
  final dio = Dio();
  // final secureStorage = SecureStorage();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ItemBloc>(
          create: (_) => ItemBloc(ItemRepositoryImpl(dio))
            ..add(FetchItems()), // fetch items immediately
        ),
        BlocProvider<AuthBlocBloc>(
          create: (_) => AuthBlocBloc(UserRepositoryImpl()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // final SecureStorage secureStorage;

  // const MyApp({super.key, required this.secureStorage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JIHC L&F',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme().copyWith(
          bodyLarge: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
          bodyMedium: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
          bodySmall: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
          titleLarge: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
          titleMedium: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
          titleSmall: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BlocBuilder<AuthBlocBloc, AuthBlocState>(
        builder: (context, state) {
          ProfileInfo profileInfo = ProfileInfo();
          if (state is AuthBlocAuthenticated) {
            return const NavBuild(); 
          } else {
            final token = profileInfo.getToken();
            if (token != null) {
              return const NavBuild();
            }
            return const LoginPage();
          }
        },
      ),
    );
  }
}
