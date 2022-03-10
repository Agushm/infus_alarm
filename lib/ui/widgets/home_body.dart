// ignore_for_file: prefer_const_constructors

part of 'widgets.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 20),
            TimeInHourAndMinute(),
            Spacer(),
            Clock(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
