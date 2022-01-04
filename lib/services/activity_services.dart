part of 'services.dart';

class ActivityServices {
  static String dateNow() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String result = formatter.format(now);
    return result;
  }
  static void showToast(String msg, Color mycolor) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: mycolor,
      textColor: Colors.white,
      fontSize: 14
    );
  }
  static Container loadings() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.black54,
      child: const SpinKitRipple(size: 500, color: Color(0xFF14D7F3))
    );
  }
  static String toIDR(String price) {
    final priceFormat = NumberFormat.currency(locale: 'ID');
    return priceFormat.format(double.parse(price));
  }
}