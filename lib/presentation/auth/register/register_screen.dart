import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/presentation/auth/register/cubit/register_screen_view_model.dart';
import '../../../core/di.dart';
import '../../utlis/custome_text_form_feild.dart';
import 'cubit/states.dart'; // Make sure to import the custom widget

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = 'Register Screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterScreenViewModel viewModel = RegisterScreenViewModel(
    registerUseCase: injectRegisterUseCase(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: viewModel,
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        } else if (state is RegisterSuccessState) {
          Navigator.of(context).pop(); // Dismiss the loading dialog
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.authResultEntity.userEntity?.username ?? "")));
        } else if (state is RegisterErrorState) {
          Navigator.of(context).pop(); // Dismiss the loading dialog
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Signup'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.formKey,
            child: ListView(
              children: <Widget>[
                CustomTextFormField(
                  label: 'Username',
                  controller: viewModel.userNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        label: 'First Name',
                        controller: viewModel.firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: CustomTextFormField(
                        label: 'Last Name',
                        controller: viewModel.lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }

                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                CustomTextFormField(
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: viewModel.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        label: 'Password',
                        isPassword: true,
                        controller: viewModel.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$').hasMatch(value)) {
                            return 'Password must be at least 11 characters long and include an uppercase letter, a lowercase letter, a number, and a special character';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: CustomTextFormField(
                        label: 'Confirm Password',
                        isPassword: true,
                        controller: viewModel.confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password again';
                          }
                          if (value != viewModel.passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                CustomTextFormField(
                  label: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  controller: viewModel.phoneNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(value)) {
                      return 'Phone number must be 11 digits long and start with 01';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    viewModel.register();
                  },
                  child: Text('Signup'),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to login screen
                  },
                  child: Text('Already have an account? Log in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
