import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '/presentation/shared_widgets/custom_text_field.dart';
import '/presentation/shared_widgets/standart_custom_button.dart';

class SignInFields extends StatelessWidget {
  final GlobalKey<FormState> gKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final MultiValidator multiValidator;
  final VoidCallback onSignIn;
  const SignInFields({
    super.key,
    required this.gKey,
    required this.emailController,
    required this.passwordController,
    required this.multiValidator,
    required this.onSignIn,
  });

  @override
  Widget build(BuildContext context) {
    const isObscure = true;
    return Form(
      key: gKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            textInputType: TextInputType.emailAddress,
            controller: emailController,
            validator: multiValidator,
            label: 'Email',
            fieldAction: TextInputAction.next,
          ),
          CustomTextField(
            textInputType: TextInputType.visiblePassword,
            controller: passwordController,
            validator: RequiredValidator(errorText: 'This field cant be empty'),
            label: 'Password',
            fieldAction: TextInputAction.done,
            obscureText: isObscure,
            maxLines: 1,
          ),
          const SizedBox(height: 10),
          StandartCustomButton(
            onPressed: onSignIn,
            label: 'Sign In',
            minumalSize: const Size(250, 50),
          ),
        ],
      ),
    );
  }
}
