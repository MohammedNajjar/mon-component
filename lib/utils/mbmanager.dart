class MBManager {

}

num? numParse(dynamic value) {
  if (value == null) {
    return null;
  } else if (value is num) {
    return value;
  } else if (value is String) {
    final number = num.tryParse(value);
    if (number == null) {
      return null;
    }
    return number;
  } else {
    return null;
  }
}