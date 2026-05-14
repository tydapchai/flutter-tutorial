# 📋 Tài liệu Thuyết trình Dart — FPT University

> **5 chủ đề:** Null Safety · Collections · Exceptions · Async/Future · Streams  
> **File code:** `d:\flutter\dart_examples\`

---

## CHỦ ĐỀ 1 — Null Safety: `?`, `??`, `!`

### 💡 Tại sao cần Null Safety?

Trước khi có Null Safety (Dart < 2.12), đây là lỗi phổ biến nhất trong mọi ngôn ngữ lập trình:

```dart
String name;
print(name.length); // 💥 NullPointerException — app crash ngay!
```

Dart giải quyết bằng cách **bắt lỗi null ngay lúc compile** — trước khi chạy app.

### 🔑 3 toán tử cần nhớ

| Toán tử | Tên | Ý nghĩa |
|---------|-----|---------|
| `?` | Nullable | Biến này **được phép** là null |
| `??` | Null-coalescing | Dùng giá trị mặc định **nếu** null |
| `!` | Null-assertion | "Tôi **chắc chắn** không null" |

### 📝 Code mẫu — `1_null_safety.dart`

```dart
void main() {
  String? name;            // ? = có thể null
  print(name);             // null — không crash!

  print(name ?? 'Guest');  // "Guest" — fallback khi null

  name = 'Minh';
  print(name!.length);     // 4 — khẳng định không null
}

String greet(String? userName) {
  final displayName = userName ?? 'khách';
  return 'Xin chào, $displayName!';
}
```

### 🎤 Script thuyết trình

> *"Xin chào mọi người. Chủ đề đầu tiên hôm nay là **Null Safety** — một trong những tính năng quan trọng nhất của Dart.*
>
> *Ai đã từng thấy app bị crash với lỗi 'NullPointerException' chưa? Đây là lỗi số 1 trong lịch sử lập trình — và Dart đã giải quyết nó bằng cách kiểm tra ngay lúc compile, không để lỗi chờ đến runtime.*
>
> *Dart có 3 toán tử cốt lõi.*
>
> *Đầu tiên là dấu hỏi `?` — khi bạn thêm `?` sau kiểu dữ liệu, bạn đang nói với Dart: 'biến này **được phép** là null'. Ở đây `String? name` — Dart chấp nhận, và print ra `null` mà không crash.*
>
> *Thứ hai là `??` — toán tử 'nếu null thì dùng cái này'. Ở đây `name ?? 'Guest'` — vì name đang là null, nên in ra 'Guest'.*
>
> *Thứ ba là `!` — dấu chấm than. Đây là bạn **khẳng định** với Dart: 'tôi chắc chắn cái này không null, hãy tin tôi'. Nhưng cẩn thận — nếu bạn sai thì app sẽ crash runtime. Chỉ dùng khi bạn thực sự chắc chắn.*
>
> *Ứng dụng thực tế: hàm `greet` nhận tham số nullable — caller có thể truyền null, hàm xử lý an toàn bằng `??`. Đây là pattern rất hay dùng trong Flutter khi làm form."*

---

## CHỦ ĐỀ 2 — Collections: `map()` & `where()`

### 💡 Tại sao cần map/where?

Cách cũ (imperative):
```dart
// ❌ Dài dòng, dễ bug
final result = <int>[];
for (final n in numbers) {
  if (n.isEven) result.add(n * 2);
}
```

Cách mới (functional với map/where):
```dart
// ✅ Ngắn, rõ ràng, không có trạng thái phụ
final result = numbers.where((n) => n.isEven).map((n) => n * 2).toList();
```

### 🔑 Khái niệm cốt lõi

- **`map()`** — biến đổi mỗi phần tử → tạo Iterable **cùng số lượng**
- **`where()`** — lọc phần tử → tạo Iterable có thể **ít hơn**
- Cả hai đều **lazy** (không tính ngay), chỉ chạy khi gọi `toList()` / `toSet()` / v.v.

### 📝 Code mẫu — `2_collections_map_filter.dart`

```dart
void main() {
  final numbers = [1, 2, 3, 4, 5];

  // map: nhân đôi mỗi phần tử
  final doubled = numbers.map((n) => n * 2).toList();
  print(doubled);    // [2, 4, 6, 8, 10]

  // where: chỉ giữ số chẵn
  final evens = numbers.where((n) => n.isEven).toList();
  print(evens);      // [2, 4]

  // chain: bình phương rồi lọc > 5
  final bigSquares = numbers
      .map((n) => n * n)
      .where((n) => n > 5)
      .toList();
  print(bigSquares); // [9, 16, 25]

  // Thực tế: lọc học sinh đậu
  final scores = {'An': 8.5, 'Bình': 4.0, 'Chi': 7.0};
  final passed = scores.entries
      .where((e) => e.value >= 5.0)
      .map((e) => '${e.key}: ${e.value}')
      .toList();
  print(passed);     // [An: 8.5, Chi: 7.0]
}
```

### 🎤 Script thuyết trình

> *"Chủ đề thứ hai: **Collections với map và where** — lập trình hàm trên danh sách.*
>
> *Khi làm việc với danh sách, bạn thường có 2 nhu cầu: **biến đổi** và **lọc**. Dart cung cấp 2 hàm cực kỳ mạnh cho việc này.*
>
> *`map()` nhận vào mỗi phần tử, áp dụng một phép biến đổi, và trả ra một Iterable mới có **cùng số phần tử**. Ở đây tôi nhân đôi mỗi số — đầu vào 5 số, đầu ra 5 số.*
>
> *`where()` là filter — nó chỉ giữ lại những phần tử **thỏa điều kiện**. Đầu vào 5 số, chỉ giữ số chẵn, đầu ra 2 số.*
>
> *Điểm hay là bạn có thể **chain** — nối chúng lại. Ở đây: bình phương mỗi số, rồi chỉ giữ kết quả lớn hơn 5.*
>
> *Một điều quan trọng: map và where đều **lazy** — chúng không thực sự tính toán ngay. Chỉ khi bạn gọi `toList()` thì nó mới chạy. Điều này giúp tiết kiệm memory khi làm việc với danh sách lớn.*
>
> *Ví dụ thực tế: lọc học sinh đậu từ bảng điểm — chỉ 3 dòng code, rõ ràng và không bug."*

---

## CHỦ ĐỀ 3 — Exceptions: `try / catch / on / finally`

### 💡 Tại sao cần xử lý Exception?

Không có try/catch: app crash và người dùng thấy màn hình trắng.  
Có try/catch: bắt lỗi, hiển thị thông báo thân thiện, tiếp tục chạy.

### 🔑 Cấu trúc

```
try { ... }                      ← code có thể lỗi
on LoaiLoi catch (e) { ... }     ← bắt đúng loại lỗi
catch (e, stack) { ... }         ← bắt tất cả + stack trace
finally { ... }                  ← LUÔN chạy (dọn dẹp)
```

### 📝 Code mẫu — `3_exceptions.dart`

```dart
int parsePositiveInt(String s) {
  final value = int.parse(s); // throw FormatException nếu không phải số
  if (value < 0) throw ArgumentError('Phải >= 0');
  return value;
}

void safeParse(String input) {
  try {
    print(parsePositiveInt(input));

  } on FormatException catch (e) {
    print('[FormatException] "$input" không phải số');

  } on ArgumentError catch (e) {
    print('[ArgumentError] ${e.message}');

  } catch (e, stack) {
    print('[Unknown] $e');
    // rethrow; // lan lỗi lên trên nếu cần

  } finally {
    print('[finally] Xử lý xong: "$input"');
  }
}

void main() {
  safeParse('12');   // thành công
  safeParse('abc');  // FormatException
  safeParse('-3');   // ArgumentError
}
```

### 🎤 Script thuyết trình

> *"Chủ đề thứ ba: **Exception handling** — xử lý lỗi để app không bị crash.*
>
> *Trong thực tế, rất nhiều thứ có thể sai: người dùng nhập sai, mạng bị ngắt, file không tồn tại. Nếu không xử lý, app sẽ crash. Dart cung cấp cơ chế try/catch để bắt lỗi một cách có kiểm soát.*
>
> *Cấu trúc gồm 4 phần. `try` — bọc code có thể lỗi vào đây. `on LoaiLoi catch(e)` — bắt đúng loại lỗi, ví dụ FormatException khi parse sai. `catch(e, stack)` — bắt tất cả lỗi còn lại, stack trace giúp debug. `finally` — block này **luôn luôn chạy**, dù có lỗi hay không — dùng để đóng file, đóng kết nối database.*
>
> *Điểm quan trọng: nên dùng `on SpecificException` thay vì `catch` chung chung — tránh nuốt lỗi không biết. Và khi cần `rethrow` — bạn có thể log lỗi rồi ném lại để tầng trên xử lý tiếp.*
>
> *Trong Flutter, bạn sẽ dùng pattern này rất nhiều khi gọi API — bắt lỗi mạng, hiển thị snackbar thông báo người dùng thay vì crash."*

---

## CHỦ ĐỀ 4 — Async: `Future` & `async/await`

### 💡 Tại sao cần async?

Dart chạy **1 thread duy nhất** (event loop). Nếu bạn block thread (ví dụ: đợi API 3 giây mà không async), toàn bộ UI sẽ **đơ hoàn toàn** trong 3 giây đó.

```
Không async: [gửi]──[đợi 3s đơ UI]──► [nhận kết quả]
Có async:    [gửi]──► [UI vẫn chạy]──► [nhận kết quả]
```

### 🔑 Khái niệm

- **`Future<T>`** = lời hứa sẽ trả về giá trị kiểu T trong tương lai
- **`async`** = đánh dấu hàm là bất đồng bộ
- **`await`** = "dừng ở đây, chờ Future xong, rồi tiếp tục"

### 📝 Code mẫu — `4_async_future.dart`

```dart
Future<String> fetchUserName(int id) async {
  await Future.delayed(Duration(seconds: 1)); // giả lập gọi API
  if (id == 0) throw Exception('ID không hợp lệ!');
  return 'Nguyễn Văn $id';
}

Future<void> main() async {
  // Gọi tuần tự
  final name = await fetchUserName(3);
  print(name); // in sau 1 giây

  // Xử lý lỗi
  try {
    await fetchUserName(0);
  } catch (e) {
    print('Lỗi: $e');
  }

  // Gọi SONG SONG — 3 request cùng lúc, chỉ mất ~1 giây
  final results = await Future.wait([
    fetchUserName(1),
    fetchUserName(2),
    fetchUserName(3),
  ]);
  print(results);
}
```

### 🎤 Script thuyết trình

> *"Chủ đề thứ tư: **Async với Future và async/await** — lập trình bất đồng bộ.*
>
> *Trước tiên, tại sao cần async? Dart chạy trên 1 thread duy nhất. Nếu bạn gọi API và ngồi đợi 3 giây mà không dùng async, UI của bạn sẽ đơ hoàn toàn — người dùng không scroll được, không nhấn được gì. Đây là trải nghiệm tệ nhất.*
>
> *`Future<T>` là một **lời hứa** — 'tôi hứa sẽ trả cho bạn một String, nhưng chưa phải ngay bây giờ'. Hàm `fetchUserName` trả về `Future<String>` — nó mô phỏng gọi server mất 1 giây.*
>
> *`async` và `await` hoạt động cùng nhau. `async` đánh dấu hàm là bất đồng bộ. `await` nói: 'dừng tại đây, chờ Future này xong, sau đó tiếp tục'. Nhưng quan trọng: chờ mà **không block thread** — Dart vẫn xử lý các việc khác trong lúc chờ.*
>
> *Ví dụ nâng cao: `Future.wait` cho phép chạy nhiều request **song song**. Thay vì đợi 1+1+1=3 giây, bạn chỉ đợi 1 giây vì cả 3 chạy cùng lúc. Đây là optimization rất quan trọng trong app thực tế."*

---

## CHỦ ĐỀ 5 — Streams: Chuỗi giá trị bất đồng bộ

> **Nguồn:** dart.dev/libraries/async/using-streams · dart.dev/libraries/async/creating-streams

---

### 💡 Tổng quan — Big Picture

```
Future<T>  →  1 kết quả duy nhất  →  gọi API, đọc file
Stream<T>  →  nhiều kết quả theo thời gian  →  chat, sensor, realtime
```

Stream giống **Iterable bất đồng bộ**:
- Iterable: bạn kéo (pull) từng giá trị khi hỏi
- Stream: nó đẩy (push) giá trị khi sẵn sàng

**Cấu trúc bài trình bày:**

| # | Nội dung | Khái niệm |
|---|----------|-----------|
| 1 | Nhận events | `await for` · `listen()` |
| 2 | Xử lý lỗi | `try/catch` + `await for` · `handleError` |
| 3 | Stream methods | process vs modify |
| 4 | Hai loại Stream | Single-subscription vs Broadcast |
| 5 | Tạo Stream | Transform · `async*` · `StreamController` |

---

### 📝 Phần 1 — Nhận events: `await for` vs `listen()`

```dart
// Tạo stream bằng async* (xem Phần 5)
Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) yield i;
}

// Cách A: await for — đọc tuần tự như for loop
// Hàm bọc bên ngoài phải đánh dấu async
Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  await for (final value in stream) {  // loop dừng khi stream đóng
    sum += value;
  }
  return sum;
}

void main() async {
  print(await sumStream(countStream(5))); // 15 = 1+2+3+4+5
}

// Cách B: listen() — low-level, linh hoạt hơn
// Tất cả method khác đều gọi listen() bên trong
final sub = stream.listen(
  (value) => print('data: $value'),
  onError: (e) => print('error: $e'),
  onDone:  () => print('done!'),
  cancelOnError: false, // mặc định true = dừng khi gặp lỗi đầu
);
// sub là StreamSubscription — quản lý: pause/resume/cancel
```

### 🎤 Script — Phần 1

> *"Stream là một chuỗi giá trị bất đồng bộ — giống Iterable nhưng thay vì bạn chủ động kéo dữ liệu, stream sẽ đẩy dữ liệu về khi nó sẵn sàng.*
>
> *Có hai cách nhận events. `await for` giống for loop bình thường — code chạy tuần tự, dễ đọc, hàm bọc ngoài phải là `async`. Đây là cách được khuyến nghị.*
>
> *`listen()` là low-level hơn — thực ra tất cả methods trên Stream đều gọi `listen()` bên trong. Nó trả về `StreamSubscription` để bạn `pause`, `resume`, `cancel` subscription."*

---

### 📝 Phần 2 — Xử lý lỗi

```dart
// Lỗi trong stream → throw tại await for → catch bắt được
Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  try {
    await for (final value in stream) {
      sum += value;
    }
  } catch (e) {
    return -1; // trả -1 nếu có lỗi
  }
  return sum;
}

// handleError() — lọc lỗi, cho stream tiếp tục
Stream<int> safeStream = riskyStream
    .handleError((e) => print('Skipped: $e'));

await for (final v in safeStream) { ... } // không bị dừng bởi lỗi
```

### 🎤 Script — Phần 2

> *"Khi stream phát error event, `await for` sẽ throw lỗi đó tại vị trí loop — ta dùng `try/catch` bình thường để bắt.*
>
> *Nhưng có một cách khéo hơn: `handleError()` — nó lọc lỗi trước khi vào loop, cho phép stream tiếp tục chạy dù có lỗi. Rất hữu ích khi xử lý stream dài mà không muốn dừng giữa chừng."*

---

### 📝 Phần 3 — Stream methods: Process & Modify

```dart
// ── PROCESS: tiêu thụ stream → trả về Future (1 giá trị) ──
await stream.toList()                     // → Future<List<T>>
await stream.fold(0, (acc, n) => acc + n) // → Future<S> (tích lũy)
await stream.any((n) => n > 5)            // → Future<bool>
await stream.every((n) => n.isEven)       // → Future<bool>
await stream.length                        // → Future<int>
await stream.first / .last / .single      // → Future<T>
await stream.join(', ')                   // → Future<String>
await stream.lastWhere((x) => x >= 0)    // tìm phần tử cuối thoả điều kiện

// ── MODIFY: trả về Stream mới — LAZY (chỉ chạy khi listen) ──
stream.map((n) => n * 2)          // biến đổi mỗi phần tử
stream.where((n) => n.isEven)     // lọc
stream.expand((n) => [n, n * n])  // 1 → nhiều
stream.take(5)                    // chỉ lấy 5
stream.skip(2)                    // bỏ qua 2 đầu
stream.distinct()                 // bỏ liên tiếp trùng

// asyncMap — giống map nhưng callback có thể là async
stream.asyncMap((id) async => await fetchUser(id))
```

### 🎤 Script — Phần 3

> *"Stream có đầy đủ methods tương tự Iterable, chia làm 2 nhóm.*
>
> *Nhóm **Process** — tiêu thụ stream và trả về một `Future` duy nhất: `toList`, `fold`, `any`, `every`, `join`, `lastWhere`... Dùng khi bạn muốn tổng hợp toàn bộ stream thành một kết quả.*
>
> *Nhóm **Modify** — trả về Stream mới, hoàn toàn **lazy**: `map`, `where`, `expand`, `take`, `skip`, `distinct`... Chỉ thực sự chạy khi có ai `listen()`. Bạn có thể chain nhiều cái lại thành pipeline. Đặc biệt có `asyncMap` — giống `map` nhưng callback có thể là async, rất hữu ích khi mỗi phần tử cần gọi API."*

---

### 📝 Phần 4 — Hai loại Stream

| | Single-subscription | Broadcast |
|--|---|---|
| Listener | 1 | Nhiều cùng lúc |
| Events | Có buffer, không mất | Không buffer — mất nếu chưa listen |
| Subscribe lại | ❌ StateError | ✅ Bất cứ lúc nào |
| Dùng cho | File, HTTP, dữ liệu tuần tự | UI events, pub/sub, shared state |

```dart
// Single-subscription (default)
final stream = Stream.fromIterable([1, 2, 3]);
stream.listen(print);        // ✅
stream.listen(print);        // ❌ StateError!

// Broadcast
final ctrl = StreamController<int>.broadcast();
ctrl.stream.listen((v) => print('A: $v')); // ✅
ctrl.stream.listen((v) => print('B: $v')); // ✅ cùng lúc
ctrl.add(42); // cả A và B đều nhận

// Chuyển đổi
final bc = singleStream.asBroadcastStream();
```

### 🎤 Script — Phần 4

> *"Dart có 2 loại Stream.*
>
> ***Single-subscription** là loại mặc định — chỉ 1 listener, có buffer (không mất data khi chưa listen), data đến đúng thứ tự. Dùng khi đọc file hay nhận response HTTP — dữ liệu cần đầy đủ và theo thứ tự.*
>
> ***Broadcast** — nhiều listener cùng lúc, nhưng không có buffer: nếu bạn subscribe muộn, bạn bỏ lỡ events trước đó. Giống EventEmitter trong Node.js. Trong Flutter, `StreamController.broadcast()` thường dùng để chia sẻ state giữa nhiều widget."*

---

### 📝 Phần 5 — Tạo Stream: 3 cách

#### Cách A: Transform stream có sẵn (lazy pipeline)

```dart
// map, where, expand, take — LAZY: chỉ chạy khi có listener
final result = Stream.periodic(Duration(milliseconds: 400), (i) => i)
    .take(5)               // 0, 1, 2, 3, 4
    .where((n) => n.isEven) // 0, 2, 4
    .map((n) => n * 10);   // 0, 20, 40

result.listen((v) => print('Value: $v'));
// Output: 0, 20, 40
```

#### Cách B: `async*` generator function

```dart
// async* thay cho async; yield thay cho return
// Body chỉ BẮT ĐẦU CHẠY khi có listener
// Khi hàm return → stream đóng (onDone được gọi)
// Khi listener cancel() → yield tiếp theo hoạt động như return
Stream<int> countdown(int from) async* {
  for (int i = from; i >= 1; i--) {
    await Future.delayed(Duration(milliseconds: 300));
    yield i; // phát 1 giá trị, body tạm dừng
  }
} // hàm kết thúc → stream tự đóng

await for (final n in countdown(3)) print(n); // 3, 2, 1
```

#### Cách C: `StreamController` — đúng cách

```dart
// ❌ SAI: timer bắt đầu ngay, không quan tâm pause → buffer leak
Stream<int> bad(Duration d) {
  var ctrl = StreamController<int>();
  Timer.periodic(d, (t) => ctrl.add(t.tick)); // BAD!
  return ctrl.stream;
}

// ✅ ĐÚNG: 4 callbacks kiểm soát vòng đời
Stream<int> timedCounter(Duration interval, [int? max]) {
  late StreamController<int> controller;
  Timer? timer;
  int count = 0;

  void tick(_)    { controller.add(++count); if (count == max) { timer?.cancel(); controller.close(); } }
  void start()    => timer = Timer.periodic(interval, tick);
  void stop()     { timer?.cancel(); timer = null; }

  controller = StreamController<int>(
    onListen:  start, // ✅ chỉ bắt đầu khi có listener
    onPause:   stop,  // ✅ dừng khi listener pause
    onResume:  start, // ✅ tiếp tục khi resume
    onCancel:  stop,  // ✅ dọn dẹp khi cancel
  );
  return controller.stream;
}
```

> ⚠️ **Thiếu `onPause`** → timer chạy liên tục dù không ai nghe → **buffer phình to → memory leak!**

### 🎤 Script — Phần 5

> *"Dart có 3 cách tạo Stream.*
>
> *Cách đơn giản nhất: **transform** — bạn đã có stream, dùng `map`, `where`, `take`... nối lại thành pipeline. Tất cả đều lazy — không tốn tài nguyên cho đến khi có listener.*
>
> *Cách thứ hai: **`async*`** — viết hàm như bình thường, thay `async` thành `async*`, dùng `yield` để phát từng giá trị. Điểm quan trọng: body chỉ bắt đầu chạy khi có người `listen()`. Khi listener `cancel()`, `yield` tiếp theo hoạt động như `return` — rất an toàn.*
>
> *Cách thứ ba: **`StreamController`** — khi data đến từ nhiều nguồn, ví dụ timer và user event cùng lúc. Bạn `add()` data bất kỳ lúc nào, `close()` khi xong. Nhưng **bắt buộc** phải dùng đủ 4 callback: `onListen`, `onPause`, `onResume`, `onCancel`. Nếu thiếu `onPause`, nguồn data vẫn chạy khi listener dừng — buffer phình to và gây memory leak.*
>
> *Tóm lại: stream là trái tim của Flutter async. Bạn sẽ gặp nó ở khắp nơi — Firestore realtime, BLoC pattern, WebSocket. Nắm vững stream là nắm vững nửa Flutter."*

---

## ✅ Checklist trước khi thuyết trình

- [ ] Mở 5 file dart trong VS Code
- [ ] Test chạy mỗi file bên dưới
- [ ] Mở file này để nhìn script
- [ ] Luyện nói to 1 lần trước

## ⚡ Lệnh chạy từng file

```powershell
cd d:\flutter\dart_examples

dart run 1_null_safety.dart
dart run 2_collections_map_filter.dart
dart run 3_exceptions.dart
dart run 4_async_future.dart
dart run 5_streams.dart
```
