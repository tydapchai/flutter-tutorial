// =============================================================
// CHỦ ĐỀ 3: EXCEPTIONS — try / catch / on / finally
// =============================================================

// ── Hàm nghiệp vụ: parse và validate số nguyên dương ──────────
int parsePositiveInt(String s) {
  // int.parse() sẽ throw FormatException nếu s không phải số
  final value = int.parse(s);

  // Chủ động throw lỗi nghiệp vụ
  if (value < 0) throw ArgumentError('Phải >= 0, nhận được: $value');

  return value;
}

void main() {
  // ── Trường hợp 1: Thành công ───────────────────────────────
  try {
    print(parsePositiveInt('12'));   // Output: 12
  } catch (e) {
    print('Lỗi: $e');
  }

  print('---');

  // ── Trường hợp 2: Bắt lỗi theo từng loại (on ... catch) ───
  void safeParse(String input) {
    try {
      print(parsePositiveInt(input));

    } on FormatException catch (e) {
      // Bắt đúng loại: chuỗi không phải số
      print('[FormatException] Input "$input" không phải số: $e');

    } on ArgumentError catch (e) {
      // Bắt đúng loại: số âm
      print('[ArgumentError] ${e.message}');

    } catch (e, stack) {
      // Bắt tất cả lỗi còn lại + stack trace
      print('[Unknown] $e');
      print(stack);
      // rethrow; // bỏ comment nếu muốn tiếp tục lan lỗi lên trên

    } finally {
      // LUÔN chạy dù có lỗi hay không → dùng để dọn dẹp tài nguyên
      print('[finally] Đã xử lý xong input: "$input"');
    }
  }

  safeParse('12');    // thành công
  print('---');
  safeParse('abc');   // FormatException
  print('---');
  safeParse('-3');    // ArgumentError

  // Output:
  // 12
  // [finally] Đã xử lý xong input: "12"
  // ---
  // [FormatException] Input "abc" không phải số: ...
  // [finally] Đã xử lý xong input: "abc"
  // ---
  // [ArgumentError] Phải >= 0, nhận được: -3
  // [finally] Đã xử lý xong input: "-3"
}
