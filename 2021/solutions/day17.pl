use POSIX;

@nums = split(/[=,.\n]/, <>);
$x=$nums[1];
$X=$nums[3];
$y=$nums[5];
$Y=$nums[7];

# The highest throw is such where vx is small enough that it reaches 0 by the
# time it hits the target.
# When throwing up the moves will be:
# vy + (vy-1) + ... + 1 + 0 - 1 - ... - (vy-1) - vy - [(vy+1) - ...
# Everything before '[' sums to zero, so we always end up at y=0 at some point.
# If we maximize vy we have to make sure -(vy+1) is on target. Meaning that
# maximum vy = -y - 1 and its height is (vy+1)*vy/2

$vy = -1-$y;
print $vy*($vy+1)/2, "\n";  # Part 1

# Helper function that solves 'What is the initial velocity to reach $d in $n steps'
# i.e. find $v such that: $d = $v + ($v-1) + ... + ($v-($n-1))
# or or with the sum simplified $d = (2*$v + 1 - $n) * $n / 2
sub findV {
    my ($d, $n) = @_;
    return $d/$n + ($n-1)/2;
}

sub hitsTarget {
    my ($vx, $vy, $steps) = @_;
    $py = (2*$vy + 1 - $steps) * $steps / 2;
    $px = (2*$vx + 1 - $steps) * $steps / 2;
    if ($vx < $steps) {
        $px = ($vx + 1) * $vx / 2;
    }
    return ($px >= $x) && ($px <= $X) && ($py >= $y) && ($py <= $Y)
}

# What is the range of x velocities that the probe stops
# within the correct x range?
# For all $vx in [$slowVx, $fastVx]:
# $x <= $vx + ($vx - 1) + ... + 2 + 1 <= $X
$slowVx = ceil((-1 + sqrt(2+8*$x))/2);
$fastVx = floor((-1 + sqrt(2+8*$X))/2);

# The highest throw also represents the LONGEST throw. No other throw will take
# more steps to hit the target, which we can use to find all possible throws.
$numThrows = 0;
for $steps (1..(2*$vy+2)){
    $minVx = ceil(findV($x, $steps));
    $maxVx = floor(findV($X, $steps)); 
    # Vx cannot become negative so this solution may not be correct
    if ($maxVx <= $steps) {
        $maxVx = $fastVx;
    }
    if ($minVx <= $steps) {
        $minVx = $slowVx;
    }
    $minVy = ceil(findV($y, $steps));
    $maxVy = floor(findV($Y, $steps));
    # All throws with Vx in [minVx, maxVx] and Vy in [minVy, maxVy] hit the target
    # but some of those may hit the target on multiple steps. So I can't just sum it
    # and have to remove duplicates with a for loop.
    # $numThrows += ($maxVy - $minVy + 1) * ($maxVx - $minVx + 1);
    for $i ($minVx..$maxVx){
        for $j ($minVy..$maxVy){
            if (!hitsTarget($i, $j, $steps-1)) {
                $numThrows += 1;
            }
        }
    }
}
print "$numThrows\n";  # Part 2
