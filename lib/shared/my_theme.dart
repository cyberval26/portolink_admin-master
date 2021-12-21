part of 'shared.dart';

class MyTheme{
  static ThemeData lightTheme(){
    return ThemeData(
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: const Color(0xFF14D7F3),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.permanentMarker().fontFamily
    );
  }
  static ThemeData darkTheme(){
    return ThemeData(
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: const Color(0xFF14D7F3),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.permanentMarker().fontFamily
    );
  }
}