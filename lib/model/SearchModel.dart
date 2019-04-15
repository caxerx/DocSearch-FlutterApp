import 'package:scoped_model/scoped_model.dart';

class SearchModel extends Model {
  String _keyword = "";
  String _specialty = "";
  String _language = "";
  String _gender = "";
  String _location = "";

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
