import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/login/bloc/login_bloc/login_event.dart';
import 'package:movie_db_app/login/bloc/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      // ignore: inference_failure_on_instance_creation
      await Future.delayed(const Duration(seconds: 1));
      debugPrint('${event.email}, ${event.password}');
      if (event.email == 'admin@gmail.com' && event.password == 'admin') {
        emit(LoginSuccess());
      } else {
        emit(const LoginFailure(errorMessage: 'Invalid Credentials'));
      }
    });
  }
}
