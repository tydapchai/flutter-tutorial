// ============================================================
// Exercise 2 – Collections & Operators
// Goal: Work with List, Set, Map and operators.
// ============================================================

void main() {
  print('============================================');
  print('  EXERCISE 2 – Collections & Operators');
  print('============================================\n');

  // ─────────────────────────────────────────────
  // PHẦN A: LIST
  // ─────────────────────────────────────────────
  print('--- A. LIST ---');

  // Khởi tạo list số nguyên
  List<int> numbers = [10, 20, 30, 40, 50];
  print('Danh sách ban đầu : $numbers');
  print('Phần tử đầu tiên  : ${numbers[0]}');
  print('Phần tử cuối cùng : ${numbers.last}');
  print('Độ dài            : ${numbers.length}');

  // Thêm & xóa phần tử
  numbers.add(60);
  print('Sau khi add(60)   : $numbers');
  numbers.remove(10);
  print('Sau khi remove(10): $numbers');

  // Toán tử + (ghép list)
  List<int> extra = [70, 80];
  List<int> combined = numbers + extra;
  print('Sau khi ghép list : $combined');

  // map() – nhân đôi từng phần tử
  List<int> doubled = numbers.map((n) => n * 2).toList();
  print('Nhân đôi mỗi phần tử: $doubled');

  // where() – lọc phần tử > 30
  List<int> filtered = numbers.where((n) => n > 30).toList();
  print('Phần tử > 30      : $filtered\n');

  // ─────────────────────────────────────────────
  // PHẦN B: SET
  // ─────────────────────────────────────────────
  print('--- B. SET ---');

  // Set chỉ chứa giá trị duy nhất
  Set<String> fruits = {'apple', 'banana', 'orange', 'apple'}; // 'apple' trùng
  print('Set hoa quả (không trùng): $fruits');

  fruits.add('mango');
  print('Sau khi add("mango")     : $fruits');
  fruits.remove('banana');
  print('Sau khi remove("banana") : $fruits');

  // Kiểm tra phần tử
  print('Có chứa "apple"?         : ${fruits.contains("apple")}');

  // Giao, hợp, hiệu
  Set<int> setA = {1, 2, 3, 4, 5};
  Set<int> setB = {3, 4, 5, 6, 7};
  print('Set A: $setA');
  print('Set B: $setB');
  print('Giao (intersection): ${setA.intersection(setB)}');
  print('Hợp  (union)       : ${setA.union(setB)}');
  print('Hiệu (difference)  : ${setA.difference(setB)}\n');

  // ─────────────────────────────────────────────
  // PHẦN C: MAP
  // ─────────────────────────────────────────────
  print('--- C. MAP ---');

  Map<String, int> studentScores = {
    'An': 85,
    'Binh': 72,
    'Cuong': 90,
    'Dung': 68,
  };
  print('Bảng điểm: $studentScores');
  print('Điểm của An: ${studentScores["An"]}');

  // Thêm & xóa entry
  studentScores['Em'] = 95;
  print('Thêm Em (95): $studentScores');
  studentScores.remove('Dung');
  print('Xóa Dung    : $studentScores');

  // Duyệt Map
  print('\nDanh sách điểm:');
  studentScores.forEach((name, sc) {
    String rank = sc >= 80 ? 'Giỏi' : 'Khá';
    print('  $name: $sc → $rank');
  });

  // keys & values
  print('\nDanh sách tên: ${studentScores.keys.toList()}');
  print('Danh sách điểm: ${studentScores.values.toList()}');

  // ─────────────────────────────────────────────
  // PHẦN D: OPERATORS
  // ─────────────────────────────────────────────
  print('\n--- D. OPERATORS ---');

  int a = 15, b = 4;
  print('a = $a, b = $b');
  print('Số học : a+b=${a+b}, a-b=${a-b}, a*b=${a*b}, a/b=${a/b}, a~/b=${a~/b}, a%b=${a%b}');
  print('So sánh: a>b=${a>b}, a<b=${a<b}, a==b=${a==b}, a!=b=${a!=b}');
  print('Logic  : (a>10 && b<10)=${a>10 && b<10}, (a<5 || b<5)=${a<5 || b<5}');

  // Toán tử ba ngôi ? :
  String result = (a > b) ? '$a lớn hơn $b' : '$b lớn hơn $a';
  print('Ternary: $result');

  // Toán tử ?? (null-aware)
  int? maybeNull;
  int value = maybeNull ?? 99;
  print('Null-coalescing (??): maybeNull ?? 99 = $value');

  print('\nExercise 2 hoan thanh!\n');
}
