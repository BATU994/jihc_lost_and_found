import 'package:flutter/material.dart';
import 'package:jihc_landf/navBuild.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/user_repository_impl.dart';
import 'package:jihc_landf/src/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:jihc_landf/src/features/auth/presentation/pages/register.dart';
import 'package:jihc_landf/src/features/home/data/repositories/itemRepositoryImpl.dart';
import 'package:jihc_landf/src/features/home/presentation/bloc/item_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final _formKey = GlobalKey<FormState>();
    Color buttonColor = Color.fromRGBO(0, 119, 255, 1);
    String buttonText = 'SIGN IN';
    return Scaffold(
      body: BlocConsumer<AuthBlocBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthBlocAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const NavBuild()),
            );
          }
        },
        builder: (context, state) {
          String? errorMsg;
          if (state is AuthFailed) {
            errorMsg = state.failMessage;
          }
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 30, 16, 20),
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
                      'Welcome Back 👋🏻',
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Please enter your details',
                      style: TextStyle(
                        fontSize: screenWidth * 0.036,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (errorMsg != null) ...[
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              errorMsg,
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Troubleshooting tips:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '- Make sure your email/username and password are correct.',
                            ),
                            Text(
                              '- If you just registered, check your credentials.',
                            ),
                            Text('- If the problem persists, contact support.'),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email:",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              final v = value ?? '';
                              // Correct email regex (no literal $ at end)
                              final ok = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[A-Za-z]{2,}$',
                              ).hasMatch(v);
                              if (v.isEmpty || !ok)
                                return 'Please enter a valid email';
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Password:",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _passwordController,
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
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    email = _emailController.text.trim();
                                    password = _passwordController.text.trim();
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        buttonColor = Color.fromRGBO(
                                          0,
                                          99,
                                          204,
                                          1,
                                        );
                                        buttonText = 'REGISTERING...';
                                      });

                                      context.read<AuthBlocBloc>().add(
                                        AuthLoginRequested(
                                          email: email,
                                          password: password,
                                        ),
                                      );
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
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: Colors.grey, thickness: 1),
                        ),
                        Text('Or', style: TextStyle(fontSize: 20)),
                        Expanded(
                          child: Divider(color: Colors.grey, thickness: 1),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.grey),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/google_logo.png',
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider<ItemBloc>(
                                        create:
                                            (_) => ItemBloc(
                                              ItemRepositoryImpl(Dio()),
                                            )..add(
                                              FetchItems(),
                                            ), // fetch items immediately
                                      ),
                                      BlocProvider<AuthBlocBloc>(
                                        create:
                                            (_) => AuthBlocBloc(
                                              UserRepositoryImpl(),
                                            ),
                                      ),
                                    ],
                                    child: RegisterPage(),
                                  ),
                            ),
                          );
                        },
                        child: Text(
                          "Don't have an account? Sign Up",
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
            ),
          );
        },
      ),
    );
  }
}
