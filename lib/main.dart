import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/theme_provider.dart';
import 'package:todo/provider/todo_provider.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/screens/profile.dart';
import 'package:todo/screens/todo_details.dart';
import 'package:todo/screens/todo_edit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ToDo App',
          themeMode: Provider.of<ThemeProvider>(context).themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: HomePage(),
          routes: {
            'home': (context) => HomePage(),
            'profile': (context) => Profile(),
            'todoDetails': (context) => TodoDetails(),
            'todoEdit': (context) => TodoEdit(),
          },
        );
      },
    );
  }
}
