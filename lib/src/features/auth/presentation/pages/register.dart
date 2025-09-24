import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jihc_landf/src/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:jihc_landf/src/features/auth/presentation/pages/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _passwordVisible = false;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  bool studentTrue = true;
  String userType = 'student';
  final TextEditingController _groupController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String gender = '';
  String group = '';
  String name = '';
  String email = '';
  String password = '';
  Color buttonColor = Color.fromRGBO(0, 119, 255, 1);
  String buttonText = 'SIGN UP';
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: BlocConsumer<AuthBlocBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthBlocSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Registration Successful!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Registration Failed: ${state.failMessage}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 30, 16, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Image.asset(
                      'assets/jihc_logo.png',
                      width: screenWidth * 0.15,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Registration',
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'It only takes a minute',
                      style: TextStyle(
                        fontSize: screenWidth * 0.036,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "I'm a:",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10),
                                userClass(),
                                SizedBox(height: 15),
                                userGender(),
                                SizedBox(height: 15),
                                studentTrue
                                    ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Group:",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        TextFormField(
                                          controller: _groupController,
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                !RegExp(
                                                  r'^[A-Z 0-9]+$',
                                                ).hasMatch(value!)) {
                                              return 'Please enter a valid group (e.g., 3F1, 1F3)';
                                            } else {
                                              return null;
                                            }
                                          },
                                          onChanged: (value) {
                                            group = value;
                                            print(group);
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Enter your group',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  vertical: 15,
                                                  horizontal: 20,
                                                ),
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                      ],
                                    )
                                    : SizedBox.shrink(),

                                Text(
                                  "Full Name:",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _nameController,
                                  onChanged: (value) {
                                    name = value;
                                    print(name);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        RegExp(
                                          r'^[a-z A-Z] + [a-z A-Z]+$',
                                        ).hasMatch(value!)) {
                                      return 'Please enter your name properly';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText:
                                        'Enter your Full Name ( First Name, Last Name)',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _emailController,
                                  onChanged: (value) {
                                    if (value == null || value.isEmpty) {}
                                    email = value;
                                    print(email);
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                        ).hasMatch(value!)) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter your Email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),

                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "Password",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _passwordController,
                                  onChanged: (value) {
                                    password = value;
                                    print(password);
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 6) {
                                      return 'Password must be at least 6 characters long';
                                    }
                                    return null;
                                  },
                                  obscureText: !_passwordVisible,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        !_passwordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                    hintText: 'Enter your Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Get latest values from controllers
                                    name = _nameController.text.trim();
                                    email = _emailController.text.trim();
                                    password = _passwordController.text.trim();
                                    group = _groupController.text.trim();

                                    // Validate all fields
                                    if (name.isEmpty || email.isEmpty || password.isEmpty || gender.isEmpty || userType.isEmpty || (studentTrue && group.isEmpty)) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Please fill all fields.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        buttonColor = Color.fromRGBO(0, 99, 204, 1);
                                        buttonText = 'REGISTERING...';
                                      });
                                      // Debug print the data being sent
                                      print('Registering with:');
                                      print('email: $email');
                                      print('name: $name');
                                      print('password: $password');
                                      print('gender: $gender');
                                      print('group: $group');
                                      print('userType: $userType');
                                      context.read<AuthBlocBloc>().add(
                                        AuthRegisterRequested(
                                          email: email,
                                          name: name,
                                          password: password,
                                          gender: gender,
                                          group: group,
                                          userType: userType,
                                        ),
                                      );
                                      Future.delayed(Duration(seconds: 2), () {
                                        setState(() {
                                          buttonColor = Color.fromRGBO(0, 119, 255, 1);
                                          buttonText = 'SIGN UP';
                                        });
                                      });
                                    }
                                  },
                                  child: Text(
                                    buttonText,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: buttonColor,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 17),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                              Text('Or', style: TextStyle(fontSize: 20)),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Already have an account? Sign in",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[600],
                                  decoration: TextDecoration.underline,
                                ),
                              ),
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
    );
  }

  Row userClass() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                studentTrue = true;
                userType = 'student';
              });
              print(userType);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  studentTrue
                      ? Color.fromRGBO(228, 238, 253, 1)
                      : Color.fromRGBO(253, 251, 253, 1),
              foregroundColor:
                  studentTrue
                      ? Color.fromRGBO(0, 119, 255, 1)
                      : Color.fromRGBO(127, 125, 124, 1),
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color:
                      studentTrue
                          ? Color.fromRGBO(0, 119, 255, 1)
                          : Color.fromRGBO(236, 234, 233, 1),
                  width: 1.5,
                ),
              ),
            ),
            child: Text('Student'),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                studentTrue = false;
                userType = 'staff';
              });
              print(userType);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  studentTrue
                      ? Color.fromRGBO(253, 251, 253, 1)
                      : Color.fromRGBO(228, 238, 253, 1),
              foregroundColor:
                  studentTrue
                      ? Color.fromRGBO(127, 125, 124, 1)
                      : Color.fromRGBO(0, 119, 255, 1),
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color:
                      studentTrue
                          ? Color.fromRGBO(236, 234, 233, 1)
                          : Color.fromRGBO(0, 119, 255, 1),
                  width: 1.5,
                ),
              ),
            ),
            child: Text('Staff'),
          ),
        ),
      ],
    );
  }

  Row userGender() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                gender = 'male';
              });
              print(gender);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  gender == 'male'
                      ? Color.fromRGBO(228, 238, 253, 1)
                      : Color.fromRGBO(253, 251, 253, 1),
              foregroundColor:
                  gender == 'male'
                      ? Color.fromRGBO(0, 119, 255, 1)
                      : Color.fromRGBO(127, 125, 124, 1),
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color:
                      gender == 'male'
                          ? Color.fromRGBO(0, 119, 255, 1)
                          : Color.fromRGBO(236, 234, 233, 1),
                  width: 1.5,
                ),
              ),
            ),
            child: Text('Male'),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                gender = 'female';
              });
              print(gender);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  gender == 'female'
                      ? Color.fromRGBO(253, 251, 253, 1)
                      : Color.fromRGBO(228, 238, 253, 1),
              foregroundColor:
                  gender == 'female'
                      ? Color.fromRGBO(127, 125, 124, 1)
                      : Color.fromRGBO(0, 119, 255, 1),
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color:
                      gender == 'female'
                          ? Color.fromRGBO(236, 234, 233, 1)
                          : Color.fromRGBO(0, 119, 255, 1),
                  width: 1.5,
                ),
              ),
            ),
            child: Text('Female'),
          ),
        ),
      ],
    );
  }
}

