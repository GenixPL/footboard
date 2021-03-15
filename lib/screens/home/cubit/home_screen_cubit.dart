import 'package:bloc/bloc.dart';

import 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(const HomeScreenLoadingState());

  // Do all the stuff that needs to be initialized before the app can work.
  Future<void> init() async {
    emit(const HomeScreenLoadedState());
  }
}
