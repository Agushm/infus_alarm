// ignore_for_file: prefer_const_constructors

part of 'constants.dart';

class Constants {
  static Color primary = const Color(0xFF000000);
  static Color red = const Color(0xFFFF0000);
  static Color blue = const Color(0xFF0176E8);
  static Color grey = const Color(0xFFEBEBEB);
  static Color green = const Color(0xFF60C59F);
  static Color btnCopy = const Color(0xff508DCB);
  static Color gold = const Color(0xffFFD700);
}

// Colors
const kPrimaryColor = Color(0xFFFF97B3);
const kSecondaryLightColor = Color(0xFFE4E9F2);
const kSecondaryDarkColor = Color(0xFF404040);
const kAccentLightColor = Color(0xFFB3BFD7);
const kAccentDarkColor = Color(0xFF4E4E4E);
const kBackgroundDarkColor = Color(0xFF3A3A3A);
const kSurfaceDarkColor = Color(0xFF222225);
// Icon Colors
const kAccentIconLightColor = Color(0xFFECEFF5);
const kAccentIconDarkColor = Color(0xFF303030);
const kPrimaryIconLightColor = Color(0xFFECEFF5);
const kPrimaryIconDarkColor = Color(0xFF232323);
// Text Colors
const kBodyTextColorLight = Color(0xFFA1B0CA);
const kBodyTextColorDark = Color(0xFF7C7C7C);
const kTitleTextLightColor = Color(0xFF101112);
const kTitleTextDarkColor = Colors.white;

const kShadowColor = Color(0xFF364564);

String iconsPath = 'assets/icons/';
String imagesPath = 'assets/images/';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    appBarTheme: appBarTheme.copyWith(
      iconTheme: IconThemeData(color: Colors.black),
    ),
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: kSecondaryLightColor,
      // on light theme surface = Colors.white by default
    ),
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: kBodyTextColorLight),
    primaryIconTheme: IconThemeData(color: kPrimaryIconLightColor),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyText1: TextStyle(color: kBodyTextColorLight),
      bodyText2: TextStyle(color: kBodyTextColorLight),
      headline4: TextStyle(color: kTitleTextLightColor, fontSize: 32),
      headline1: TextStyle(color: kTitleTextLightColor, fontSize: 80),
    ),
  );
}

// Dark Them
ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Color(0xFF0D0C0E),
    appBarTheme: appBarTheme.copyWith(
      iconTheme: IconThemeData(color: kBodyTextColorDark),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: kSecondaryDarkColor,
      surface: kSurfaceDarkColor,
    ),
    backgroundColor: kBackgroundDarkColor,
    iconTheme: IconThemeData(color: kBodyTextColorDark),
    primaryIconTheme: IconThemeData(color: kPrimaryIconDarkColor),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyText1: TextStyle(color: kBodyTextColorDark),
      bodyText2: TextStyle(color: kBodyTextColorDark),
      headline4: TextStyle(color: kTitleTextDarkColor, fontSize: 32),
      headline1: TextStyle(color: kTitleTextDarkColor, fontSize: 80),
    ),
  );
}

AppBarTheme appBarTheme = AppBarTheme(color: Colors.transparent, elevation: 0);

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 896 is the layout height that designer use
  // or you can say iPhone 11
  return (inputHeight / 896.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 414 is the layout width that designer use
  return (inputWidth / 414.0) * screenWidth;
}

DataTable commonTable({List<DataColumn>? columns, List<DataRow>? rows}) {
  return DataTable(
    columnSpacing: 40,
    horizontalMargin: 40,
    headingRowHeight: 40,
    dataRowHeight: 40,
    columns: columns!,
    rows: rows!,
    dataTextStyle: TextStyle(color: Colors.black87),
    headingTextStyle: TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue),
  );
}

InputDecoration decorationForm = InputDecoration(
  fillColor: Colors.grey[100],
  filled: true,
  border: OutlineInputBorder(
      borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
  isDense: true, // Added this
  contentPadding: EdgeInsets.all(15), // Added this
  hintStyle: TextStyle(fontSize: 12, color: Colors.black54),
);
