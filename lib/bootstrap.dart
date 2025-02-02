import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_db_app/network/api_client/api_client.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    debugPrint('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    debugPrint(details.exceptionAsString());
    debugPrintStack(stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  setupLocator();

  // Add cross-flavor configuration here

  runApp(await builder());
}

final getIt = GetIt.instance;

void setupLocator() {
  // Register Dio instance
  getIt
    ..registerSingleton<Dio>(Dio())
    ..registerSingleton<ApiClient>(
      ApiClient(
        dio: getIt<Dio>(),
      ),
    );
}
