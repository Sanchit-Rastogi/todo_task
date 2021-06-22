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
                  themeCheckBox(0, ThemeMode.system, 'System Theme'),
                  themeCheckBox(1, ThemeMode.light, 'Light Theme'),
                  themeCheckBox(2, ThemeMode.dark, 'Dark Theme'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget themeCheckBox(int num, ThemeMode mode, String text) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ListTile(
      leading: Checkbox(
          value: model.themeValues[num],
          onChanged: (value) {
            model.updateThemeValue(num);
            themeProvider.setTheme(mode);
          }),
      title: Text(text),
    );
  }
}
