using System.Collections.Generic;

public class Pair<T, U> {
    public Pair() {
    }

    public Pair(T first, U second) {
        this.First = first;
        this.Second = second;
    }

    public T First { get; set; }
    public U Second { get; set; }
};

class X {
    public static int fill(int[][] tunnels, ref bool[,] visited, int x, int y) {
        Queue<Pair<int, int>> q = new Queue<Pair<int, int>>();
        q.Enqueue(new Pair<int, int>(x, y));
        visited[x, y] = true;
        int fillSum = 0;
        Pair<int, int> p = new Pair<int, int>(0, 0);

        while (q.TryDequeue(out p)) {
            int i = p.First;
            int j = p.Second;
            fillSum++;

            if (i > 0 && 9 > tunnels[i-1][j] && !visited[i-1, j]) {
                q.Enqueue(new Pair<int, int>(i-1, j));
                visited[i-1, j] = true;
            }
            if (i < tunnels.Length-1 && 9 > tunnels[i+1][j] && !visited[i+1, j]) {
                q.Enqueue(new Pair<int, int>(i+1, j));
                visited[i+1, j] = true;
            }
            if (j > 0 && 9 > tunnels[i][j-1] && !visited[i, j-1]) {
                q.Enqueue(new Pair<int, int>(i, j-1));
                visited[i, j-1] = true;
            }
            if (j < tunnels[i].Length-1 && 9 > tunnels[i][j+1] && !visited[i, j+1]) {
                q.Enqueue(new Pair<int, int>(i, j+1));
                visited[i, j+1] = true;
            }
        }
        return fillSum;
    }
};

class Y {
    public static int solve(int[][] tunnels) {
        bool[,] visited = new bool[tunnels.Length, tunnels[0].Length];
        List<int> holes = new List<int>();
        for (int i = 0; i < tunnels.Length; i++) {
            for (int j = 0; j < tunnels[i].Length; j++) {
                if (!visited[i, j] && tunnels[i][j] != 9) {
                    holes.Add(X.fill(tunnels, ref visited, i, j));
                }
            }
        }
        holes.Sort();
        int[] ha = holes.ToArray();
        return ha[ha.Length-1] * ha[ha.Length-2] * ha[ha.Length-3]; 
    }
};

string line;
List<int[]> tunnels = new List<int[]>();
while ((line = Console.ReadLine()) != null) {
    List<int> nums = new List<int>();
    foreach (char c in line) {
        nums.Add(Convert.ToInt32(c.ToString()));
    }
    tunnels.Add(nums.ToArray());
}

int[][] tunnelA = tunnels.ToArray();

int minCount = 0;
for (int i = 0; i < tunnelA.Length; i++) {
    for (int j = 0; j < tunnelA[i].Length; j++) {
        bool min = true;
        if (i > 0 && tunnelA[i][j] >= tunnelA[i-1][j]) min = false;
        if (i < tunnelA.Length-1 && tunnelA[i][j] >= tunnelA[i+1][j]) min = false;
        if (j > 0 && tunnelA[i][j] >= tunnelA[i][j-1]) min = false;
        if (j < tunnelA[i].Length-1 && tunnelA[i][j] >= tunnelA[i][j+1]) min = false;
        if (min) minCount += tunnelA[i][j] + 1;
    }
}
Console.WriteLine(minCount);
Console.WriteLine(Y.solve(tunnelA));

