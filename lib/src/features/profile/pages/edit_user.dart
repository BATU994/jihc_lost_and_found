import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jihc_landf/src/features/auth/data/models/userModel.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/shared_preferences.dart';
import 'package:jihc_landf/src/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:jihc_landf/src/features/home/presentation/widgets/build_dropdown.dart';
import 'package:jihc_landf/src/features/home/presentation/widgets/build_password_field.dart';
import 'package:jihc_landf/src/features/home/presentation/widgets/build_text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  ProfileInfo profileInfo = ProfileInfo();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  Map<String, dynamic>? user;
  final TextEditingController _groupController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  String selectedRole = "student";
  String? selectedGroup;

  @override
  void initState() {
    super.initState();
    setUp();
  }

  setUp() async {
    final info = await profileInfo.getProfileInfo();
    final userType = info['userType']?.toString().toLowerCase();

    setState(() {
      user = {
        "username": info['username'] ?? 'Unknown',
        "userId": info['userId'],
        "email": info['email'] ?? 'Unknown',
        "userType": userType,
        "group": info['group'] ?? 'Unknown',
      };

      selectedRole =
          userType == 'student'
              ? 'Student'
              : userType == 'staff'
              ? 'Staff'
              : 'Student';
    });

    _emailController.text = user?['email'];
    _groupController.text = user?['group'];
    _nameController.text = user?['username'];
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          BlocBuilder<AuthBlocBloc, AuthBlocState>(
            builder: (context, state) {
              if (state is UserDetailChanged) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile updated successfully")),
                );
                state = AuthBlocInitial();
              }
              return Container(
                margin: const EdgeInsets.only(right: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007AFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBlocBloc>().add(
                        UserChangeRequested(
                          validPassword: currentPasswordController.text,
                          userChanged: UserChangeModel(
                            username: _nameController.text,
                            password: newPasswordController.text,
                            email: _emailController.text,
                            userGroup: _groupController.text,
                            userType: selectedRole,
                          ),
                          userId: user?['userId'],
                        ),
                      );
                      if (state is ChangeFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Auth Fail")),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(radius: 45, backgroundColor: Colors.grey[200]),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF007AFF),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Tap to change the photo",
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
              const SizedBox(height: 30),
              BuildDropdown(
                title: "Role",
                value: selectedRole,
                items: const ["Student", "Staff"],
                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Group', textAlign: TextAlign.start),
                  SizedBox(height: 8),
                  BuildTextField(
                    label: "Group",
                    hint: "Enter your Group",
                    controller: _groupController,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name'),
                  SizedBox(height: 8),
                  BuildTextField(
                    label: "Name",
                    hint: "Enter your Name",
                    controller: _nameController,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email'),
                  SizedBox(height: 8),
                  BuildTextField(
                    label: "Email",
                    hint: "Enter your Email",
                    controller: _emailController,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Change Password",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              BuildPasswordField(
                label: "Current Password",
                controller: currentPasswordController,
              ),
              const SizedBox(height: 16),
              BuildPasswordField(
                label: "New Password",
                controller: newPasswordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
