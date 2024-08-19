import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_challenge/src/core/ui/helpers/form_helper.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/helpers/messages.dart';
import '../cubit/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final AuthCubit controller;
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void initState() {
    controller = context.read<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<AuthCubit, AuthState>(
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
            return Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameEC,
                    onTapOutside: (_) => context.unfocus(),
                    decoration: const InputDecoration(
                      label: Text('Nome'),
                    ),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Nome obrigatório'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: emailEC,
                    onTapOutside: (_) => context.unfocus(),
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
                    onTapOutside: (_) => context.unfocus(),
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
                    onPressed: state.status == AuthStateStatus.loading
                        ? null
                        : () {
                            if (formKey.currentState?.validate() ?? false) {
                              controller.registerUser(
                                  name: nameEC.text,
                                  email: emailEC.text,
                                  password: passwordEC.text);
                            }
                          },
                    child: state.status == AuthStateStatus.loading
                        ? const SizedBox(
                            height: 40,
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : const Text('Entrar'),
                  ),
                ],
              ),
            );
          },
        ),
      )),
    );
  }
}
