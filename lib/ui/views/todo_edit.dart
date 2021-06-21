import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/core/models/todo.dart';
import 'package:todo/core/services/extensions/extensions.dart';
import 'package:todo/core/services/provider/todo_provider.dart';
import 'package:todo/core/viewmodels/todoEdit_model.dart';
import 'package:todo/ui/routes/router.gr.dart';
import 'package:todo/ui/shared/colorMap.dart';
import 'package:todo/ui/shared/styles.dart';

import '../../locator.dart';

class TodoEdit extends StatefulWidget {
  @override
  _TodoEditState createState() => _TodoEditState();
}

class _TodoEditState extends State<TodoEdit> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  final model = locator<TodoEditModel>();

  @override
  void initState() {
    final todoProvider = locator<TodoProvider>();
    model.onInit();
    titleController.text = todoProvider.selectedTodo.title;
    detailsController.text = todoProvider.selectedTodo.details;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = locator<TodoProvider>();
    return ChangeNotifierProvider<TodoEditModel>(
      create: (context) => model,
      child: Consumer<TodoEditModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                model.currentDate.year.toString() + "  " + model.currentDate.month.name(),
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
              ),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            body: SafeArea(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 20),
                        TableCalendar(
                          headerVisible: false,
                          focusedDay: model.focusedDay,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          firstDay: model.currentDate,
                          lastDay: model.currentDate.add(
                            Duration(days: 30),
                          ),
                          selectedDayPredicate: (day) {
                            return isSameDay(model.selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            if (!isSameDay(model.selectedDay, selectedDay)) {
                              setState(() {
                                model.selectedDay = selectedDay;
                                model.focusedDay = focusedDay;
                              });
                            }
                          },
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          height: 40,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1, color: colorMap[model.selectedCategory] ?? kFamilyColor),
                              bottom: BorderSide(width: 1, color: colorMap[model.selectedCategory] ?? kFamilyColor),
                              left: BorderSide(width: 1, color: colorMap[model.selectedCategory] ?? kFamilyColor),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    model.changeCategory('Work');
                                  },
                                  child: CategoryBox(boxColor: colorMap[model.selectedCategory] ?? kFamilyColor, isSelected: model.categorySelection['Work'] ?? false, category: 'Work'),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    model.changeCategory('Fun');
                                  },
                                  child: CategoryBox(boxColor: colorMap[model.selectedCategory] ?? kFamilyColor, isSelected: model.categorySelection['Fun'] ?? false, category: 'Fun'),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    model.changeCategory('Sport');
                                  },
                                  child: CategoryBox(boxColor: colorMap[model.selectedCategory] ?? kFamilyColor, isSelected: model.categorySelection['Sport'] ?? false, category: 'Sport'),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    model.changeCategory('Study');
                                  },
                                  child: CategoryBox(boxColor: colorMap[model.selectedCategory] ?? kFamilyColor, isSelected: model.categorySelection['Study'] ?? false, category: 'Study'),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    model.changeCategory('Family');
                                  },
                                  child: CategoryBox(boxColor: colorMap[model.selectedCategory] ?? kFamilyColor, isSelected: model.categorySelection['Family'] ?? false, category: 'Family'),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    model.changeCategory('Birth');
                                  },
                                  child: CategoryBox(boxColor: colorMap[model.selectedCategory] ?? kFamilyColor, isSelected: model.categorySelection['Birth'] ?? false, category: 'Birth'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Title',
                            ),
                            controller: titleController,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Details',
                            ),
                            minLines: 5,
                            maxLines: 6,
                            controller: detailsController,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          TodoModel todo = TodoModel(
                            details: detailsController.text,
                            category: model.selectedCategory,
                            title: titleController.text,
                            date: model.selectedDay ?? model.currentDate,
                            id: todoProvider.selectedTodo.id ?? null,
                          );
                          model.updateOrAdd(todo);
                          AutoRouter.of(context).push(HomePageRoute());
                          Fluttertoast.showToast(
                            msg: 'To Do saved successfully',
                            toastLength: Toast.LENGTH_SHORT,
                          );
                          locator<TodoProvider>().loadTodo();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: colorMap[model.selectedCategory],
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoryBox extends StatelessWidget {
  final Color boxColor;
  final bool isSelected;
  final String category;

  CategoryBox({required this.boxColor, required this.isSelected, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? boxColor : Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          right: BorderSide(width: 1, color: boxColor),
        ),
      ),
      child: Text(
        category,
        style: TextStyle(
          color: boxColor == Colors.black && isSelected ? Colors.white : Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
