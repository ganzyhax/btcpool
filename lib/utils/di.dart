import 'package:get_it/get_it.dart';
import 'package:btcpool_app/app/screens/dashboard/bloc/dashboard_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => DashboardBloc());
}
