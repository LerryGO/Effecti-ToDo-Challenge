import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_challenge/src/features/todo/cubit/todo_cubit.dart';

import '../../../data/app_data.dart';
import '../../../routes/app_routes.dart';

class TodoDrawer extends StatefulWidget {
  const TodoDrawer({super.key});

  @override
  State<TodoDrawer> createState() => _TodoDrawerState();
}

class _TodoDrawerState extends State<TodoDrawer> {
  @override
  Widget build(BuildContext context) {
    final data = context.watch<AppData>();

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person,
                size: 48,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                data.user != null
                    ? 'Bem-vindo ${data.user?.name ?? 'Usuário'}'
                    : 'Usuário deslogado',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              Visibility(
                visible: data.user == null,
                replacement:
                    BlocSelector<TodoCubit, TodoState, TodoStateStatus>(
                  selector: (state) {
                    return state.status;
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.read<TodoCubit>().getSyncTasks();
                          },
                          child: state == TodoStateStatus.loading
                              ? const SizedBox(
                                  height: 24,
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : const Text("Sincronizar dados"),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () async {
                            await SharedPreferencesAsync().clear();
                            setState(() {
                              data.user = null;
                            });
                          },
                          child: const Text("Sair"),
                        ),
                      ],
                    );
                  },
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.of(context).pushNamed(AppRoutes.login);
                        setState(() {});
                      },
                      child: const Text("Entrar na conta"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.of(context)
                            .pushNamed(AppRoutes.userRegister);
                        setState(() {});
                      },
                      child: const Text("Criar conta"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
