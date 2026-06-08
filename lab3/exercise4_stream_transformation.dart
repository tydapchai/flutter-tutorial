import 'dart:async';

Future<void> exercise4() async {
  print('--- EXERCISE 4: Stream Transformation ---');
  
  Stream<int> numbers = Stream.fromIterable([1, 2, 3, 4, 5]);

  await numbers
      .map((n) => n * n)
      .where((n) => n % 2 == 0)
      .forEach((n) => print('Filtered Even Square: $n'));
      
  print('');
}

void main() async {
  await exercise4();
}
