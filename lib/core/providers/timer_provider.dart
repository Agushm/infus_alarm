// ignore_for_file: prefer_const_constructors
part of 'providers.dart';

class TimerProvider extends ChangeNotifier {
  late DateTime date = DateTime.now();

  startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (date.minute != TimeOfDay.now().minute) {
        date = DateTime.now();
        notifyListeners();
      }
    });
  }
}
