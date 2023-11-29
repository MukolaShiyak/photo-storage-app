import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/bloc/profile_state.dart';
import '/presentation/shared_widgets/app_bar.dart';
import '/presentation/bloc/auth_bloc/auth_bloc.dart';
import '/presentation/shared_widgets/api_loader.dart';

class PageLayout extends StatelessWidget {
  final Widget child;
  final AppBarWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  const PageLayout({ 
    super.key,
    required this.child,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        appBar: appBar,
        body: BlocListener<AuthBloc, ProfileState>(
          listener: (context, state) {
            if (state.status == ProfileStateStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height -
                      appBarHeight -
                      MediaQuery.of(context).padding.top,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: child,
                ),
                BlocBuilder<AuthBloc, ProfileState>(
                  builder: (context, state) {
                    if (state.status == ProfileStateStatus.loading)
                      return ApiLoader();
                    else
                      return SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
