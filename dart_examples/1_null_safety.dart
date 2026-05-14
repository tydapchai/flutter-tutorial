// =============================================================
// CHỦ ĐỀ 1: NULL SAFETY — Operators ?, ??, !
// =============================================================

void main() {
  // ── 1. Toán tử ? — Khai báo biến CÓ THỂ null ──────────────
  String? name;        // ? = biến này được phép là null
  print(name?.length);         // Output: null  (không crash!)

  // Nếu không có ?, Dart sẽ BẮT BUỘC gán giá trị ngay:
  // String name2;     // ❌ LỖI compile-time: Must be initialized

  // ── 2. Toán tử ?? — Giá trị mặc định khi null ─────────────
  // Đọc: "nếu name là null thì dùng 'Guest', ngược lại dùng name"
  print(name ?? 'Guest');   // Output: Guest

  name = 'Minh';
  print(name ?? 'Guest');   // Output: Minh  (vì name != null)

  // ── 3. Toán tử ! — Khẳng định "TÔI CHẮC CHẮN nó không null" ─
  // Dùng khi BẠN biết chắc giá trị không null, nhưng Dart chưa biết
  print(name!.length);      // Output: 4  (an toàn vì name = 'Minh')

  // ── Ví dụ nguy hiểm của ! ──────────────────────────────────
  String? unknown;
  // print(unknown!.length); // ❌ Runtime crash: Null check operator
                             //    used on a null value

  // ── 4. Kết hợp thực tế: nullable trong hàm ─────────────────
  print(greet(null));        // Output: Xin chào, khách!
  print(greet('An'));        // Output: Xin chào, An!
}

// Tham số nullable: caller có thể truyền null
String greet(String? userName) {
  final displayName = userName ?? 'khách';
  return 'Xin chào, $displayName!';
}
