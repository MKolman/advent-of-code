import 'dart:io';
import 'dart:math';

int solve(List<int> nums, bool easy) {
  // leftCost[d] tells us how much it costs for crabs to the left of d to move to d
  var leftCost = List<int>.filled(nums.last - nums[0] + 1, 0);
  // rightCost[d] tells us how much it costs for crabs to the right of d to move to d
  var rightCost = List<int>.filled(nums.last - nums[0] + 1, 0);

  // Fill leftCost
  var many = 0;
  var moveCost = 0;
  for (var d = 0; d < leftCost.length; d++) {
    if (d > 0) {
        leftCost[d] = leftCost[d-1] + moveCost;
    }
    while (d < leftCost.length - 1 && nums[many] == nums[0] + d) {
      many += 1;
    }
    moveCost = easy ? many : moveCost + many;
  }

  // Fill rightCost
  many = 0;
  moveCost = 0;
  for (var d = rightCost.length-1; d >= 0; d--) {
    if (d < rightCost.length - 1) {
        rightCost[d] = rightCost[d+1] + moveCost;
    }
    while (d > 0 && nums[nums.length - 1 - many] == nums[0] + d) {
      many += 1;
    }
    moveCost = easy ? many : moveCost + many;
  }

  // Find min leftCost[d]+rightCost[d]
  many = rightCost[0] + leftCost[0];
  for (var d = 0; d < leftCost.length; d++) {
    many = min(many, rightCost[d] + leftCost[d]);
  }
  return many;
}

void main() {
  final nums = stdin.readLineSync()!.split(',').map(int.parse).toList();
  nums.sort();
  print(solve(nums, true));
  print(solve(nums, false));
}

