import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jihc_landf/src/core/userName/bloc/username_bloc.dart';
import 'package:jihc_landf/src/core/userName/data/repository/UserNameRepositoryImpl.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/user_repository_impl.dart';
import 'package:jihc_landf/src/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:jihc_landf/src/features/home/data/repositories/itemRepositoryImpl.dart';
import 'package:jihc_landf/src/features/home/presentation/bloc/item_bloc.dart';
import 'package:jihc_landf/src/features/home/presentation/pages/home.dart';
import 'package:jihc_landf/src/features/home/presentation/pages/post.dart';
import 'package:jihc_landf/src/features/home/presentation/pages/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jihc_landf/src/features/chat/presentation/pages/chatList.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/shared_preferences.dart';

class NavBuild extends StatefulWidget {
  const NavBuild({super.key});

  @override
  State<NavBuild> createState() => _NavBuildState();
}

class _NavBuildState extends State<NavBuild> {
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.grey.shade400, width: 1),
          ),
          margin: EdgeInsets.fromLTRB(16, 0, 16, 7),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      navIndex = 0;
                    });
                    // Refresh items when navigating back to Home tab
                    context.read<ItemBloc>().add(FetchItems());
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    width: 70,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          navIndex == 0
                              ? Color.fromRGBO(207, 229, 255, 1)
                              : Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/home.svg',
                          width: 25,
                          height: 25,
                          color: navIndex == 0 ? Colors.blue : Colors.grey,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: navIndex == 0 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      navIndex = 1;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    width: 70,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          navIndex == 1
                              ? Color.fromRGBO(207, 229, 255, 1)
                              : Colors.white,
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/post.svg',
                          width: 25,
                          height: 25,
                          color: navIndex == 1 ? Colors.blue : Colors.grey,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Post',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: navIndex == 1 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      navIndex = 2;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    width: 70,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          navIndex == 2
                              ? Color.fromRGBO(207, 229, 255, 1)
                              : Colors.white,
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/chat.svg',
                          width: 25,
                          height: 25,
                          color: navIndex == 2 ? Colors.blue : Colors.grey,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Chat',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: navIndex == 2 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      navIndex = 3;
                    });
                  },
                  child: Container(
                    width: 70,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          navIndex == 3
                              ? Color.fromRGBO(207, 229, 255, 1)
                              : Colors.white,
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/profile.svg',
                          width: 25,
                          height: 25,
                          color: navIndex == 3 ? Colors.blue : Colors.grey,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: navIndex == 3 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ItemBloc>(
            create:
                (_) => ItemBloc(ItemRepositoryImpl(Dio()))..add(FetchItems()),
          ),
          BlocProvider<AuthBlocBloc>(
            create: (_) => AuthBlocBloc(UserRepositoryImpl()),
          ),
          BlocProvider<UsernameBloc>(
            create: (_) => UsernameBloc(UserNameRepositoryImpl(Dio())),
          ),
        ],
        child:
            [
              HomePage(),
              PostPage(),
              FutureBuilder<String?>(
                future: ProfileInfo().getId(),
                builder: (context, snap) {
                  final id = int.tryParse((snap.data ?? '1')) ?? 1;
                  return ChatListPage(currentUserId: id);
                },
              ),
              ProfilePage(),
            ][navIndex],
      ),
    );
  }
}
