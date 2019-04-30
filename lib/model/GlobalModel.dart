import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:scoped_model/scoped_model.dart';

class GlobalModel extends Model {

  String _keyword = "";
  String _specialty = "";
  String _language = "";
  String _gender = "";
  String _location = "";

  String _inputUsername = "";
  String _inputPassword = "";

  String _loggedInUserId = "-1";
  String _token = "";

  FirebaseMessaging _fcm;



  get fcm => _fcm;

  set fcm(k) {
    _fcm = k;
    notifyListeners();
  }




  get token => _token;

  set token(k) {
    _token = k;
    notifyListeners();
  }


  get loggedInUserId => _loggedInUserId;

  set loggedInUserId(k) {
    _loggedInUserId = k;
    notifyListeners();
  }

  get inputUsername => _inputUsername;

  set inputUsername(k) {
    _inputUsername = k;
    notifyListeners();
  }

  get inputPassword => _inputPassword;

  set inputPassword(k) {
    _inputPassword = k;
    notifyListeners();
  }

  get keyword => _keyword;

  set keyword(k) {
    _keyword = k;
    notifyListeners();
  }

  get specialty => _specialty;

  set specialty(k) {
    _specialty = k;
    notifyListeners();
  }

  get language => _language;

  set language(k) {
    _language = k;
    notifyListeners();
  }

  get gender => _gender;

  set gender(k) {
    _gender = k;
    notifyListeners();
  }

  get location => _location;

  set location(k) {
    _location = k;
    notifyListeners();
  }
}
