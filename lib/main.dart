import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jihc_landf/navBuild.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/shared_preferences.dart';
import 'package:jihc_landf/src/features/auth/presentation/pages/login.dart';
import 'package:jihc_landf/src/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/user_repository_impl.dart';
import 'package:jihc_landf/src/features/home/data/repositories/itemRepositoryImpl.dart';
import 'package:jihc_landf/src/features/home/presentation/bloc/item_bloc.dart';
import 'package:dio/dio.dart';
import 'package:jihc_landf/src/features/chat/presentation/pages/chatList.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final dio = Dio();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ItemBloc>(
          create:
              (_) =>
                  ItemBloc(ItemRepositoryImpl(dio))
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
          if (state is AuthBlocAuthenticated) {
            return const NavBuild();
          }
          // Fallback to stored token async
          return FutureBuilder<String?>(
            future: ProfileInfo().getToken(),
            builder: (context, snap) {
              if (!snap.hasData) {
                return const LoginPage();
              }
              final token = snap.data;
              if (token != null) {
                return const NavBuild();
              }
              return const LoginPage();
            },
          );
        },
      ),
      routes: {'/chats': (_) => const ChatListPage(currentUserId: 1)},
    );
  }
}
