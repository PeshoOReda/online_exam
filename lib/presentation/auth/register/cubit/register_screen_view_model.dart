import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam/domain/use_case/register_use_case.dart';
import 'package:online_exam/presentation/auth/register/cubit/states.dart';

class RegisterScreenViewModel extends Cubit<RegisterState> {
  RegisterScreenViewModel({required this.registerUseCase}) : super(RegisterInitialState());

  var formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController(text: '5mar123');
  var firstNameController = TextEditingController(text: 'Elevate');
  var lastNameController = TextEditingController(text: 'Tech');
  var emailController = TextEditingController(text: 'ampar133@1elevate.com');
  var passwordController = TextEditingController(text: 'Elevate@123');
  var confirmPasswordController = TextEditingController(text: 'Elevate@123');
  var phoneNumberController = TextEditingController(text: '01094557510');
  bool obscurePassword = true;

  final RegisterUseCase registerUseCase;

  void register() async {
    if (formKey.currentState?.validate() != true) {
      return;
    }

    emit(RegisterLoadingState());
    var either = await registerUseCase.invoke(
        userNameController.text,
        firstNameController.text,
        lastNameController.text,
        emailController.text,
        passwordController.text,
      confirmPasswordController.text,
        phoneNumberController.text,
        );

    either.fold(
      (l) {
        emit(RegisterErrorState(l.errorMessage!));
      },
      (r) {
        emit(RegisterSuccessState(authResultEntity: r));
      },
    );
  }
}
