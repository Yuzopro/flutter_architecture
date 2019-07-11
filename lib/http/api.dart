class Api {
  static const String _BASE_URL = "https://api.github.com/";

  static String authorizations() {
    return "${_BASE_URL}authorizations";
  }

  static getMyUserInfo() {
    return "${_BASE_URL}user";
  }
}
