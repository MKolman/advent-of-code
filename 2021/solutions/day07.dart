import 'dart:io';
import 'dart:math';

int fuelUsage(List<int> nums, int pos) {
  int result = 0;
  for (final n in nums) {
    result += max(pos-n, n-pos);
  }
  return result;
}

int fuelUsage2(List<int> nums, int pos) {
  int result = 0;
  for (final n in nums) {
    int v = max(pos-n, n-pos);
    result += v * (v+1) ~/ 2;
  }
  return result;
}

void main() {
  final nums = stdin.readLineSync()!.split(',').map(int.parse).toList();
  nums.sort();

  num minFuel = fuelUsage(nums, 0);
  num minFuel2 = fuelUsage2(nums, 0);
  for (var i = nums[0]; i <= nums.last; i++) {
    minFuel = min(minFuel, fuelUsage(nums, i));
    minFuel2 = min(minFuel2, fuelUsage2(nums, i));
  }

  print(minFuel);
  print(minFuel2);
}

