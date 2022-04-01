part of 'pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => MainPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Spacer(),
          Image.asset(
            iconsPath + 'logo.png',
            width: 150,
            height: 150,
          ),
          Spacer(),
          Text(
            'SIMPECI',
            style: TextStyle(
                fontSize: 20,
                color: Constants.primary,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Aplikasi Monitoring Pemberian Carian Infus',
            style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 60)
        ],
      )),
    );
  }
}
