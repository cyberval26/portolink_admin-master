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
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: mycolor,
        textColor: Colors.black,
        fontSize: 14);
  }
  static Container loadings() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.black26,
      child: const SpinKitFadingCircle(size: 50, color: Colors.green),
    );
  }
  static String toIDR(String price) {
    final priceFormat = NumberFormat.currency(locale: 'ID');
    return priceFormat.format(double.parse(price));
  }
}