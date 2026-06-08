import 'dart:async';

Future<void> exercise3() async {
  print('--- EXERCISE 3: Async + Microtask Debugging ---');
  print('1. Sync Start');

  Future(() => print('4. Event Queue Future'));
  
  scheduleMicrotask(() => print('3. Microtask Queue'));

  print('2. Sync End');

  await Future.delayed(Duration(milliseconds: 100));
  print('Microtasks run before Event callbacks because the event loop processes the entire microtask queue first.\n');
}

void main() async {
  await exercise3();
}
