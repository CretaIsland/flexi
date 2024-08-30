class FlexiUtils {

  static bool deviceCheck(String deviceId, String enterprise) {
    String pattern = RegExp.escape(enterprise) + r'-\d{6}';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(deviceId)) return true;
    
    return false;
  }

}