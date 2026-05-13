// =============================================================
// CHỦ ĐỀ 2: COLLECTIONS — map() & where() (filter)
// =============================================================

void main() {
  final numbers = [1, 2, 3, 4, 5];

  // ── 1. map() — Biến đổi từng phần tử → Iterable mới ───────
  // "Nhân đôi mỗi số"
  // map KHÔNG thay đổi list gốc, nó trả về 1 Iterable mới (lazy)
  final doubled = numbers.map((n) => n * 2);
  print(doubled.toList());     // Output: [2, 4, 6, 8, 10]

  // map có thể đổi kiểu dữ liệu: int → String
  final labels = numbers.map((n) => 'Mục $n').toList();
  print(labels);               // Output: [Mục 1, Mục 2, Mục 3, Mục 4, Mục 5]

  // ── 2. where() — Lọc phần tử thỏa điều kiện (giữ type) ────
  // "Chỉ giữ số chẵn"
  final evens = numbers.where((n) => n.isEven);
  print(evens.toList());       // Output: [2, 4]

  // "Chỉ giữ số > 2"
  final greaterThan2 = numbers.where((n) => n > 2);
  print(greaterThan2.toList()); // Output: [3, 4, 5]

  // ── 3. Chuỗi (chain): map + where ──────────────────────────
  // "Bình phương rồi chỉ giữ số > 5"
  // Dart thực hiện LAZY: chỉ tính khi gọi toList()
  final bigSquares = numbers
      .map((n) => n * n)        // [1, 4, 9, 16, 25]
      .where((n) => n > 5)      // giữ [9, 16, 25]
      .toList();
  print(bigSquares);           // Output: [9, 16, 25]

  // ── 4. Thực tế: lọc danh sách học sinh đậu ────────────────
  final scores = {'An': 8.5, 'Bình': 4.0, 'Chi': 7.0, 'Dũng': 3.5};

  final passed = scores.entries
      .where((e) => e.value >= 5.0)
      .map((e) => '${e.key}: ${e.value}')
      .toList();

  print('Học sinh đậu: $passed');
  // Output: Học sinh đậu: [An: 8.5, Chi: 7.0]
}
