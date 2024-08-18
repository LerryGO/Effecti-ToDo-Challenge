import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_challenge/src/features/auth/cubit/auth_cubit.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/helpers/messages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  late final AuthCubit controller;
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void initState() {
    controller = context.read<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar na conta'),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          switch (state.status) {
            case AuthStateStatus.error:
              Messages.showError(state.errorMessage!, context);
              break;
            case AuthStateStatus.loggedIn:
              Navigator.of(context).pop();
            default:
          }
        },
        builder: (context, state) {
          final status = state.status;
          return Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailEC,
                    decoration: const InputDecoration(
                      label: Text('E-mail'),
                    ),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('E-mail obrigatório'),
                        Validatorless.email('E-mail inválido'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: passwordEC,
                    decoration: const InputDecoration(
                      label: Text('Senha'),
                    ),
                    obscureText: true,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Senha obrigatório'),
                        Validatorless.min(
                            6, 'É preciso ter no mínimo 6 dígitos')
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48)),
                    onPressed: status == AuthStateStatus.loading
                        ? null
                        : () {
                            if (formKey.currentState?.validate() ?? false) {
                              controller.login(
                                  email: emailEC.text,
                                  password: passwordEC.text);
                            }
                          },
                    child: status == AuthStateStatus.loading
                        ? const SizedBox(
                            height: 40,
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : const Text('Entrar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
