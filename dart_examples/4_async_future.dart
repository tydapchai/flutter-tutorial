// =============================================================
// CHỦ ĐỀ 4: ASYNC — Future & async / await
// =============================================================

import 'dart:async';

// ── Giả lập gọi API mất 1 giây ────────────────────────────────
Future<String> fetchUserName(int id) async {
  // await = "chờ Future này hoàn thành, KHÔNG block toàn bộ chương trình"
  await Future.delayed(Duration(seconds: 1));

  if (id == 0) throw Exception('ID không hợp lệ!');
  print('⏳ Đã gọi API cho ID $id');
  return 'Nguyễn Văn $id';
}

// ── Hiểu sự khác biệt: sync vs async ──────────────────────────
// Nếu KHÔNG dùng async/await:
// Future<String> bad() {
//   Future.delayed(Duration(seconds:1));  // ← không await = không chờ
//   return Future.value('không đúng');    // trả về ngay, chưa có data
// }

Future<void> main() async {
  print('⏳ Bắt đầu gọi server...');

  // ── Trường hợp 1: await thành công ─────────────────────────
  final name = await fetchUserName(3);
  print('✅ Nhận được: $name');    // in ra sau 1 giây

  // ── Trường hợp 2: Xử lý lỗi với try/catch ─────────────────
  try {
    final bad = await fetchUserName(0);
    print(bad);
  } catch (e) {
    print('❌ Lỗi: $e');
  }

  // ── Trường hợp 3: Chạy SONG SONG với Future.wait ──────────
  print('⏳ Gọi 3 user cùng lúc...');
  final results = await Future.wait([
    fetchUserName(1),
    fetchUserName(2),
    fetchUserName(3),
  ]);
  // Tổng thời gian ≈ 1 giây (song song), không phải 3 giây (tuần tự)
  print('✅ Tất cả: $results');

  print('🏁 Xong!');
}

// ── Tại sao cần async/await? ───────────────────────────────────
// Dart chạy trên 1 thread (event loop)
// Nếu block thread (ví dụ đọc file 5 giây), UI sẽ đơ hoàn toàn
// async/await cho phép Dart làm việc khác trong lúc "chờ"
// → UI vẫn mượt, app vẫn phản hồi
