// ============================================================
// Exercise 3 – Control Flow & Functions
// Goal: Apply if/else, switch, loops, and functions.
// ============================================================

// ─── FUNCTIONS (khai báo ngoài main) ─────────────────────

/// Hàm thông thường: xếp loại học lực theo điểm
String classifyScore(int score) {
  if (score >= 90) return 'Xuất sắc';
  if (score >= 80) return 'Giỏi';
  if (score >= 65) return 'Khá';
  if (score >= 50) return 'Trung bình';
  return 'Yếu';
}

/// Hàm arrow syntax: tính bình phương
int square(int x) => x * x;

/// Hàm với tham số tùy chọn có giá trị mặc định
String buildGreeting(String name, {String prefix = 'Xin chào'}) =>
    '$prefix, $name!';

/// Hàm với tham số vị trí tùy chọn
double calculateBMI(double weight, [double height = 1.7]) =>
    weight / (height * height);

/// Hàm trả về nhiều giá trị qua Record (Dart 3+)
(int, int) divmod(int a, int b) => (a ~/ b, a % b);

/// Hàm đệ quy: tính giai thừa
int factorial(int n) => n <= 1 ? 1 : n * factorial(n - 1);

/// Higher-order function: nhận hàm làm tham số
List<int> applyToAll(List<int> list, int Function(int) fn) =>
    list.map(fn).toList();

// ─────────────────────────────────────────────────────────

void main() {
  print('=================================================');
  print('  EXERCISE 3 – Control Flow & Functions');
  print('=================================================\n');

  // ─── A. IF / ELSE ──────────────────────────────────────
  print('--- A. IF / ELSE ---');

  List<int> scores = [92, 78, 63, 45, 55, 85];
  for (int s in scores) {
    print('  Điểm $s → ${classifyScore(s)}');
  }
  print('');

  // ─── B. SWITCH / CASE ─────────────────────────────────
  print('--- B. SWITCH / CASE ---');

  List<int> days = [1, 2, 3, 4, 5, 6, 7, 9];
  for (int day in days) {
    String dayName;
    switch (day) {
      case 1:
        dayName = 'Chủ nhật';
        break;
      case 2:
        dayName = 'Thứ hai';
        break;
      case 3:
        dayName = 'Thứ ba';
        break;
      case 4:
        dayName = 'Thứ tư';
        break;
      case 5:
        dayName = 'Thứ năm';
        break;
      case 6:
        dayName = 'Thứ sáu';
        break;
      case 7:
        dayName = 'Thứ bảy';
        break;
      default:
        dayName = 'Không hợp lệ';
    }
    print('  Ngày $day → $dayName');
  }
  print('');

  // ─── C. LOOPS ─────────────────────────────────────────
  print('--- C. LOOPS ---');

  List<String> fruits = ['Táo', 'Cam', 'Xoài', 'Chuối', 'Ổi'];

  // for loop truyền thống
  print('for loop (chỉ số):');
  for (int i = 0; i < fruits.length; i++) {
    print('  [$i] ${fruits[i]}');
  }

  // for-in loop
  print('for-in loop:');
  for (String fruit in fruits) {
    print('  - $fruit');
  }

  // forEach (lambda)
  print('forEach:');
  fruits.forEach((fruit) => print('  → $fruit'));

  // while loop
  print('while loop (đếm 1→5):');
  int count = 1;
  while (count <= 5) {
    print('  count = $count');
    count++;
  }

  // do-while loop
  print('do-while (đếm ngược 3→1):');
  int countdown = 3;
  do {
    print('  countdown = $countdown');
    countdown--;
  } while (countdown > 0);
  print('  Phong!');
  print('');

  // break & continue
  print('break & continue (vòng 1–10, bỏ số chẵn, dừng ở 7):');
  for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) continue; // bỏ qua số chẵn
    if (i > 7) break;          // dừng khi > 7
    print('  i = $i');
  }
  print('');

  // ─── D. FUNCTIONS ─────────────────────────────────────
  print('--- D. FUNCTIONS ---');

  // Hàm thông thường
  print('square(7) = ${square(7)}');

  // Named parameters
  print(buildGreeting('Sinh viên'));
  print(buildGreeting('Thầy Giáo', prefix: 'Kính chào'));

  // Optional positional params
  print('BMI(70): ${calculateBMI(70).toStringAsFixed(2)}');
  print('BMI(70, 1.80): ${calculateBMI(70, 1.80).toStringAsFixed(2)}');

  // Record return
  var (quotient, remainder) = divmod(17, 5);
  print('17 ÷ 5 = $quotient dư $remainder');

  // Đệ quy
  for (int i = 1; i <= 6; i++) {
    print('$i! = ${factorial(i)}');
  }

  // Higher-order function
  List<int> nums = [1, 2, 3, 4, 5];
  print('Danh sách gốc       : $nums');
  print('Bình phương mỗi số  : ${applyToAll(nums, square)}');
  print('Nhân 3 mỗi số       : ${applyToAll(nums, (x) => x * 3)}');

  // Anonymous function (closure)
  var multiply = (int x, int y) => x * y;
  print('3 × 7 (closure)     : ${multiply(3, 7)}');

  print('\nExercise 3 hoan thanh!\n');
}
