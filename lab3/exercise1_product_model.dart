import 'dart:async';

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

void main() async {
  await exercise1();
}
