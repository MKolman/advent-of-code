use std::io;

fn main() {
    let mut line = String::new();
    io::stdin()
        .read_line(&mut line)
        .expect("failed to read from stdin");
    let mut nums = line.split(' ');
    let a: i64 = nums.next().unwrap().trim().parse().unwrap();
    let b: i64 = nums.next().unwrap().trim().parse().unwrap();
    println!("{:?}", a + b);
}
