import 'package:flutter/cupertino.dart';

class RentDuration extends ChangeNotifier {
  Object? howLong;

  changeDuration(val) {
    howLong = val;
    notifyListeners();
  }
}
