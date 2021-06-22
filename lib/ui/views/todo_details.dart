import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/services/extensions/extensions.dart';
import 'package:todo/core/viewmodels/todoDetails_model.dart';
import 'package:todo/ui/routes/router.gr.dart';
import 'package:todo/ui/shared/colorMap.dart';
import 'package:todo/ui/shared/styles.dart';

import '../../locator.dart';

class TodoDetails extends StatefulWidget {
  @override
  _TodoDetailsState createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => locator<TodoDetailsModel>(),
      child: Consumer<TodoDetailsModel>(
        builder: (context, model, child) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                model.todo.category,
              ),
            ),
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.4,
                    color: colorMap[model.todo.category],
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: size.height * 0.2,
                      width: size.width * 0.7,
                      child: SvgPicture.asset("assets/${model.todo.category}.svg"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                model.todo.title,
                                style: kLargeTextStyle,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                AutoRouter.of(context).push(TodoEditRoute());
                              },
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: colorMap[model.todo.category],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          model.todo.date.day.toString() + " " + model.todo.date.month.name(),
                          style: kMediumTextStyle,
                        ),
                        SizedBox(height: 30),
                        Text(
                          model.todo.details,
                          style: kSmallTextStyle,
                        ),
                      ],
                    ),
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
