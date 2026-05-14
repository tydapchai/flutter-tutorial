

void main() async {
 // Example 1: periodic stream (single-subscription)
final stream = Stream.periodic(const Duration(milliseconds: 3000), (i) => i)
    .take(5); // 0..4 then complete


// Example 2: transform & filter
final evens = stream.where((n) => n.isEven).map((n) => n * 10);
evens.listen((v) => print('Even*10: $v'));
}