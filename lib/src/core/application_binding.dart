import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_challenge/src/data/app_data.dart';

import 'restClient/rest_client.dart';

class ApplicationBinding extends StatelessWidget {
  final Widget child;

  const ApplicationBinding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<RestClient>(
            create: (context) => RestClient(),
          ),
          Provider(
            create: (context) => AppData(),
          ),
          
        ],
        builder: (context, _) {
          return child;
        });
  }
}
