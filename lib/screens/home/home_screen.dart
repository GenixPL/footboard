import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footboard/utils/service_locator.dart';
import 'package:footboard/views/error_view.dart';
import 'package:footboard/views/loading_view.dart';

import 'cubit/cubit.dart';
import 'home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<HomeScreenCubit>(
          create: (BuildContext context) => sl()..init(),
          child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
            builder: (BuildContext context, HomeScreenState state) {
              if (state is HomeScreenLoadingState) {
                return const LoadingView();
              } else if (state is HomeScreenLoadedState) {
                return const HomeBody();
              }

              return ErrorView(
                title: 'Unhandled state: $state',
              );
            },
          ),
        ),
      ),
    );
  }
}
