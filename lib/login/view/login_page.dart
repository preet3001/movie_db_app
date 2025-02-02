import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/l10n/l10n.dart';
import 'package:movie_db_app/login/bloc/login_bloc/login_bloc.dart';
import 'package:movie_db_app/login/bloc/login_bloc/login_event.dart';
import 'package:movie_db_app/login/bloc/login_bloc/login_state.dart';
import 'package:movie_db_app/login/cubit/password_visibility_cubit/password_visibility_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => PasswordVisibilityCubit()),
      ],
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.loginAppBarTitle,
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 22,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: Text(context.l10n.email),
                ),
                validator: (value) {
                  if (value == null) {
                    return context.l10n.emailValidation;
                  }

                  final emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(value);
                  if (!emailValid) {
                    return context.l10n.emailValidation;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<PasswordVisibilityCubit, bool>(
                builder: (context, isObscure) {
                  return TextFormField(
                    controller: passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      label: Text(context.l10n.password),
                      suffixIcon: IconButton(
                        onPressed: () => context
                            .read<PasswordVisibilityCubit>()
                            .toggleVisibility(),
                        icon: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isNotEmpty ?? false) {
                        return null;
                      }
                      return context.l10n.passwordValidation;
                    },
                  );
                },
              ),
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                switch (state) {
                  case LoginSuccess():
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.l10n.loginSuccess),
                      ),
                    );
                  //navigate
                  case LoginFailure():
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.l10n.loginFailed),
                      ),
                    );
                  default:
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromWidth(120),
                  ),
                  onPressed: () {
                    final isValid = formKey.currentState!.validate();
                    if (isValid) {
                      context.read<LoginBloc>().add(
                            LoginSubmitted(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                    }
                  },
                  child: switch (state) {
                    LoginLoading() => const SizedBox(
                        height: 20,
                        width: 20,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    _ => Text(context.l10n.loginAppBarTitle),
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
