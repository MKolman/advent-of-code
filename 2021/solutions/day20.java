import java.util.Scanner;
import java.util.ArrayList;
import java.util.List;


public class day20 {
    public static void main(String args[]) {
        Enhancer map = new Enhancer();
        for (int i = 0; i < 50; i++) {
            map.enhance();
            if (i == 1) System.out.println(map.count());
        }
        System.out.println(map.count());
    }
}

class Enhancer {
    List<Boolean> algo;
    List<List<Boolean>> map;
    Boolean outside;

    Enhancer() {
        Scanner in = new Scanner(System.in);
        algo = parseLine(in.next());

        map = new ArrayList<List<Boolean>>();
        while (in.hasNext()) {
            map.add(parseLine(in.next()));
        }

        outside = false;
    }

    List<Boolean> parseLine(String scan) {
        List<Boolean> result = new ArrayList<>();
        for (char c : scan.toCharArray()) {
            if (c == '.') result.add(false);
            else if (c == '#') result.add(true);
        }
        return result;
    }

    public String toString() {
        String result = "";
        for (List<Boolean> line : map) {
            for (Boolean c : line) {
                result += c ? "#" : ".";
            }
            result += "\n";
        }
        return result;
    }

    boolean getValue(int x, int y) {
        int result = 0;
        for (int j = y-1; j <= y+1; j++) {
            for (int i = x-1; i <= x+1; i++) {
                result *= 2;
                if (i >= 0 && j >= 0 && j < map.size() && i < map.get(j).size()) {
                    result += map.get(j).get(i) ? 1 : 0;
                } else {
                    result += outside ? 1 : 0;
                }
            }
        }
        return algo.get(result);
    }

    public void enhance() {
        List<List<Boolean>> newmap = new ArrayList<>();
        for (int j = -1; j <= map.size(); j++) {
            List<Boolean> tmp = new ArrayList<>();
            for (int i = -1; i <= map.get(0).size(); i++) {
                tmp.add(getValue(i, j));
            }
            newmap.add(tmp);
        }
        map = newmap;
        if (outside) outside = algo.get(511); 
        else outside = algo.get(0);
    }

    public int count() {
        int result = 0;
        for (List<Boolean> line : map) {
            for (Boolean c : line) {
                result += c ? 1 : 0;
            }
        }
        return result;
    }
}

