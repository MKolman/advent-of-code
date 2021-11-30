var readline = require('readline');
var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

rl.on('line', function(line){
    let nums = line.split(' ').map(n => parseInt(n));
    console.log(nums[0] + nums[1]);
});
