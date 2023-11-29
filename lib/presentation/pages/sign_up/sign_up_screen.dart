import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:photo_uploader/presentation/shared_widgets/auth_navigation_button.dart';

import '/routes.dart';
import '/presentation/bloc/profile_state.dart';
import '/presentation/shared_widgets/app_bar.dart';
import '/presentation/bloc/auth_bloc/auth_bloc.dart';
import '/presentation/bloc/auth_bloc/auth_event.dart';
import '/presentation/shared_widgets/page_layout.dart';
import '/presentation/pages/sign_up/widgets/sign_up_fields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _gKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _multiValidator = MultiValidator([
    RequiredValidator(errorText: 'This field cant be empty'),
    EmailValidator(errorText: 'Enter a valid email'),
  ]);

  void _signUp() async {
    if (!_gKey.currentState!.validate()) return;

    try {
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(OnSignUp(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      appBar: const AppBarWidget(
        title: 'Sign Up',
      ),
      child: BlocListener<AuthBloc, ProfileState>(
        listener: (context, state) {
          if (
              // state is ProfileStateHasData
              state.profile != null) {
            Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
          }
        },
        child: Stack(
          children: [
            SignUpFields(
              gKey: _gKey,
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
              emailController: _emailController,
              passwordController: _passwordController,
              multiValidator: _multiValidator,
              onSignUp: _signUp,
            ),
            AuthNavigationButton(
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed(Routes.signIn),
              text: 'Go to signIn',
              iconData: Icons.arrow_forward,
              positionRight: 0,
            ),
          ],
        ),
      ),
    );
  }
}
