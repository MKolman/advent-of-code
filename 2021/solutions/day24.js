/* (My) Input is made of blocks like this, where only three instructions differ between them
inp w
mul x 0
add x z
mod x 26
div z D = {1, 26}
add x A = {-3, -13, -1, -8, 11, 12, 10, 13, -4, -11, 14}
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y B = {8, 12, 10, 4, 1, 15, 9, 7}
mul y x
add z y

All in all it can be simplified into:
```
w = inp()
x = (z%26+A) != w
z = (z // D) * (25*x + 1) + (w + B)*x
```
The variable z is the only one that persists between blocks.
*/

function getBlocks(data) {
  const result = [];
  for (let i = 0; i < data.length; i += 18) {
    const d = +data[i+4][2];
    const a = +data[i+5][2];
    const b = +data[i+15][2];
    result.push([d, a, b]);
  }
  return result;
}

function runBlock(z, w, d, a, b) {
  const x = (z % 26 + a) != w;
  return parseInt(z / d) * (25*x + 1) + (w + b) * x;
}

function solve(blocks, idx, z) {
  if (idx == blocks.length) {
    return z == 0 ? "" : null;
  }
  const memo_key = `${idx}/${z}`;
  if (memo[memo_key] !== undefined) return memo[memo_key];
  let result = null;
  for (const w of DIGITS) {
    result = solve(blocks, idx+1, runBlock(z, w, ...blocks[idx]));
    if (result !== null) {
      result = w.toString() + result;
      break;
    }
  }
  return memo[memo_key] = result;
}

const fs = require("fs");
const data = fs.readFileSync("/dev/stdin", "utf-8").split("\n").map(l => l.split(' '));
data.pop();
const blocks = getBlocks(data);

let memo = {};
let DIGITS = [9, 8, 7, 6, 5, 4, 3, 2, 1];
const part1 = solve(blocks, 0, 0);
console.log(part1);

memo = {};
DIGITS = [1, 2, 3, 4, 5, 6, 7, 8, 9];
const part2 = solve(blocks, 0, 0);
console.log(part2);
