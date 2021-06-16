import 'package:flutter_test/flutter_test.dart';
import 'package:todo/core/viewmodels/profile_model.dart';

void main() {
  test("When called with a int id, the theme value list should be changed.",
      () {
    var model = ProfileModel();

    model.updateThemeValue(0);

    expect(model.themeValues, [true, false, false]);
  });
}
