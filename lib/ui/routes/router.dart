import 'package:auto_route/auto_route.dart';
import 'package:todo/ui/views/home.dart';
import 'package:todo/ui/views/profile.dart';
import 'package:todo/ui/views/todo_details.dart';
import 'package:todo/ui/views/todo_edit.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: Profile),
    AutoRoute(page: TodoDetails),
    AutoRoute(page: TodoEdit),
  ],
)
class $AppRouter {}
