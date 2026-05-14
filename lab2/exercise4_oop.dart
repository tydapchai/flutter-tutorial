// ============================================================
// Exercise 4 – Intro to OOP
// Goal: Classes, constructors, inheritance, method overriding.
// ============================================================

// ─── 1. Lớp cơ bản: Vehicle ──────────────────────────────
class Vehicle {
  String brand;
  int year;
  double _fuelLevel; // private field

  // Constructor chính
  Vehicle(this.brand, this.year, this._fuelLevel);

  // Named constructor: tạo từ Map
  Vehicle.fromMap(Map<String, dynamic> data)
      : brand = data['brand'] ?? 'Unknown',
        year = data['year'] ?? 2020,
        _fuelLevel = (data['fuel'] ?? 100.0).toDouble();

  // Getter & Setter
  double get fuelLevel => _fuelLevel;
  set fuelLevel(double value) {
    if (value < 0 || value > 100) {
      print('  [CANH BAO] Muc nhien lieu khong hop le: $value');
      return;
    }
    _fuelLevel = value;
  }

  // Phương thức
  String describe() =>
      '$brand ($year) - nhien lieu: ${_fuelLevel.toStringAsFixed(1)}%';

  void refuel(double amount) {
    _fuelLevel = (_fuelLevel + amount).clamp(0, 100);
    print('  Nạp ${amount}% → mức nhiên liệu: ${_fuelLevel.toStringAsFixed(1)}%');
  }

  @override
  String toString() => describe();
}

// ─── 2. Car kế thừa Vehicle ──────────────────────────────
class Car extends Vehicle {
  int numDoors;
  String transmissionType;

  Car(String brand, int year, double fuel, this.numDoors, this.transmissionType)
      : super(brand, year, fuel);

  // Named constructor
  Car.sedan(String brand, int year)
      : numDoors = 4,
        transmissionType = 'automatic',
        super(brand, year, 100.0);

  @override
  String describe() =>
      '[Car] ${super.describe()} | $numDoors cua | $transmissionType';

  void honk() => print('  $brand: Bip bip!');
}

// ─── 3. ElectricCar kế thừa Car ──────────────────────────
class ElectricCar extends Car {
  double batteryCapacity; // kWh
  int rangeKm;

  ElectricCar(String brand, int year, this.batteryCapacity, this.rangeKm)
      : super(brand, year, 100.0, 4, 'automatic');

  @override
  String describe() =>
      '[ElectricCar] $brand ($year) - Pin: ${fuelLevel.toStringAsFixed(1)}%'
      ' | ${batteryCapacity}kWh | Tầm: ${rangeKm}km';

  @override
  void refuel(double amount) {
    print('  [Sac dien] Dang sac...');
    super.refuel(amount);
    print('  Tam hoat dong: ${(fuelLevel / 100 * rangeKm).round()}km');
  }

  void activateAutopilot() => print('  [Autopilot] Tu lai duoc kich hoat tren $brand!');
}

// ─── 4. Abstract class + Mixin ────────────────────────────
abstract class ServiceableVehicle {
  void service();
}

mixin GPSCapable {
  String currentLocation = 'Chưa xác định';
  void navigateTo(String dest) => print('  [GPS] Dang dan duong den: $dest');
}

class SmartCar extends Car with GPSCapable implements ServiceableVehicle {
  SmartCar(String brand, int year) : super.sedan(brand, year);

  @override
  void service() => print('  [Bao duong] $brand dang duoc bao duong...');

  @override
  String describe() => '${super.describe()} | GPS: $currentLocation';
}

// ─────────────────────────────────────────────────────────
void main() {
  print('=========================================');
  print('  EXERCISE 4 – Intro to OOP');
  print('=========================================\n');

  // Vehicle
  print('--- Vehicle ---');
  Vehicle v1 = Vehicle('Honda', 2020, 80.0);
  print(v1.describe());
  v1.refuel(15);
  v1.fuelLevel = 120; // validation test

  Vehicle v2 = Vehicle.fromMap({'brand': 'Yamaha', 'year': 2022, 'fuel': 50.0});
  print(v2);
  print('');

  // Car
  print('--- Car ---');
  Car car1 = Car('Toyota Camry', 2023, 75.0, 4, 'automatic');
  print(car1.describe());
  car1.honk();
  car1.refuel(20);

  Car car2 = Car.sedan('BMW 3 Series', 2024);
  print(car2.describe());
  print('');

  // ElectricCar
  print('--- ElectricCar ---');
  ElectricCar tesla = ElectricCar('Tesla Model 3', 2024, 75.0, 500);
  print(tesla.describe());
  tesla.fuelLevel = 20.0;
  tesla.refuel(50);
  tesla.activateAutopilot();
  print('');

  // Polymorphism
  print('--- Polymorphism ---');
  List<Vehicle> garage = [v1, car1, tesla];
  for (var vehicle in garage) {
    print(vehicle.describe());
  }
  print('');

  // SmartCar
  print('--- SmartCar (Abstract + Mixin) ---');
  SmartCar smart = SmartCar('Mercedes EQS', 2025);
  smart.currentLocation = 'TP. Hồ Chí Minh';
  print(smart.describe());
  smart.navigateTo('Hà Nội');
  smart.service();
  smart.honk();

  // instanceof
  print('\n--- instanceof (is) ---');
  print('tesla is ElectricCar : ${tesla is ElectricCar}');
  print('tesla is Car         : ${tesla is Car}');
  print('tesla is Vehicle     : ${tesla is Vehicle}');
  print('car1 is ElectricCar  : ${car1 is ElectricCar}');

  print('\nExercise 4 hoan thanh!\n');
}
