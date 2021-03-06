// ignore_for_file: prefer_const_constructors

part of 'widgets.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime _dateTime = DateTime.now();
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyTheme>(builder: (context, theme, _) {
      return Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      color: kShadowColor.withOpacity(0.14),
                      blurRadius: 64,
                    ),
                  ],
                ),
                child: Transform.rotate(
                  angle: -pi / 2,
                  child: CustomPaint(
                    painter: ClockPainter(context, _dateTime),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(iconsPath + 'clock_face.png',
                  color: theme.isLightTheme ? Colors.black : Colors.white),
            ),
          ),
          // Positioned(
          //   top: 70,
          //   left: 0,
          //   right: 0,
          //   child: Consumer<MyTheme>(
          //     builder: (context, theme, child) => GestureDetector(
          //       onTap: () => theme.changeTheme(),
          //       child: SvgPicture.asset(
          //         theme.isLightTheme
          //             ? "assets/icons/Sun.svg"
          //             : "assets/icons/Moon.svg",
          //         height: 24,
          //         width: 24,
          //         color: Theme.of(context).primaryColor,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      );
    });
  }
}
