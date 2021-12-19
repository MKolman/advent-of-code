<?php
class Vec3 extends SplFixedArray {
    function __construct(array $coor) {
        parent::__construct(3);
        for ($i = 0; $i < 3; $i++) {
            $this[$i] = $coor[$i];
        }
    }

    function add(Vec3 $o) {
        $result = [];
        for ($i = 0; $i < 3; $i++) {
            $result[] = $this[$i] + $o[$i];
        }
        return new Vec3($result);
    }

    function sub(Vec3 $o) {
        $result = [];
        for ($i = 0; $i < 3; $i++) {
            $result[] = $this[$i] - $o[$i];
        }
        return new Vec3($result);
    }

    function eq(Vec3 $o) {
        for ($i = 0; $i < 3; $i++) {
            if ($this[$i] != $o[$i]) return false;
        }
        return true;
    }

    function lt(Vec3 $o) {
        for ($i = 0; $i < 3; $i++) {
            if ($this[$i] > $o[$i]) return false;
            if ($this[$i] < $o[$i]) return true;
        }
        return false;
    }

    function dist(Vec3 $o) {
        return abs($this[0]-$o[0]) + abs($this[1]-$o[1]) + abs($this[2]-$o[2]);
    }

    function roll() {
        return new Vec3([$this[0], $this[2], -$this[1]]);
    }

    function turn() {
        return new Vec3([-$this[1], $this[0], $this[2]]);
    }

    function rot(int $type, int $start) {
        # RTTTRTTTRTTT RTR RTTTRTTTRTTT
        $result = $this;
        for ($i = $start; $i < $type; $i++) {
            if ($i % 4 == 0) {
                $result = $result->roll();
            } else {
                $result = $result->turn();
            }
            if ($i == 11) $result = $result->roll()->turn()->roll();

        }
        return $result;
    }
}

function cmp_vec(Vec3 $a, Vec3 $b) {
    if ($a->eq($b)) return 0;
    return $a->lt($b) ? -1 : 1;
}

function recenter(array $vecs, Vec3 $center) {
    return array_map(function($v) use ($center) {return $v->sub($center);}, $vecs);
}

function rot(array $vecs, int $rot, int $rot_start) {
    return array_map(function(Vec3 $v) use ($rot, $rot_start) {
        return $v->rot($rot, $rot_start);
    }, $vecs);
}

function find_rot(array $control, array $exp) {
    usort($control, "cmp_vec");
    $prev = 0;
    for ($rot = 0; $rot < 24; $rot++) {
        $exp = rot($exp, $rot, $prev);
        $prev = $rot;
        usort($exp, "cmp_vec");
        $i = 0;
        $j = 0;
        $num_matches = 0;
        while ($i < count($control) && $j < count($exp)) {
            if ($control[$i]->eq($exp[$j])) {
                $num_matches++;
                $i++;
                $j++;
            } else if ($control[$i]->lt($exp[$j])) {
                $i++;
            } else {
                $j++;
            }
        }
        if ($num_matches >= 12) return $rot;
    }
    return -1;
}

function orient(array $control, array $exp) {
    global $probe_loc;
    for ($i = 0; $i < count($control); $i++) {
        for ($j = 0; $j < count($exp); $j++) {
            // Assume control[$i] and exp[$j] reference the same point
            $recontrol = recenter($control, $control[$i]);
            $reexp = recenter($exp, $exp[$j]);
            $rot = find_rot($recontrol, $reexp);
            if ($rot < 0) {
                continue;
            }
            $exp = rot($exp, $rot, 0);
            $probe_loc[] = $exp[$j]->sub($control[$i]);
            $exp = recenter($exp, $exp[$j]->sub($control[$i]));
            usort($exp, "cmp_vec");
            return $exp;
        }
    }
    return NULL;
}

function read_data() {
    $result = [];
    $tmp = [];
    while ($line = fgets(STDIN)) {
        if ($line == "\n" || $line == "") {
            continue;
        }
        if ($line[0] == "-" && $line[1] == "-") {
            if (count($tmp) > 0) {
                usort($tmp, "cmp_vec");
                $result[] = $tmp;
                $tmp = [];
            }
            continue;
        }
        $tmp[] = new Vec3(explode(",", trim($line)));
    }
    usort($tmp, "cmp_vec");
    $result[] = $tmp;
    return $result;
}

$probes = read_data();
$probe_loc = [];
$oriented = [0 => 1];
$unoriented = [];
for ($i = 1; $i < count($probes); $i++) $unoriented[$i] = 1;

$failed_attempts = [];
while (count($unoriented) > 0) {
    foreach(array_keys($unoriented) as $exp_id) {
        foreach(array_keys($oriented) as $control_id) {
            if (array_key_exists("$control_id $exp_id", $failed_attempts)){
                continue;
            }
            $fixed = orient($probes[$control_id], $probes[$exp_id]);
            if ($fixed == NULL) {
                $failed_attempts["$control_id $exp_id"] = 1;
                continue;
            }
            $probes[$exp_id] = $fixed;
            $oriented[$exp_id] = 1;
            unset($unoriented[$exp_id]);
            continue 3;
        }
    }
    break;
}

$all = [];
foreach($probes as $p) {
    foreach($p as $b) {
        $all["$b[0]/$b[1]/$b[2]"] = $b;
    }
}
$keys = array_values($all);
usort($keys, "cmp_vec");
print count($all)."\n";

$max = 0;
foreach ($probe_loc as $l) {
    foreach ($probe_loc as $I) {
        $max = max($max, $l->dist($I));
    }
}
print "$max\n";
?>
