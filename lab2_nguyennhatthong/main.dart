// ============================================================
// Lab 2 – Dart Essentials Practice Lab
// File tổng hợp tất cả 5 exercises
// ============================================================

import 'dart:async';

// ════════════════════════════════════════════════════════════
//  EXERCISE 1 – Basic Syntax & Data Types
// ════════════════════════════════════════════════════════════
void exercise1() {
  _printHeader('EXERCISE 1 – Basic Syntax & Data Types');

  int age = 21;
  double height = 1.75;
  String name = 'Nguyen Van A';
  bool isStudent = true;

  print('int    : $age');
  print('double : $height');
  print('String : $name');
  print('bool   : $isStudent');
  print('Biểu thức: tuổi sau 5 năm = ${age + 5}');
  print('Biểu thức: diện tích (r=3) = ${3.14159 * 3 * 3}');

  var city = 'TP. Ho Chi Minh';
  dynamic anything = 42;
  print('var    : $city');
  print('dynamic: $anything → đổi thành: ${anything = "chuỗi"}');

  const double taxRate = 0.1;
  final DateTime now = DateTime.now();
  print('const  : $taxRate');
  print('final  : $now');

  String numStr = '123';
  print('Parse  : int.parse("$numStr") = ${int.parse(numStr)}');

  print('Exercise 1 xong\n');
}

// ════════════════════════════════════════════════════════════
//  EXERCISE 2 – Collections & Operators
// ════════════════════════════════════════════════════════════
void exercise2() {
  _printHeader('EXERCISE 2 – Collections & Operators');

  // List
  List<int> numbers = [10, 20, 30, 40, 50];
  print('List: $numbers');
  numbers.add(60);
  numbers.remove(10);
  print('Sau add(60)/remove(10): $numbers');
  print('map(×2): ${numbers.map((n) => n * 2).toList()}');
  print('where(>30): ${numbers.where((n) => n > 30).toList()}');

  // Set
  Set<String> fruits = {'apple', 'banana', 'orange', 'apple'};
  print('\nSet: $fruits');
  fruits.add('mango');
  fruits.remove('banana');
  print('Sau add/remove: $fruits');
  print('contains("apple"): ${fruits.contains("apple")}');

  Set<int> a = {1, 2, 3, 4, 5}, b = {3, 4, 5, 6, 7};
  print('Giao: ${a.intersection(b)} | Hợp: ${a.union(b)} | Hiệu: ${a.difference(b)}');

  // Map
  Map<String, int> scores = {'An': 85, 'Binh': 72, 'Cuong': 90};
  print('\nMap: $scores');
  scores['Dung'] = 95;
  scores.remove('Binh');
  print('Sau add/remove: $scores');
  scores.forEach((k, v) => print('  $k: $v → ${v >= 80 ? "Giỏi" : "Khá"}'));

  // Operators
  int x = 15, y = 4;
  print('\nSố học : $x+$y=${x+y}, $x-$y=${x-y}, $x*$y=${x*y}, $x~/$y=${x~/y}, $x%$y=${x%y}');
  print('So sánh: $x>$y=${x>y}, $x==$y=${x==y}');
  print('Logic  : (x>10 && y<10)=${x>10 && y<10}');
  print('Ternary: ${x > y ? "$x lớn hơn" : "$y lớn hơn"}');
  int? n;
  print('?? : ${n ?? 99}');

  print('Exercise 2 xong\n');
}

// ════════════════════════════════════════════════════════════
//  EXERCISE 3 – Control Flow & Functions
// ════════════════════════════════════════════════════════════
String _classifyScore(int s) {
  if (s >= 90) return 'Xuất sắc';
  if (s >= 80) return 'Giỏi';
  if (s >= 65) return 'Khá';
  if (s >= 50) return 'Trung bình';
  return 'Yếu';
}

int _square(int x) => x * x;
String _greet(String name, {String prefix = 'Xin chào'}) => '$prefix, $name!';
int _factorial(int n) => n <= 1 ? 1 : n * _factorial(n - 1);

void exercise3() {
  _printHeader('EXERCISE 3 – Control Flow & Functions');

  // if/else
  print('--- if/else ---');
  for (int s in [92, 78, 63, 45, 85]) {
    print('  $s → ${_classifyScore(s)}');
  }

  // switch
  print('\n--- switch ---');
  for (int d in [1, 2, 3, 4, 5, 6, 7]) {
    String name;
    switch (d) {
      case 1: name = 'Chủ nhật'; break;
      case 2: name = 'Thứ hai'; break;
      case 3: name = 'Thứ ba'; break;
      case 4: name = 'Thứ tư'; break;
      case 5: name = 'Thứ năm'; break;
      case 6: name = 'Thứ sáu'; break;
      case 7: name = 'Thứ bảy'; break;
      default: name = 'Không rõ';
    }
    print('  Ngày $d → $name');
  }

  // Loops
  print('\n--- loops ---');
  List<String> items = ['Táo', 'Cam', 'Xoài'];
  print('for  : ${[for (int i = 0; i < items.length; i++) "[$i]${items[i]}"]}');
  print('for-in:');
  for (String item in items) print('  $item');
  print('forEach:');
  items.forEach((item) => print('  → $item'));

  int c = 1;
  while (c <= 3) { print('  while c=$c'); c++; }
  int cd = 3;
  do { print('  do-while cd=$cd'); cd--; } while (cd > 0);

  // Functions
  print('\n--- functions ---');
  print(_greet('Sinh viên'));
  print(_greet('Thầy Giáo', prefix: 'Kính chào'));
  for (int i = 1; i <= 5; i++) print('  $i! = ${_factorial(i)}');
  print('_square(7) = ${_square(7)}');
  var multiply = (int x, int y) => x * y;
  print('closure 3×7 = ${multiply(3, 7)}');

  print('Exercise 3 xong\n');
}

// ════════════════════════════════════════════════════════════
//  EXERCISE 4 – Intro to OOP
// ════════════════════════════════════════════════════════════
class Vehicle {
  String brand;
  int year;
  double _fuel;

  Vehicle(this.brand, this.year, this._fuel);
  Vehicle.fromMap(Map<String, dynamic> d)
      : brand = d['brand'] ?? 'Unknown',
        year = d['year'] ?? 2020,
        _fuel = (d['fuel'] ?? 100.0).toDouble();

  double get fuelLevel => _fuel;
  set fuelLevel(double v) {
    if (v < 0 || v > 100) { print('  [CANH BAO] Khong hop le: $v'); return; }
    _fuel = v;
  }

  String describe() => '$brand ($year) fuel:${_fuel.toStringAsFixed(0)}%';
  void refuel(double amt) {
    _fuel = (_fuel + amt).clamp(0, 100);
    print('  Nạp $amt% → fuel:${_fuel.toStringAsFixed(0)}%');
  }
  @override String toString() => describe();
}

class Car extends Vehicle {
  int doors;
  Car(String brand, int year, double fuel, this.doors) : super(brand, year, fuel);
  Car.sedan(String brand, int year) : doors = 4, super(brand, year, 100.0);

  @override
  String describe() => '[Car] ${super.describe()} | $doors doors';
  void honk() => print('  $brand: Bip!');
}

class ElectricCar extends Car {
  double batteryKwh;
  int rangeKm;

  ElectricCar(String brand, int year, this.batteryKwh, this.rangeKm)
      : super(brand, year, 100.0, 4);

  @override
  String describe() =>
      '[ElectricCar] $brand ($year) pin:${fuelLevel.toStringAsFixed(0)}% | ${batteryKwh}kWh | ${rangeKm}km';

  @override
  void refuel(double amt) {
    super.refuel(amt);
    print('  Tam hoat dong: ${(fuelLevel / 100 * rangeKm).round()}km');
  }

  void autopilot() => print('  [Autopilot] ON: $brand');
}

abstract class Serviceable { void service(); }
mixin GPS { void navigate(String dest) => print('  [GPS] Den: $dest'); }

class SmartCar extends Car with GPS implements Serviceable {
  SmartCar(String brand, int year) : super.sedan(brand, year);
  @override void service() => print('  [Bao duong] $brand');
}

void exercise4() {
  _printHeader('EXERCISE 4 – Intro to OOP');

  Vehicle v = Vehicle('Honda Wave', 2022, 80.0);
  print(v.describe());
  v.refuel(15);
  v.fuelLevel = 120;

  Car car = Car.sedan('Toyota Vios', 2023);
  print(car.describe());
  car.honk();

  ElectricCar ev = ElectricCar('VinFast VF9', 2024, 123.0, 680);
  print(ev.describe());
  ev.fuelLevel = 20;
  ev.refuel(60);
  ev.autopilot();

  print('\n--- Polymorphism ---');
  List<Vehicle> garage = [v, car, ev];
  for (var x in garage) print(x.describe());

  SmartCar sc = SmartCar('Mercedes EQS', 2025);
  sc.navigate('Hà Nội');
  sc.service();

  print('\n--- instanceof ---');
  print('ev is ElectricCar: ${ev is ElectricCar}');
  print('ev is Car        : ${ev is Car}');
  print('car is ElectricCar: ${car is ElectricCar}');

  print('Exercise 4 xong\n');
}

// ════════════════════════════════════════════════════════════
//  EXERCISE 5 – Async, Future, Null Safety & Streams
// ════════════════════════════════════════════════════════════
Future<Map<String, dynamic>> _fetchUser(int id) async {
  print('  [API] Dang tai user $id...');
  await Future.delayed(Duration(milliseconds: 500));
  if (id <= 0) throw Exception('ID không hợp lệ');
  return {'id': id, 'name': 'Nguyen Van A', 'email': 'a@example.com'};
}

Stream<int> _countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(milliseconds: 100));
    yield i;
  }
}

Future<void> exercise5() async {
  _printHeader('EXERCISE 5 – Async, Future, Null Safety & Streams');

  // Async/await
  print('--- Async/Await ---');
  try {
    final user = await _fetchUser(1);
    user.forEach((k, v) => print('  $k: $v'));
  } catch (e) {
    print('  [LOI] $e');
  }

  try {
    await _fetchUser(-1);
  } catch (e) {
    print('  [LOI MONG DOI] $e');
  }

  // Future.wait (parallel)
  print('\n--- Future.wait (parallel) ---');
  final results = await Future.wait([_fetchUser(2), _fetchUser(3)]);
  results.forEach((r) => print('  ${r["id"]}: ${r["name"]}'));

  // Null Safety
  print('\n--- Null Safety ---');
  String? name;
  print('name = $name');
  String display = name ?? 'Khách';
  print('name ?? "Khách" = $display');
  name = 'Tran Thi B';
  print('?. length = ${name?.length}');
  print('! force: ${name!.toUpperCase()}');
  String? city;
  city ??= 'TP. HCM';
  print('city ??= "TP. HCM" → $city');
  late String late1;
  late1 = 'Late init!';
  print('late: $late1');
  List<String?> mixed = ['A', null, 'B', null];
  print('whereType: ${mixed.whereType<String>().toList()}');

  // Streams
  print('\n--- Streams ---');
  print('countStream(5):');
  await for (int v in _countStream(5)) print('  $v');

  print('\neven squares from 1..8:');
  await for (int sq in _countStream(8).where((n) => n % 2 == 0).map((n) => n * n)) {
    print('  $sq');
  }

  print('\nStream.fromIterable:');
  await Stream.fromIterable(['Xin chào', 'Dart', 'Streams!']).forEach(print);

  print('\nBroadcast stream:');
  final bc = StreamController<int>.broadcast();
  bc.stream.listen((v) => print('  Sub1: $v'));
  bc.stream.listen((v) => print('  Sub2: ${v * v}'));
  for (int i = 1; i <= 3; i++) bc.add(i);
  await bc.close();

  print('Exercise 5 xong\n');
}

// ════════════════════════════════════════════════════════════
//  HELPER
// ════════════════════════════════════════════════════════════
void _printHeader(String title) {
  print('\n${'=' * 56}');
  print('  $title');
  print('${'=' * 56}');
}

// ════════════════════════════════════════════════════════════
//  MAIN
// ════════════════════════════════════════════════════════════
void main() async {
  print('╔══════════════════════════════════════════════════════╗');
  print('║         LAB 2 - DART ESSENTIALS PRACTICE LAB         ║');
  print('╚══════════════════════════════════════════════════════╝');

  exercise1();
  exercise2();
  exercise3();
  exercise4();
  await exercise5();

  print('╔══════════════════════════════════════════════════════╗');
  print('TAT CA 5 EXERCISES DA HOAN THANH!');
  print('╚══════════════════════════════════════════════════════╝');
}
