part of 'providers.dart';

class MyTheme extends ChangeNotifier {
  bool _isLightTheme = true;

  void changeTheme() {
    _isLightTheme = !_isLightTheme;
    notifyListeners();
  }

  bool get isLightTheme => _isLightTheme;
}
