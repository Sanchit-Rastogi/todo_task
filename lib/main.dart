import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/services/provider/theme_provider.dart';
import 'package:todo/core/services/provider/todo_provider.dart';
import 'package:todo/locator.dart';
import 'package:todo/ui/routes/router.gr.dart';

void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TodoProvider(),
        ),
      ],
      builder: (context, _) {
        return MaterialApp.router(
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          debugShowCheckedModeBanner: false,
          title: 'ToDo App',
          themeMode: Provider.of<ThemeProvider>(context).themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
        );
      },
    );
  }
}
