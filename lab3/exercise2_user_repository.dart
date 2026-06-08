import 'dart:convert';

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
    );
  }

  @override
  String toString() => 'User(name: $name, email: $email)';
}

Future<List<User>> fetchUsers() async {
  const jsonString = '''
  [
    {"name": "Alice", "email": "alice@example.com"},
    {"name": "Bob", "email": "bob@example.com"}
  ]
  ''';
  await Future.delayed(Duration(milliseconds: 100));
  List<dynamic> parsed = jsonDecode(jsonString);
  return parsed.map((json) => User.fromJson(json as Map<String, dynamic>)).toList();
}

Future<void> exercise2() async {
  print('--- EXERCISE 2: User Repository with JSON ---');
  final users = await fetchUsers();
  for (var user in users) {
    print(user);
  }
  print('');
}

void main() async {
  await exercise2();
}
