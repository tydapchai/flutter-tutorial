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

### 💡 Future vs Stream

| | Future | Stream |
|--|--------|--------|
| Số lượng giá trị | **1** | **Nhiều** |
| Ví dụ | Gọi API | WebSocket, sensor, real-time chat |
| Khi nào xong | Một lần | Có thể mãi mãi (hoặc khi `close()`) |

### 🔑 Hai loại Stream

- **Single-subscription**: 1 listener, sequential (default)
- **Broadcast**: nhiều listener cùng lúc (như EventEmitter / pub-sub)

### 📝 Code mẫu — `5_streams.dart`

```dart
import 'dart:async';

void main() async {
  // Stream.periodic: phát giá trị mỗi 400ms, lấy 5 cái
  final stream = Stream.periodic(
    Duration(milliseconds: 400),
    (i) => i,
  ).take(5);

  stream.listen(
    (value) => print('Nhận: $value'),
    onDone: () => print('Xong!'),
  );

  await Future.delayed(Duration(seconds: 3));

  // Transform: lọc chẵn rồi nhân 10
  final numbers = Stream.fromIterable([1, 2, 3, 4, 5, 6]);
  await for (final v in numbers.where((n) => n.isEven).map((n) => n * 10)) {
    print('Chẵn x10: $v'); // 20, 40, 60
  }

  // Broadcast: nhiều listener cùng nhận
  final ctrl = StreamController<int>.broadcast();
  ctrl.stream.listen((v) => print('Listener A: $v'));
  ctrl.stream.listen((v) => print('Listener B: $v'));
  ctrl.add(42);
  await ctrl.close();
}
```

### 🎤 Script thuyết trình

> *"Chủ đề cuối: **Streams** — chuỗi giá trị bất đồng bộ. Đây là chủ đề nâng cao nhất hôm nay.*
>
> *Nếu Future là 'một lời hứa trả 1 giá trị', thì Stream là 'một lời hứa trả **nhiều giá trị** theo thời gian'. Hãy nghĩ về notification, tin nhắn chat, dữ liệu từ cảm biến GPS — đây đều là Stream.*
>
> *Ví dụ đầu tiên: `Stream.periodic` phát ra một giá trị mỗi 400ms, `.take(5)` chỉ lấy 5 giá trị rồi dừng. `listen()` là cách bạn subscribe — đăng ký nhận giá trị. `onDone` gọi khi Stream kết thúc.*
>
> *Stream cũng hỗ trợ map và where như Collections — nhưng hoạt động theo thời gian, không phải trên list tĩnh. Mỗi giá trị phát ra sẽ đi qua pipeline lọc và biến đổi.*
>
> *Có 2 loại Stream. **Single-subscription**: mặc định, chỉ 1 listener, dữ liệu tuần tự. **Broadcast**: nhiều listener cùng subscribe — giống pub/sub pattern. Trong Flutter, `StreamController.broadcast()` thường dùng để chia sẻ state giữa các widget.*
>
> *Trong Flutter thực tế, bạn sẽ thấy Stream ở khắp nơi: Firestore realtime updates, BLoC state management, WebSocket connections. Hiểu Stream là nền tảng để làm Flutter nâng cao."*

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
