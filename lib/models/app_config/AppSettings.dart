class AppSettings {
  bool _persistentStorage;
  bool get persistentStorage => _persistentStorage;

  AppSettings.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('persistentStorage')) {
      _persistentStorage = json['persistentStorage'];
    }
  }

  Map<String, dynamic> fromJson() => {'persistentStorage': _persistentStorage};
}
