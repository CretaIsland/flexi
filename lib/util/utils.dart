class FlexiUtils {

  static bool deviceCheck(String deviceId) {
    RegExp regExp = RegExp(r"ABC-\d{6}");
    if (regExp.hasMatch(deviceId)) return true;
    
    return false;
  }

}