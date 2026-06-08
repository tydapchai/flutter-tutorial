import 'dart:async';
import 'dart:convert';

// ============================================================
// EXERCISE 1 – Product Model & Repository
// ============================================================
class Product {
  final int id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});

  @override
  String toString() => 'Product(id: $id, name: $name, price: $price)';
}

class ProductRepository {
  final List<Product> _products = [];
  final _controller = StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(milliseconds: 200));
    return _products;
  }

  Stream<Product> liveAdded() => _controller.stream;

  void addProduct(Product product) {
    _products.add(product);
    _controller.add(product);
  }

  void dispose() {
    _controller.close();
  }
}

Future<void> exercise1() async {
  print('--- EXERCISE 1: Product Model & Repository ---');
  final repo = ProductRepository();

  repo.liveAdded().listen((product) {
    print('Live update: $product');
  });

  repo.addProduct(Product(id: 1, name: 'Laptop', price: 1200.0));
  repo.addProduct(Product(id: 2, name: 'Phone', price: 800.0));

  final products = await repo.getAll();
  print('All products: $products\n');
  repo.dispose();
}

// ============================================================
// EXERCISE 2 – User Repository with JSON
// ============================================================
class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
    );
  }

  @override
  String toString() => 'User(name: $name, email: $email)';
}

Future<List<User>> fetchUsers() async {
  const jsonString = '''
  [
    {"name": "Alice", "email": "alice@example.com"},
    {"name": "Bob", "email": "bob@example.com"}
  ]
  ''';
  await Future.delayed(Duration(milliseconds: 100));
  List<dynamic> parsed = jsonDecode(jsonString);
  return parsed.map((json) => User.fromJson(json as Map<String, dynamic>)).toList();
}

Future<void> exercise2() async {
  print('--- EXERCISE 2: User Repository with JSON ---');
  final users = await fetchUsers();
  for (var user in users) {
    print(user);
  }
  print('');
}

// ============================================================
// EXERCISE 3 – Async + Microtask Debugging
// ============================================================
Future<void> exercise3() async {
  print('--- EXERCISE 3: Async + Microtask Debugging ---');
  print('1. Sync Start');

  Future(() => print('4. Event Queue Future'));
  
  scheduleMicrotask(() => print('3. Microtask Queue'));

  print('2. Sync End');

  await Future.delayed(Duration(milliseconds: 100));
  print('Microtasks run before Event callbacks because the event loop processes the entire microtask queue first.\n');
}

// ============================================================
// EXERCISE 4 – Stream Transformation
// ============================================================
Future<void> exercise4() async {
  print('--- EXERCISE 4: Stream Transformation ---');
  
  Stream<int> numbers = Stream.fromIterable([1, 2, 3, 4, 5]);

  await numbers
      .map((n) => n * n)
      .where((n) => n % 2 == 0)
      .forEach((n) => print('Filtered Even Square: $n'));
      
  print('');
}

// ============================================================
// EXERCISE 5 – Factory Constructors & Cache
// ============================================================
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
  
  print('s1 theme: ${s1.theme}');
  print('s2 theme: ${s2.theme}');
  print('identical(s1, s2): ${identical(s1, s2)}\n');
}

// ============================================================
// MAIN
// ============================================================
void main() async {
  print('========================================');
  print(' LAB 3 - ADVANCED DART PRACTICE EXERCISES');
  print('========================================\n');

  await exercise1();
  await exercise2();
  await exercise3();
  await exercise4();
  exercise5();
  
  print('========================================');
  print(' ALL EXERCISES COMPLETED');
  print('========================================');
}
