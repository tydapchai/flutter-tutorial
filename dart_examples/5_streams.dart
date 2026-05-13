// =============================================================
// CHỦ ĐỀ 5: STREAMS — Sequence of async values
// =============================================================

import 'dart:async';

void main() async {
  // ── Future vs Stream ─────────────────────────────────────────
  // Future<String>  = hứa trả về 1 giá trị DUY NHẤT trong tương lai
  // Stream<String>  = hứa trả về NHIỀU giá trị theo thời gian

  // ── Ví dụ 1: Stream.periodic — đếm mỗi 400ms ────────────────
  final stream = Stream.periodic(
    const Duration(milliseconds: 400),
    (i) => i,          // i = 0, 1, 2, 3, 4 ...
  ).take(5);           // chỉ lấy 5 giá trị rồi dừng

  print('=== Single-subscription stream ===');
  // listen() = subscribe (đăng ký nhận giá trị)
  final sub = stream.listen(
    (value) => print('Nhận: $value'),
    onError: (e) => print('Lỗi: $e'),
    onDone: () => print('Stream đã hoàn thành!'),
  );
  // Nếu cần dừng sớm: sub.cancel();

  // Chờ stream chạy xong
  await Future.delayed(const Duration(seconds: 3));

  // ── Ví dụ 2: Chuyển đổi Stream với map + where (lazy) ────────
  print('\n=== Transform stream ===');
  final numbers = Stream.fromIterable([1, 2, 3, 4, 5, 6]);

  // Lọc số chẵn rồi nhân 10
  final transformed = numbers
      .where((n) => n.isEven)    // 2, 4, 6
      .map((n) => n * 10);       // 20, 40, 60

  await for (final value in transformed) {
    print('Chẵn x10: $value');
  }

  // ── Ví dụ 3: StreamController — tự tạo Stream ────────────────
  print('\n=== Custom StreamController ===');
  final controller = StreamController<String>();

  controller.stream.listen(
    (msg) => print('📨 Tin nhắn: $msg'),
    onDone: () => print('🔒 Stream đóng'),
  );

  // Đẩy dữ liệu vào stream
  controller.add('Xin chào!');
  controller.add('Đây là tin nhắn 2');
  await Future.delayed(Duration(milliseconds: 100));
  controller.add('Tạm biệt!');
  await controller.close(); // đóng stream

  // ── Ví dụ 4: Broadcast Stream — nhiều listener ───────────────
  // Single-subscription: chỉ 1 listener  → lỗi nếu listen 2 lần
  // Broadcast stream: nhiều listener cùng lúc (như EventEmitter)
  print('\n=== Broadcast stream ===');
  final broadcastCtrl = StreamController<int>.broadcast();

  broadcastCtrl.stream.listen((v) => print('Listener A: $v'));
  broadcastCtrl.stream.listen((v) => print('Listener B: $v'));

  broadcastCtrl.add(42);
  broadcastCtrl.add(99);
  await broadcastCtrl.close();
}

// ── Tóm tắt: khi nào dùng Future, khi nào dùng Stream ─────────
// Future  → gọi API (1 request → 1 response)
// Stream  → WebSocket, real-time chat, sensor data, file đọc từng chunk
