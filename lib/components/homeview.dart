import 'package:flutter/foundation.dart';

class HomeViewModel with ChangeNotifier {
  String? userType;
  void setUserType(String? newValue) {
    userType = newValue;
    notifyListeners();
  }
}
