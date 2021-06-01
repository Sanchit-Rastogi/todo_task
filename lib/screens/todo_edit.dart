import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/constants/colorMap.dart';
import 'package:todo/constants/extensions.dart';
import 'package:todo/constants/styles.dart';
import 'package:todo/models/todoModel.dart';
import 'package:todo/provider/todo_provider.dart';

class TodoEdit extends StatefulWidget {
  @override
  _TodoEditState createState() => _TodoEditState();
}

class _TodoEditState extends State<TodoEdit> {
  DateTime currentDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String selectedCategory = "Fun";

  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  List<String> categories = ['Work', 'Fun', 'Sport', 'Study', 'Family', 'Birth'];

  Map<String, bool> categorySelection = {
    'Work': false,
    'Fun': true,
    'Sport': false,
    'Study': false,
    'Family': false,
    'Birth': false,
  };

  void changeCategory(String cat) {
    categorySelection.forEach((key, value) {
      if (key == cat) {
        setState(() {
          categorySelection[key] = true;
          selectedCategory = cat;
        });
      } else
        setState(() {
          categorySelection[key] = false;
        });
    });
  }

  void updateOrAdd(TodoModel todo) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    if (todoProvider.selectedTodo.id != null) {
      print('updated');
      todoProvider.updateTodo(todo);
    } else {
      print('created');
      todoProvider.addTodo(todo);
    }
    Navigator.pushNamed(context, 'home');
  }

  @override
  void initState() {
    final selectedTodo = Provider.of<TodoProvider>(context, listen: false).selectedTodo;
    titleController.text = selectedTodo.title;
    detailsController.text = selectedTodo.details;
    selectedCategory = selectedTodo.category;
    _selectedDay = selectedTodo.date;
    changeCategory(selectedCategory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          currentDate.year.toString() + "  " + currentDate.month.name(),
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
                    focusedDay: _focusedDay,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    firstDay: currentDate,
                    lastDay: currentDate.add(
                      Duration(days: 30),
                    ),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
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
                        top: BorderSide(width: 1, color: colorMap[selectedCategory] ?? kFamilyColor),
                        bottom: BorderSide(width: 1, color: colorMap[selectedCategory] ?? kFamilyColor),
                        left: BorderSide(width: 1, color: colorMap[selectedCategory] ?? kFamilyColor),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              changeCategory('Work');
                            },
                            child: CategoryBox(boxColor: colorMap[selectedCategory] ?? kFamilyColor, isSelected: categorySelection['Work'] ?? false, category: 'Work'),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              changeCategory('Fun');
                            },
                            child: CategoryBox(boxColor: colorMap[selectedCategory] ?? kFamilyColor, isSelected: categorySelection['Fun'] ?? false, category: 'Fun'),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              changeCategory('Sport');
                            },
                            child: CategoryBox(boxColor: colorMap[selectedCategory] ?? kFamilyColor, isSelected: categorySelection['Sport'] ?? false, category: 'Sport'),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              changeCategory('Study');
                            },
                            child: CategoryBox(boxColor: colorMap[selectedCategory] ?? kFamilyColor, isSelected: categorySelection['Study'] ?? false, category: 'Study'),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              changeCategory('Family');
                            },
                            child: CategoryBox(boxColor: colorMap[selectedCategory] ?? kFamilyColor, isSelected: categorySelection['Family'] ?? false, category: 'Family'),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              changeCategory('Birth');
                            },
                            child: CategoryBox(boxColor: colorMap[selectedCategory] ?? kFamilyColor, isSelected: categorySelection['Birth'] ?? false, category: 'Birth'),
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
                      category: selectedCategory,
                      title: titleController.text,
                      date: _selectedDay ?? currentDate,
                      id: todoProvider.selectedTodo.id ?? null,
                    );
                    updateOrAdd(todo);
                    Fluttertoast.showToast(
                      msg: 'To Do saved successfully',
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: colorMap[selectedCategory],
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
