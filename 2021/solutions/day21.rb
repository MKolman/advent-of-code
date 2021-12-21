def part1(pos)
  score = [0, 0]
  die = 0
  num_rounds = 0
  turn = 0
  while score[0] < 1000 and score[1] < 1000 do
    pos[turn] += die+1 + (die+1)%100 + 1 + (die+2)%100 + 1
    pos[turn] %= 10
    score[turn] += pos[turn]+1

    turn = 1-turn
    die += 3
    die %= 100
    num_rounds += 3
  end
  puts score.min*num_rounds
end

$memo = {}
def part2(pos0, pos1, target0, target1, turn=0)
  memo_key = [pos0, pos1, target0, target1, turn]
  if $memo.key?(memo_key)
    return $memo[memo_key]
  end
  result = [0, 0]
  for die, num in [[3, 1], [4, 3], [5, 6], [6, 7], [7, 6], [8, 3], [9, 1]] do
    if turn == 0
      pos = (pos0 + die) % 10
      if pos+1 >= target0
        result[turn] += num
      else
        tmp = part2(pos, pos1, target0-pos-1, target1, 1-turn)
        result[0] += num * tmp[0]
        result[1] += num * tmp[1]
      end
    else
      pos = (pos1 + die) % 10
      if pos+1 >= target1
        result[turn] += num
      else
        tmp = part2(pos0, pos, target0, target1-pos-1, 1-turn)
        result[0] += num * tmp[0]
        result[1] += num * tmp[1]
      end
    end
  end
  $memo[memo_key] = result
  return result
end

*_, a = gets.split
*_, b = gets.split
a = a.to_i-1
b = b.to_i-1
part1([a, b])

puts part2(a, b, 21, 21, 0).max
