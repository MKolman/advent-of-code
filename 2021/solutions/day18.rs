#[derive(Clone, Debug, PartialEq)]
enum Num {
    Single(i64),
    Pair(Box<Num>, Box<Num>),
}

impl Num {
    fn magnitude(&self) -> i64 {
        match &*self {
            Num::Single(v) => *v,
            Num::Pair(l, r) => l.magnitude()*3 + r.magnitude()*2,
        }
    }

    fn explode(&mut self, d: i64) -> Option<(i64, i64)> {
        if d <= 4 {
            return match self {
                Num::Pair(l, r) => {
                    if let Some((a, b)) = l.explode(d+1) {
                        r.add_left(b);
                        return Some((a, 0));
                    }
                    if let Some((a, b)) = r.explode(d+1) {
                        l.add_right(a);
                        return Some((0, b));
                    }
                    return None;
                }
                _ => None,
            };
        }

        let mut reset = false;
        let (mut a, mut b) = (0, 0);
        if let Num::Pair(l, r) = self {
            reset = true;
            if let Num::Single(x) = **l {
                a = x;
            }
            if let Num::Single(x) = **r {
                b = x;
            }
        }
        if reset {
            *self = Num::Single(0);
            return Some((a, b));
        }
        return None;
    }

    fn split(&mut self) -> bool {
        match self {
            Num::Single(v) if *v > 9 => {
                *self = Num::Pair(
                    Box::new(Num::Single(*v/2)),
                    Box::new(Num::Single((*v+1)/2)),
                );
                return true;
            },
            Num::Pair(l, r) => {
                match l.split() {
                    true => true,
                    false => r.split()
                }
            },
            _ => false,
        }
    }

    fn add_left(&mut self, v: i64) {
        match &mut *self {
            Num::Single(x) => *x += v,
            Num::Pair(l, _) => l.add_left(v),
        }
    }

    fn add_right(&mut self, v: i64) {
        match &mut *self {
            Num::Single(x) => *x += v,
            Num::Pair(_, r) => r.add_right(v),
        }
    }
}

impl std::ops::Add for Num {
    type Output = Self;

    fn add(self, other: Self) -> Self {
        let mut result = Num::Pair(Box::new(self), Box::new(other));
        loop {
            while let Some(_) = result.explode(1) {}
            if !result.split() {
                break;
            }
        }
        return result;
    }
}

impl std::fmt::Display for Num {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        match &self {
            Num::Single(v) => write!(f, "{}", v),
            Num::Pair(a, b) => write!(f, "[{},{}]", a, b),
        }
    }
}

fn build(line: &Vec<char>, start: usize) -> (Box<Num>, usize){
    match line[start]{
        '[' => {
            let (l, start) = build(line, start+1);
            let (r, start) = build(line, start+1);
            return (Box::new(Num::Pair(l, r)), start + 1);
        }
        c if c.is_digit(10) => (Box::new(Num::Single(c.to_digit(10).unwrap().into())), start+1),
        c => panic!("Unable to start a number with {}", c),
    }
}

fn main() {
    let mut line = String::new();
    let mut nums = Vec::new();
    while matches!(std::io::stdin().read_line(&mut line), Ok(_)) && line.trim().len() != 0 {
        let (n, _) = build(&line.chars().collect(), 0);
        nums.push(*n);
        line.clear();
    }

    let mut part1 = nums[0].clone();
    for i in 1..nums.len() {
        part1 = part1 + nums[i].clone();
    }
    println!("{}", part1.magnitude());

    let mut part2 = 0;
    for n in &nums.clone() {
        for m in &nums.clone() {
            if n == m { continue; }
            part2 = std::cmp::max(part2, (n.clone() + m.clone()).magnitude());
        }
    }
    println!("{}", part2);
}
