import 'package:flutter/material.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/shared_preferences.dart';
import 'package:jihc_landf/src/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:jihc_landf/src/features/auth/presentation/pages/login.dart';
import 'package:jihc_landf/src/features/home/presentation/bloc/item_bloc.dart';
import 'package:jihc_landf/src/features/home/presentation/utils/filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jihc_landf/src/features/home/presentation/widgets/itemWidgetProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileInfo profileInfo = ProfileInfo();
  Map<String, dynamic>? user;
  Filter selectedFilter = Filter.all;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  loadProfile() async {
    final info = await profileInfo.getProfileInfo();
    setState(() {
      user = {
        "username": info['username'] ?? 'Unknown',
        "userId": info['userId'],
        "email": info['email'] ?? 'Unknown',
        "userType": info['userType'] ?? 'Unknown',
        "group": info['group'] ?? 'Unknown',
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<AuthBlocBloc, AuthBlocState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 8),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/men/1.jpg',
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user?['username'] ?? 'Loading...',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "${user?['userType'] ?? 'Loading...'} • ${user?['group'] ?? 'Loading...'}",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _StatCard(
                      label: 'Total Posts',
                      value: '3',
                      color: Colors.blue.shade100,
                      valueColor: Colors.blue,
                    ),
                    const SizedBox(width: 16),
                    _StatCard(
                      label: 'Resolved',
                      value: '2',
                      color: Colors.green.shade100,
                      valueColor: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _QuickActionButton(
                      icon: Icons.edit,
                      label: 'Edit\nProfile',
                      color: Color(0xFFE3F0FF),
                      iconColor: Colors.blue,
                    ),
                    _QuickActionButton(
                      icon: Icons.settings,
                      label: 'Settings',
                      color: Color(0xFFF3F0FF),
                      iconColor: Colors.purple,
                    ),
                    _QuickActionButton(
                      icon: Icons.help_outline,
                      label: 'Help &\nSupport',
                      color: Color(0xFFE9FFF3),
                      iconColor: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // My Posts
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'My Posts',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Filter Tabs
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(236, 237, 238, 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedFilter = Filter.all;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 150),

                            decoration: BoxDecoration(
                              color:
                                  selectedFilter == Filter.all
                                      ? Color.fromRGBO(36, 138, 255, 1)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),

                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(
                                'All',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      selectedFilter == Filter.all
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 3),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedFilter = Filter.lost;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 150),

                            decoration: BoxDecoration(
                              color:
                                  selectedFilter == Filter.lost
                                      ? Color.fromRGBO(36, 138, 255, 1)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),

                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(
                                'Lost',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      selectedFilter == Filter.lost
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 3),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedFilter = Filter.found;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 150),

                            decoration: BoxDecoration(
                              color:
                                  selectedFilter == Filter.found
                                      ? Color.fromRGBO(36, 138, 255, 1)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),

                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(
                                'Found',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      selectedFilter == Filter.found
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                BlocBuilder<ItemBloc, ItemState>(
                  builder: (context, state) {
                    if (state is ItemLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ItemLoaded) {
                      final currentUserId = user?['userId']?.toString();
                      final items =
                          state.items.where((item) {
                            final isMine =
                                item.user_id.toString() == currentUserId;
                            if (!isMine) return false;
                            switch (selectedFilter) {
                              case Filter.all:
                                return true;
                              case Filter.lost:
                                return item.isLost;
                              case Filter.found:
                                return !item.isLost;
                            }
                          }).toList();
                      if (items.isEmpty) {
                        return Center(
                          child: Text(
                            'No items found.',
                            style: TextStyle(color: Colors.black54),
                          ),
                        );
                      }
                      return ListView.separated(
                        separatorBuilder:
                            (context, index) => SizedBox(height: 10),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return itemProfile(context, item);
                        },
                      );
                    } else if (state is ItemError) {
                      return Center(
                        child: Text(
                          'Failed to load items.',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return Center(
                      child: Text(
                        'You have no posts yet.',
                        style: TextStyle(color: Colors.black54),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                      side: BorderSide.none,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      context.read<AuthBlocBloc>().add(AuthLogoutRequested());
                      if (state is AuthBlocUnauthenticated) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Log out',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final Color valueColor;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color iconColor;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor, size: 28),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
