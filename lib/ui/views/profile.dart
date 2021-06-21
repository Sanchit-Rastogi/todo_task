import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/services/provider/theme_provider.dart';
import 'package:todo/core/viewmodels/profile_model.dart';
import 'package:todo/locator.dart';
import 'package:todo/ui/shared/styles.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final model = locator<ProfileModel>();

  @override
  void initState() {
    model.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ChangeNotifierProvider<ProfileModel>(
      create: (context) => model,
      child: Consumer<ProfileModel>(
        builder: (context, model, child) {
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
                        key: Key('system'),
                        value: model.themeValues[0],
                        onChanged: (value) {
                          model.updateThemeValue(0);
                          themeProvider.setTheme(ThemeMode.system);
                        }),
                    title: Text('System Default'),
                  ),
                  ListTile(
                    leading: Checkbox(
                        key: Key('light'),
                        value: model.themeValues[1],
                        onChanged: (value) {
                          model.updateThemeValue(1);
                          themeProvider.setTheme(ThemeMode.light);
                        }),
                    title: Text('Light Theme'),
                  ),
                  ListTile(
                    leading: Checkbox(
                        key: Key('dark'),
                        value: model.themeValues[2],
                        onChanged: (value) {
                          model.updateThemeValue(2);
                          themeProvider.setTheme(ThemeMode.dark);
                        }),
                    title: Text('Dark Theme'),
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
