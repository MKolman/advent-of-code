import 'dart:io';

void main() {
  final nums = stdin.readLineSync()!.split(' ');
  final sum = int.parse(nums[0]) + int.parse(nums[1]);
  stdout.writeln('$sum');
}

