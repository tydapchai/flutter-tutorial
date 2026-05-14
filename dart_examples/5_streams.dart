// =============================================================
// CHỦ ĐỀ 5: STREAMS — Chuỗi giá trị bất đồng bộ
// Nguồn: dart.dev/libraries/async/using-streams
//        dart.dev/libraries/async/creating-streams
// =============================================================
//
//  Future<T> → 1 kết quả duy nhất trong tương lai
//  Stream<T> → NHIỀU kết quả liên tiếp theo thời gian
//            → như Iterable bất đồng bộ
//
// BIG PICTURE:
//   Phần 1: Nhận events  — await for / listen()
//   Phần 2: Xử lý lỗi   — try/catch + await for
//   Phần 3: Methods      — process (toList, fold...) & modify (map, where...)
//   Phần 4: Hai loại     — Single-subscription vs Broadcast
//   Phần 5: Tạo Stream   — Transform / async* / StreamController
// =============================================================

import 'dart:async';

void main() async {
  await part1_receivingEvents();
  await part2_errorHandling();
  await part3_streamMethods();
  await part4_twoKinds();
  await part5_creatingStreams();
}

// ─────────────────────────────────────────────────────────────
// PHẦN 1: Nhận events — await for vs listen()
// ─────────────────────────────────────────────────────────────
// Stream giống Iterable bất đồng bộ:
//   Iterable: lấy giá trị khi ta hỏi (pull)
//   Stream:   nhận giá trị khi nó sẵn sàng (push)
//
// Hai cách nhận events:
//   - await for  → kiểu loop, code đọc tuần tự, dễ hiểu
//   - listen()   → callback, linh hoạt hơn, cần quản lý subscription

Future<void> part1_receivingEvents() async {
  print('\n════════════════════════════════════════════');
  print(' Phần 1: Nhận events');
  print('════════════════════════════════════════════');

  // Tạo stream 1..5 bằng async*
  final stream = _countStream(5);

  // Cách A: await for — giống for loop thông thường
  // Hàm phải đánh dấu async; loop dừng khi stream đóng
  print('await for (1+2+3+4+5):');
  final sum = await _sumStream(stream);
  print('  Tổng = $sum'); // 15

  // Cách B: listen() — low-level, tất cả method khác đều gọi listen() bên trong
  // listen() trả về StreamSubscription để quản lý vòng đời
  print('\nlisten():');
  final stream2 = _countStream(3);
  final sub = stream2.listen(
    (value) => print('  data: $value'),
    onError: (e) => print('  error: $e'),
    onDone: () => print('  done!'),
    cancelOnError: false, // mặc định: true (dừng khi gặp lỗi đầu tiên)
  );
  await Future.delayed(const Duration(milliseconds: 100));
  // sub.pause() / sub.resume() / sub.cancel() — quản lý subscription
  await sub.cancel();
}

// Hàm async* — generator tạo stream số từ 1..n
Stream<int> _countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    yield i; // phát từng số, body tạm dừng
  }
}

// Dùng await for để cộng tổng — hàm phải là async
Future<int> _sumStream(Stream<int> stream) async {
  var sum = 0;
  await for (final value in stream) {
    sum += value;
  }
  return sum; // trả về Future<int>
}

// ─────────────────────────────────────────────────────────────
// PHẦN 2: Xử lý lỗi — try/catch bọc await for
// ─────────────────────────────────────────────────────────────
// Khi stream phát error event:
//   - await for → lỗi được throw tại loop → catch bắt được
//   - Loop kết thúc sau lỗi đầu tiên (trừ khi có handleError)
//   - handleError() lọc lỗi trước khi vào loop

Future<void> part2_errorHandling() async {
  print('\n════════════════════════════════════════════');
  print(' Phần 2: Xử lý lỗi');
  print('════════════════════════════════════════════');

  // Stream phát lỗi tại i==4
  final stream = _countStreamWithError(6);

  // try/catch bọc await for — bắt lỗi từ stream
  print('try/catch với await for:');
  try {
    await for (final v in stream) {
      print('  value: $v');
    }
  } catch (e) {
    print('  ❌ Caught: $e');
  }

  // handleError() — lọc lỗi, tiếp tục stream
  print('\nhandleError() — lọc lỗi, stream tiếp tục:');
  final safe = _countStreamWithError(6)
      .handleError((e) => print('  ⚠️  Skipped error: $e'));
  await for (final v in safe) {
    print('  value: $v');
  }
}

Stream<int> _countStreamWithError(int to) async* {
  for (int i = 1; i <= to; i++) {
    if (i == 4) {
      yield* Stream.error('Error at i=$i'); // phát error event
    } else {
      yield i;
    }
  }
}

// ─────────────────────────────────────────────────────────────
// PHẦN 3: Stream methods — process & modify
// ─────────────────────────────────────────────────────────────
// Stream có đầy đủ methods tương tự Iterable, chia làm 2 nhóm:
//
// PROCESS → tiêu thụ stream, trả về Future (1 giá trị cuối):
//   first, last, length, isEmpty, single
//   any(), every(), contains(), fold(), toList(), toSet(), join()
//
// MODIFY  → trả về Stream mới (lazy, chỉ chạy khi listen):
//   map(), where(), expand(), take(), skip()
//   takeWhile(), skipWhile(), distinct(), cast()
//   asyncMap(), asyncExpand()  ← bản async của map/expand

Future<void> part3_streamMethods() async {
  print('\n════════════════════════════════════════════');
  print(' Phần 3: Stream methods');
  print('════════════════════════════════════════════');

  // ── PROCESS methods (trả về Future) ──────────────────────────
  print('PROCESS methods:');

  final s1 = Stream.fromIterable([3, 1, 4, 1, 5, 9, 2, 6]);
  print('  toList: ${await s1.toList()}');

  final s2 = Stream.fromIterable([1, 2, 3, 4, 5]);
  print('  fold (sum): ${await s2.fold(0, (a, b) => a + b)}');

  final s3 = Stream.fromIterable([1, 2, 3, 4, 5]);
  print('  any >4: ${await s3.any((n) => n > 4)}');

  final s4 = Stream.fromIterable([2, 4, 6]);
  print('  every even: ${await s4.every((n) => n.isEven)}');

  final s5 = Stream.fromIterable([1, 2, 3]);
  print('  join: ${await s5.join(', ')}');

  // lastWhere — tìm phần tử cuối thỏa điều kiện
  final s6 = Stream.fromIterable([-2, 3, -1, 4, -5]);
  final lastPos = await s6.lastWhere((x) => x >= 0);
  print('  lastWhere >=0: $lastPos'); // 4

  // ── MODIFY methods (trả về Stream mới, lazy) ─────────────────
  print('\nMODIFY methods (lazy pipeline):');

  // map → where → take: pipeline
  final pipeline = Stream.fromIterable(List.generate(10, (i) => i))
      .map((n) => n * n)        // bình phương: 0,1,4,9,16,25,36,49,64,81
      .where((n) => n.isOdd)    // lọc lẻ: 1,9,25,49,81
      .take(3);                 // lấy 3: 1,9,25
  print('  map²→where odd→take 3: ${await pipeline.toList()}');

  // distinct — bỏ liên tiếp trùng
  final s7 = Stream.fromIterable([1, 1, 2, 2, 3, 1, 1]);
  print('  distinct: ${await s7.distinct().toList()}'); // [1,2,3,1]

  // skip / skipWhile
  final s8 = Stream.fromIterable([1, 2, 3, 4, 5]);
  print('  skip(2): ${await s8.skip(2).toList()}'); // [3,4,5]

  // asyncMap — map bất đồng bộ (mỗi phần tử có thể await)
  print('\nasyncMap (gọi API giả lập):');
  final ids = Stream.fromIterable([1, 2, 3]);
  await for (final name in ids.asyncMap(_fakeApiCall)) {
    print('  user: $name');
  }
}

Future<String> _fakeApiCall(int id) async {
  await Future.delayed(const Duration(milliseconds: 50));
  return 'User#$id';
}

// ─────────────────────────────────────────────────────────────
// PHẦN 4: Hai loại Stream
// ─────────────────────────────────────────────────────────────
// SINGLE-SUBSCRIPTION (mặc định):
//   - Chỉ 1 listener tại một thời điểm
//   - Data tuần tự, không mất events
//   - Dùng cho: file, HTTP, sequences cần thứ tự
//   - listen() lần 2 → StateError!
//
// BROADCAST:
//   - Nhiều listener cùng lúc
//   - Listener mới chỉ nhận events từ thời điểm subscribe
//   - Không có buffer — events bị bỏ nếu chưa có listener
//   - Dùng cho: UI events, pub/sub, shared state

Future<void> part4_twoKinds() async {
  print('\n════════════════════════════════════════════');
  print(' Phần 4: Hai loại Stream');
  print('════════════════════════════════════════════');

  // Single-subscription: chỉ 1 listener
  print('Single-subscription:');
  final single = Stream.fromIterable([1, 2, 3]);
  single.listen((v) => print('  listener: $v'));
  // single.listen(...) // ← StateError: Stream already has subscriber

  await Future.delayed(const Duration(milliseconds: 50));

  // Broadcast: nhiều listener cùng lúc
  print('\nBroadcast:');
  final ctrl = StreamController<int>.broadcast();

  ctrl.stream.listen((v) => print('  [A] $v'));
  ctrl.stream.listen((v) => print('  [B] $v'));

  ctrl.add(10);
  ctrl.add(20);
  await ctrl.close();

  // Chuyển single → broadcast bằng asBroadcastStream()
  print('\nasBroadcastStream():');
  final broadcast = Stream.fromIterable([7, 8, 9]).asBroadcastStream();
  broadcast.listen((v) => print('  listener1: $v'));
  broadcast.listen((v) => print('  listener2: $v'));
  await Future.delayed(const Duration(milliseconds: 50));
}

// ─────────────────────────────────────────────────────────────
// PHẦN 5: Tạo Stream — 3 cách
// ─────────────────────────────────────────────────────────────

Future<void> part5_creatingStreams() async {
  print('\n════════════════════════════════════════════');
  print(' Phần 5: Tạo Stream — 3 cách');
  print('════════════════════════════════════════════');

  // ── Cách A: Transform stream có sẵn ──────────────────────────
  // Dùng map/where/expand/take — tất cả đều LAZY
  print('A) Transform:');
  final evens = Stream.periodic(
    const Duration(milliseconds: 150),
    (i) => i,
  ).take(8).where((n) => n.isEven).map((n) => n * 10);

  print('  periodic → take(8) → where(even) → map(*10):');
  await evens.forEach((v) => print('    $v')); // 0, 20, 40, 60

  // ── Cách B: async* generator ─────────────────────────────────
  // Body chỉ chạy khi listen; yield = push 1 value; return = đóng stream
  print('\nB) async* generator:');
  await for (final n in _countdown(3)) {
    print('  countdown: $n');
  }
  print('  🚀 Lift off!');

  // ── Cách C: StreamController ─────────────────────────────────
  // Dùng khi data đến từ nhiều nguồn (timer, event, callback...)
  // QUAN TRỌNG: phải dùng đủ 4 callback để hỗ trợ pause
  print('\nC) StreamController (với pause support):');
  final stream = _timedCounter(const Duration(milliseconds: 200), 5);
  late StreamSubscription<int> sub;

  sub = stream.listen((n) {
    print('  tick: $n');
    if (n == 3) {
      print('  ⏸ pause 500ms...');
      sub.pause(Future.delayed(const Duration(milliseconds: 500)));
    }
  }, onDone: () => print('  ✅ done'));

  await Future.delayed(const Duration(seconds: 3));
}

// async* — đếm ngược từ n về 1
Stream<int> _countdown(int from) async* {
  for (int i = from; i >= 1; i--) {
    await Future.delayed(const Duration(milliseconds: 200));
    yield i;
  }
}

// StreamController đúng cách — hỗ trợ pause/resume/cancel
Stream<int> _timedCounter(Duration interval, [int? maxCount]) {
  late StreamController<int> controller;
  Timer? timer;
  int counter = 0;

  void tick(_) {
    counter++;
    controller.add(counter);
    if (counter == maxCount) {
      timer?.cancel();
      controller.close();
    }
  }

  void startTimer() => timer = Timer.periodic(interval, tick);
  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  // 4 callbacks — thiếu 1 trong số này có thể gây memory leak
  controller = StreamController<int>(
    onListen: startTimer,  // chỉ bắt đầu khi có listener
    onPause: stopTimer,    // dừng nguồn khi listener pause
    onResume: startTimer,  // tiếp tục khi listener resume
    onCancel: stopTimer,   // dọn dẹp khi listener cancel
  );
  return controller.stream;
}
