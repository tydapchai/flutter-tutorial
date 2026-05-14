// ============================================================
// Exercise 1 – Basic Syntax & Data Types
// Goal: Practice program structure and variable declarations.
// ============================================================

void main() {
  print('========================================');
  print('  EXERCISE 1 – Basic Syntax & Data Types');
  print('========================================\n');

  // --- 1. Integer ---
  int age = 21;
  int score = 95;
  print('Kiểu int:');
  print('  Tuổi    : $age');
  print('  Điểm    : $score');
  print('  Điểm + 5: ${score + 5}\n');

  // --- 2. Double (số thực) ---
  double height = 1.75;
  double pi = 3.14159;
  print('Kiểu double:');
  print('  Chiều cao: ${height}m');
  print('  Pi        : $pi');
  print('  Diện tích (r=3): ${pi * 3 * 3}\n');

  // --- 3. String ---
  String name = 'Nguyen Van A';
  String greeting = 'Xin chào, $name!';
  String multiLine = '''
  Họ tên : $name
  Tuổi   : $age
  Chiều cao: ${height}m
  ''';
  print('Kiểu String:');
  print('  $greeting');
  print('  Chuỗi nhiều dòng:$multiLine');

  // --- 4. Boolean ---
  bool isStudent = true;
  bool hasPassed = score >= 50;
  print('Kiểu bool:');
  print('  Là sinh viên: $isStudent');
  print('  Đã qua môn  : $hasPassed\n');

  // --- 5. var & dynamic ---
  var city = 'Ho Chi Minh City'; // Dart tự suy kiểu String
  dynamic anything = 42;         // Có thể đổi kiểu sau
  print('var & dynamic:');
  print('  Thành phố (var): $city');
  print('  anything = $anything');
  anything = 'Bây giờ là chuỗi';
  print('  anything = $anything\n');

  // --- 6. Hằng số ---
  const double taxRate = 0.1;
  final DateTime now = DateTime.now();
  print('const & final:');
  print('  Thuế suất (const): $taxRate');
  print('  Thời gian hiện tại (final): $now\n');

  // --- 7. Type conversion ---
  String numStr = '123';
  int parsed = int.parse(numStr);
  String converted = age.toString();
  print('Chuyển đổi kiểu:');
  print('  Chuỗi "$numStr" → int: $parsed');
  print('  int $age → String: "$converted"');

  print('\nExercise 1 hoan thanh!\n');
}
