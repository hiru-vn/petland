import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class Formart {
  static toVNDCurency(double value, {hasUnit = true}) {
    if (value == null) return '0 VND';
    final formatter = NumberFormat("#,##0");
    String newValue = formatter.format(value);
    return newValue + (hasUnit ? ' VND' : '');
  }

  static toUSDCurency(double value) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    String newValue = formatter.format(value);
    return newValue;
  }

  static String timeAgo(DateTime time) {
    if (time == null) return null;
    return timeago.format(time, locale: 'en_short');
  }

  static String timeByDay(DateTime time) {
    if (time == null) return null;
    DateTime now = DateTime.now();
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == now.year) {
      DateFormat format = DateFormat("hh:mm a");
      return format.format(time);
    }
    else return timeAgo(time);
  }

  static double toFixedDouble(double value, int digit) {
    return num.parse(value.toStringAsFixed(digit));
  }

  static String formatToDateTime(DateTime date) {
    if (date == null) return null;
    return '${formatToDate(date)} ${formatToTime(date)}';
  }

  static String formatToDate(DateTime date) {
    if (date == null) return null;
    return '${date.day}/${date.month}/${date.year}';
  }

  static String formatToTime(DateTime time) {
    if (time == null) return null;
    return '${time.hour}:${time.minute < 10 ? '0' : ''}${time.minute}';
  }

  static String formatNumber(double number) {
    final numberFormater = NumberFormat("#,##0.00", "en_US");
    return numberFormater.format(number);
  }

  static String formatErrFirebaseLoginToString(String err) {
    String message = "";
    switch (err) {
      case "ERROR_ARGUMENT_ERROR":
        message = "Vui lòng nhập đầy đủ dữ liệu";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        message = "Phương thức đăng nhập này chưa được cho phép";
        break;
      case "ERROR_USER_DISABLED":
        message = "Tài khoản này đã bị khoá";
        break;
      case "ERROR_INVALID_EMAIL":
        message = "Định dạng Email không đúng";
        break;
      case "ERROR_USER_NOT_FOUND":
        message = "Tài khoản không tồn tại";
        break;
      case "ERROR_WRONG_PASSWORD":
        message = "Sai mật khẩu, vui lòng nhập lại";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        message = "Quá giới hạn số lần đăng nhập, xin hãy thử lại sau vài phút";
        break;
      default:
        print(err);
        message = "Lỗi Đăng Nhập";
    }
    return message;
  }

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
