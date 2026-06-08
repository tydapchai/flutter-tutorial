class Settings {
  static final Settings _instance = Settings._internal();
  
  String theme = 'Light';

  Settings._internal();

  factory Settings() {
    return _instance;
  }
}

void exercise5() {
  print('--- EXERCISE 5: Factory Constructors & Cache ---');
  
  var s1 = Settings();
  var s2 = Settings();

  s1.theme = 'Dark';
  
  print('s1 theme: \${s1.theme}');
  print('s2 theme: \${s2.theme}');
  print('identical(s1, s2): \${identical(s1, s2)}\n');
}

void main() {
  exercise5();
}
