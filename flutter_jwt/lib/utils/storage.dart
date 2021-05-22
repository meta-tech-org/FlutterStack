import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' show window;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
// Create secure storage for iOS, Android and Linux
  final storage = FlutterSecureStorage();

  Future<String> read(String key) async {
    var value = "";
    if (kIsWeb) {
      value =
          window.localStorage.containsKey(key) ? window.localStorage[key] : "";
    } else {
      value = await storage.read(key: key);
    }
    if (value == null) return "";
    return value;
  }

  write(String key, String value) {
    if (kIsWeb) {
      window.localStorage[key] = value;
    }
    // Mobile: Store in SecureStorgae
    else {
      storage.write(value: value, key: key);
    }
  }

  reset(String key) {
    if (kIsWeb) {
      window.localStorage.remove(key);
    }
    // Mobile: Store in SecureStorage
    else {
      storage.write(key: key, value: null);
    }
  }
}
