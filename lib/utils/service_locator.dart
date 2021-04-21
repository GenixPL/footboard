import 'package:footboard/data_providers/game_data_provider.dart';
import 'package:footboard/repositories/game_repository.dart';
import 'package:footboard/screens/games/cubit/games_screen_cubit.dart';
import 'package:footboard/screens/gamestest/cubit/games_screen_cubit.dart';
import 'package:footboard/screens/home/cubit/cubit.dart';
import 'package:footboard/utils/path/path_builder.dart';
import 'package:footboard/utils/path/pather.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void setupSl() {
  // region self-standing
  sl.registerSingleton(PathBuilder());
  sl.registerSingleton(Pather());
  // endregion

  // region DataProvider
  sl.registerSingleton(GameDataProvider());
  // endregion

  // region Repositories
  sl.registerSingleton(GameRepository());
  // endregion

  // region Cubits
  sl.registerFactory(() => HomeScreenCubit());
  sl.registerFactory(() => GamesScreenCubit());
  sl.registerFactory(() => GamesScreenTestCubit());
  // endregion
}
