import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasty_choise_customer/core/storage/pref/pref_keys.dart';
import 'package:tasty_choise_customer/future/auth/models/user_model.dart';

class SharedPrefController {
  static final SharedPrefController _instance =
      SharedPrefController._internal();

  late SharedPreferences _preferences;

  SharedPrefController._internal();

  factory SharedPrefController() => _instance;

  Future<SharedPreferences> initSharedPref() async =>
      _preferences = await SharedPreferences.getInstance();

  SharedPreferences get prefManager => _preferences;

  Future<bool> setToken(String token) async =>
      await _preferences.setString(PrefKeys.TOKEN, token);

  String? get getToken => _preferences.getString(PrefKeys.TOKEN);

  Future<bool> saveDataUser(UserModel user) async {
    await _preferences.setInt(PrefKeys.ID_USER, user.id ?? -1);
    await _preferences.setString(PrefKeys.NAME_USER, user.name ?? "");
    await _preferences.setString(PrefKeys.PHONE_USER, user.phone ?? "");
    await _preferences.setString(PrefKeys.TOKEN, user.token ?? "");
    return await _preferences.setString(PrefKeys.EMAIL, user.email ?? "");
  }

  UserModel getDataUser() {
    int id = _preferences.getInt(PrefKeys.ID_USER) ?? -1;
    String name = _preferences.getString(PrefKeys.NAME_USER) ?? "";
    String phone = _preferences.getString(PrefKeys.PHONE_USER) ?? "";
    String token = _preferences.getString(PrefKeys.TOKEN) ?? "";
    String email = _preferences.getString(PrefKeys.EMAIL) ?? "";

    return UserModel(
      id: id,
      name: name,
      phone: phone,
      token: token,
      email: email,
    );
  }

  Future<bool> setLang(String token) async =>
      await _preferences.setString(PrefKeys.LANG, token);

  String get getLang => _preferences.getString(PrefKeys.LANG) ?? 'ar';

  Future clearAllData() async {
    await _preferences.clear();
  }

  Future<bool> setImage(String image) async =>
      await _preferences.setString(PrefKeys.IMAGE_USER, image);

  String? getImage() => _preferences.getString(PrefKeys.IMAGE_USER);
}
