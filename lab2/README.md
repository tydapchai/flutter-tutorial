# Lab 2 – Dart Essentials Practice Lab

## Cấu trúc thư mục

```
lab2/
├── main.dart                              ← File tổng hợp (nộp bài)
├── exercise1_basic_syntax.dart            ← Exercise 1: Basic Syntax & Data Types
├── exercise2_collections_operators.dart   ← Exercise 2: Collections & Operators
├── exercise3_control_flow_functions.dart  ← Exercise 3: Control Flow & Functions
├── exercise4_oop.dart                     ← Exercise 4: Intro to OOP
├── exercise5_async_null_safety_streams.dart ← Exercise 5: Async & Null Safety
└── README.md                             ← Tài liệu này
```

## Cách chạy

### Chạy file tổng hợp (nộp bài)
```bash
dart run lab2/main.dart
```

### Chạy từng exercise riêng lẻ
```bash
dart run lab2/exercise1_basic_syntax.dart
dart run lab2/exercise2_collections_operators.dart
dart run lab2/exercise3_control_flow_functions.dart
dart run lab2/exercise4_oop.dart
dart run lab2/exercise5_async_null_safety_streams.dart
```

### Chạy trên DartPad
Vào [DartPad](https://dartpad.dev) và paste nội dung của `main.dart`.

---

## Nội dung từng Exercise

### Exercise 1 – Basic Syntax & Data Types
- Khai báo biến: `int`, `double`, `String`, `bool`
- `var`, `dynamic`, `const`, `final`
- String interpolation: `$var`, `${expr}`
- Chuyển đổi kiểu: `int.parse()`, `.toString()`

### Exercise 2 – Collections & Operators
- **List**: indexing, `add()`, `remove()`, `map()`, `where()`
- **Set**: giá trị duy nhất, `intersection`, `union`, `difference`
- **Map**: key-value, `forEach`, `keys`, `values`
- **Operators**: số học, so sánh, logic, ternary `? :`, `??`

### Exercise 3 – Control Flow & Functions
- `if/else` xếp loại học lực
- `switch/case` ngày trong tuần
- Vòng lặp: `for`, `for-in`, `forEach`, `while`, `do-while`, `break/continue`
- Hàm thông thường, arrow syntax `=>`, named params, optional params
- Hàm đệ quy, higher-order function, closure/lambda

### Exercise 4 – Intro to OOP
- Lớp `Vehicle` với constructor, getter/setter, phương thức
- Named constructor (`Vehicle.fromMap`)
- Kế thừa: `Car extends Vehicle`, `ElectricCar extends Car`
- Method overriding (`@override describe()`, `refuel()`)
- Abstract class (`Serviceable`), Mixin (`GPS`), `implements`
- Polymorphism, `is` instanceof check

### Exercise 5 – Async, Future, Null Safety & Streams
- `async/await` với `Future`
- `Future.delayed()` mô phỏng độ trễ
- `Future.wait()` chạy song song
- Null-safety: `?`, `??`, `?.`, `!`, `??=`, `late`
- Stream generator (`async*`, `yield`)
- `StreamController`, `broadcast()`
- Stream operators: `.where()`, `.map()`, `.listen()`

---

## Tiêu chí đánh giá

| Tiêu chí | Tỷ lệ |
|---|---|
| Correctness (chạy đúng) | 40% |
| Use of Dart features | 25% |
| Output accuracy | 20% |
| Code readability & comments | 15% |
