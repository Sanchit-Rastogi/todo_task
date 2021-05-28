import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/styles.dart';
import 'package:todo/provider/theme_provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<bool> themeValues = [true, false, false];

  void updateThemeValue(int id) {
    for (int i = 0; i < 3; i++) {
      if (i == id) {
        setState(() {
          themeValues[i] = true;
        });
      } else {
        setState(() {
          themeValues[i] = false;
        });
      }
    }
  }

  @override
  void initState() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    if (themeProvider.themeMode == ThemeMode.dark)
      updateThemeValue(2);
    else if (themeProvider.themeMode == ThemeMode.light) updateThemeValue(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Text(
              "Set App Theme",
              style: kMediumTextStyle,
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Checkbox(
                  value: themeValues[0],
                  onChanged: (value) {
                    updateThemeValue(0);
                    themeProvider.setTheme(ThemeMode.system);
                  }),
              title: Text('System Default'),
            ),
            ListTile(
              leading: Checkbox(
                  value: themeValues[1],
                  onChanged: (value) {
                    updateThemeValue(1);
                    themeProvider.setTheme(ThemeMode.light);
                  }),
              title: Text('Light Theme'),
            ),
            ListTile(
              leading: Checkbox(
                  value: themeValues[2],
                  onChanged: (value) {
                    updateThemeValue(2);
                    themeProvider.setTheme(ThemeMode.dark);
                  }),
              title: Text('Dark Theme'),
            ),
          ],
        ),
      ),
    );
  }
}
