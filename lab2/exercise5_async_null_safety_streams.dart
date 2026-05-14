// ============================================================
// Exercise 5 – Async, Future, Null Safety & Streams
// Goal: Work with Dart's asynchronous features.
// ============================================================

import 'dart:async';

// ─── 1. Async Function với Future + await ────────────────

/// Giả lập gọi API lấy thông tin người dùng
Future<Map<String, dynamic>> fetchUserData(int userId) async {
  print('  [API] Dang tai du lieu user $userId...');
  // Future.delayed mô phỏng độ trễ mạng
  await Future.delayed(Duration(seconds: 2));
  if (userId <= 0) throw Exception('userId không hợp lệ');
  return {
    'id': userId,
    'name': 'Nguyen Van A',
    'email': 'nguyenvana@example.com',
    'age': 21,
  };
}

/// Gọi nối tiếp nhiều future
Future<void> fetchSequential() async {
  print('\n  [Sequential] Tải dữ liệu lần lượt...');
  final start = DateTime.now();
  await Future.delayed(Duration(milliseconds: 500));
  await Future.delayed(Duration(milliseconds: 500));
  final elapsed = DateTime.now().difference(start).inMilliseconds;
  print('  [Sequential] Xong sau ${elapsed}ms');
}

/// Chạy song song với Future.wait
Future<void> fetchParallel() async {
  print('\n  [Parallel] Tải dữ liệu song song...');
  final start = DateTime.now();
  await Future.wait([
    Future.delayed(Duration(milliseconds: 500)),
    Future.delayed(Duration(milliseconds: 500)),
    Future.delayed(Duration(milliseconds: 500)),
  ]);
  final elapsed = DateTime.now().difference(start).inMilliseconds;
  print('  [Parallel] Xong sau ${elapsed}ms (nhanh hơn sequential!)');
}

// ─── 2. Null Safety ──────────────────────────────────────

/// Lấy tên người dùng (nullable)
String? getUserName(bool loggedIn) {
  return loggedIn ? 'Tran Thi B' : null;
}

/// Minh hoạ các toán tử null-safety
void demonstrateNullSafety() {
  print('\n--- NULL SAFETY ---');

  // ? – nullable type
  String? name = getUserName(false);
  print('name (chưa đăng nhập) = $name');

  // ?? – null-coalescing: dùng giá trị mặc định
  String displayName = name ?? 'Khách';
  print('Hiển thị: $displayName');

  name = getUserName(true);
  print('name (đã đăng nhập) = $name');

  // ?. – null-aware access
  int? nameLength = name?.length;
  print('Độ dài tên: $nameLength');

  // ! – force unwrap (cẩn thận, chỉ dùng khi chắc không null)
  if (name != null) {
    print('Chữ hoa (force): ${name!.toUpperCase()}');
  }

  // ??= – gán nếu null
  String? city;
  city ??= 'Ho Chi Minh City';
  print('Thành phố: $city');
  city ??= 'Hà Nội'; // không gán vì city đã có giá trị
  print('Thành phố (sau ??=): $city');

  // late – khai báo không khởi tạo ngay
  late String lateVar;
  lateVar = 'Tôi được khởi tạo muộn!';
  print('late variable: $lateVar');

  // Null-aware trong collection
  List<String?> mixedList = ['A', null, 'B', null, 'C'];
  List<String> nonNullList = mixedList.whereType<String>().toList();
  print('Danh sách gốc    : $mixedList');
  print('Lọc null xong    : $nonNullList');
}

// ─── 3. Streams ──────────────────────────────────────────

/// Stream đơn giản từ generator
Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(milliseconds: 200));
    yield i; // phát giá trị
  }
}

/// Stream dùng StreamController
Stream<String> messageStream() {
  final controller = StreamController<String>();

  // Lên lịch thêm dữ liệu vào stream
  Future(() async {
    final messages = ['Kết nối...', 'Xác thực...', 'Tải dữ liệu...', 'Hoàn tất!'];
    for (var msg in messages) {
      await Future.delayed(Duration(milliseconds: 300));
      controller.add(msg);
    }
    await controller.close();
  });

  return controller.stream;
}

/// Stream transform với map và where
Stream<int> evenSquares(int max) =>
    countStream(max)
        .where((n) => n % 2 == 0)   // chỉ lấy số chẵn
        .map((n) => n * n);          // bình phương

// ─────────────────────────────────────────────────────────
// MAIN
// ─────────────────────────────────────────────────────────
void main() async {
  print('=================================================');
  print('  EXERCISE 5 – Async, Future, Null Safety & Streams');
  print('=================================================\n');

  // ── A. Async / Await / Future ──────────────────────────
  print('--- A. ASYNC / AWAIT ---');

  // Gọi async function với try-catch
  try {
    final user = await fetchUserData(1);
    print('  Du lieu nhan duoc:');
    user.forEach((k, v) => print('     $k: $v'));
  } catch (e) {
    print('  [LOI] $e');
  }

  // Thử với userId không hợp lệ
  try {
    await fetchUserData(-1);
  } catch (e) {
    print('  [LOI MONG DOI] $e');
  }

  // Future.then / catchError (style cũ)
  print('\n  Future.then style:');
  Future.delayed(Duration(milliseconds: 300))
      .then((_) => print('  Future.delayed hoan tat (then)'))
      .catchError((e) => print('  Lỗi: $e'));

  await Future.delayed(Duration(milliseconds: 400));

  // Sequential vs Parallel
  await fetchSequential();
  await fetchParallel();

  // ── B. Null Safety ─────────────────────────────────────
  demonstrateNullSafety();

  // ── C. Streams ─────────────────────────────────────────
  print('\n--- C. STREAMS ---');

  // Stream đơn giản
  print('countStream(5):');
  await for (int val in countStream(5)) {
    print('  Nhan: $val');
  }

  // Stream transform
  print('\nevenSquares(10) – bình phương số chẵn:');
  await for (int sq in evenSquares(10)) {
    print('  $sq');
  }

  // StreamController + listen
  print('\nmessageStream():');
  final completer = Completer<void>();
  messageStream().listen(
    (msg) => print('  [MSG] $msg'),
    onDone: () {
      print('  Stream da dong');
      completer.complete();
    },
    onError: (e) => print('  [LOI STREAM] $e'),
  );
  await completer.future;

  // Stream.fromIterable
  print('\nStream.fromIterable:');
  final fruits = Stream.fromIterable(['Táo', 'Cam', 'Xoài', 'Chuối']);
  await fruits.forEach((f) => print('  - $f'));

  // StreamController broadcast
  print('\nBroadcast Stream (nhiều subscriber):');
  final bc = StreamController<int>.broadcast();
  bc.stream.listen((v) => print('  Subscriber 1: $v'));
  bc.stream.listen((v) => print('  Subscriber 2: ${v * v}'));
  for (int i = 1; i <= 3; i++) {
    bc.add(i);
  }
  await bc.close();

  print('\nExercise 5 hoan thanh!\n');
  print('TAT CA EXERCISES DA HOAN THANH!');
}
