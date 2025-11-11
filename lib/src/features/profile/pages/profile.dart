import 'package:flutter/material.dart';
import 'package:jihc_landf/src/core/item/domain/entities/itemEntity.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/shared_preferences.dart';
import 'package:jihc_landf/src/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:jihc_landf/src/features/auth/presentation/pages/login.dart';
import 'package:jihc_landf/src/core/item/bloc/item_bloc.dart';
import 'package:jihc_landf/src/features/profile/pages/edit_user.dart';
import 'package:jihc_landf/src/core/enums/filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jihc_landf/src/features/home/presentation/widgets/itemWidgetProfile.dart';
import 'package:jihc_landf/src/features/home/presentation/widgets/three_picker.dart';
import 'package:jihc_landf/src/features/profile/pages/support_feedback.dart';

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
    final loadedUserId = info['userId'];
    if (loadedUserId != null) {
      context.read<ItemBloc>().add(FetchUserItems(loadedUserId));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 30),
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
              BlocBuilder<ItemBloc, ItemState>(
                builder: (context, state) {
                  if (state is ItemLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ItemLoaded) {
                    final currentUserId = user?['userId']?.toString();
                    final myItems =
                        state.items
                            .where(
                              (item) =>
                                  item.user_id.toString() == currentUserId,
                            )
                            .toList();
                    final totalPosts = myItems.length.toString();
                    final resolvedCount =
                        myItems
                            .where((item) => item.isResolved)
                            .length
                            .toString();

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _StatCard(
                          label: 'Total Posts',
                          value: totalPosts,
                          color: Colors.blue.shade100,
                          valueColor: Colors.blue,
                        ),
                        const SizedBox(width: 16),
                        _StatCard(
                          label: 'Resolved',
                          value: resolvedCount,
                          color: Colors.green.shade100,
                          valueColor: Colors.green,
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const EditProfilePage();
                            },
                          ),
                        );
                      },
                      child: _QuickActionButton(
                        icon: Icons.edit,
                        label: 'Edit\nProfile',
                        color: Color(0xFFE3F0FF),
                        iconColor: Colors.blue,
                        textColor: Color(0xFF0077FF),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _QuickActionButton(
                      icon: Icons.settings,
                      label: 'Settings',
                      color: Color(0xFFF3F0FF),
                      iconColor: Colors.purple,
                      textColor: Color(0xFF984EE5),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {   
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SupportFeedback();
                            },
                          ),
                        );
                      },
                      child: _QuickActionButton(
                        textColor: Color(0xFF438950),
                        icon: Icons.help_outline,
                        label: 'Help &\nSupport',
                        color: Color(0xFFE9FFF3),
                        iconColor: Color(0xFF438950),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Posts',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ThreePicker(
                selectedFilter: selectedFilter,
                onChanged: (filter) {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
              ),
              const SizedBox(height: 12),
              BlocBuilder<ItemBloc, ItemState>(
                builder: (context, state) {
                  if (state is ItemLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ItemLoaded) {
                    final items = state.items;
                    if (items.isEmpty) {
                      return Center(
                        child: Text(
                          'No items found.',
                          style: TextStyle(color: Colors.black54),
                        ),
                      );
                    }
                    List<ItemEntity> filteredItems;

                    if (selectedFilter case Filter.lost) {
                      filteredItems =
                          state.items.where((item) => item.isLost).toList();
                    } else if (selectedFilter case Filter.found) {
                      filteredItems =
                          state.items.where((item) => !item.isLost).toList();
                    } else if (selectedFilter case Filter.all) {
                      filteredItems = state.items;
                    } else {
                      filteredItems = state.items;
                    }
                    return ListView.separated(
                      separatorBuilder:
                          (context, index) => SizedBox(height: 10),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
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
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  onPressed: () {
                    context.read<AuthBlocBloc>().add(AuthLogoutRequested());
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
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
        ),
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
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 10),
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
          Text(label, style: TextStyle(fontSize: 13, color: valueColor)),
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
  final Color textColor;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.iconColor,
    required this.textColor,
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
                  style: TextStyle(
                    color: textColor,
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
