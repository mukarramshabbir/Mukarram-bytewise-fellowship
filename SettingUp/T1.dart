import 'dart:io';

class Num {
  int num = 10;
}

main() {
  stdout.writeln('What is Name: ?');
  String name = stdin.readLineSync()!;

  print("Hello world $name");
  var n = Num();
  int number;
  number = n?.num ?? 0;
  print(number);
  var num1;
  print(num1 ??= 2);

  int x = 101;
  var res = x % 2 == 0 ? 'Even' : 'Odd';
  print(res);

  var numb = [1, 2, 3];
  numb.forEach((element) => print(element));
}
