part of 'widgets.dart';

class TimeInHourAndMinute extends StatefulWidget {
  @override
  _TimeInHourAndMinuteState createState() => _TimeInHourAndMinuteState();
}

class _TimeInHourAndMinuteState extends State<TimeInHourAndMinute> {
  @override
  void initState() {
    Provider.of<TimerProvider>(context, listen: false).startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(builder: (context, timer, _) {
      return Column(
        children: [
          Text(
            tanggal(timer.date),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            DateFormat('HH:mm').format(timer.date),
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      );
    });
  }
}
