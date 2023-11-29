import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '/routes.dart';
import '/presentation/bloc/profile_state.dart';
import '/presentation/shared_widgets/app_bar.dart';
import '/presentation/bloc/auth_bloc/auth_bloc.dart';
import '/presentation/bloc/auth_bloc/auth_event.dart';
import '/presentation/shared_widgets/page_layout.dart';
import '/presentation/pages/sign_in/widgets/sign_in_fields.dart';
import '/presentation/shared_widgets/auth_navigation_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _gKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _multiValidator = MultiValidator([
    RequiredValidator(errorText: 'This field cant be empty'),
    EmailValidator(errorText: 'Enter a valid email'),
  ]);

  void _signIn() async {
    if (!_gKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    context.read<AuthBloc>().add(OnSignIn(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      appBar: const AppBarWidget(
        title: 'Sign In',
      ),
      child: BlocListener<AuthBloc, ProfileState>(
        listener: (context, state) {
          if (state.profile != null) {
            Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
          }
        },
        child: Stack(
          children: [
            SignInFields(
              gKey: _gKey,
              emailController: _emailController,
              passwordController: _passwordController,
              multiValidator: _multiValidator,
              onSignIn: _signIn,
            ),
            AuthNavigationButton(
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed(Routes.signUp),
              text: 'Go to signUp',
              iconData: Icons.arrow_back,
            ),
          ],
        ),
      ),
    );
  }
}
