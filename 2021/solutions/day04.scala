class Bingo {
    private var board = Array.ofDim[Int](5, 5)
    private var marked = Array.ofDim[Boolean](5, 5)
    private var total = 0
    private var num2pos = scala.collection.mutable.Map[Int, (Int, Int)]()
    private var won = false

    def init() {
        for (i <- 0 to 4) {
            board(i) = scala.io.StdIn.readLine().trim().split(" +").map(_.toInt)
            for (j <- 0 to 4) {
                num2pos += (board(i)(j) -> (i, j))
                total += board(i)(j)
            }
        }
    }

    def mark(v: Int): Int = {
        if (!num2pos.contains(v) || won) return 0
        val (x, y) = num2pos(v)
        marked(x)(y) = true
        total -= v

        var winH = true
        var winV = true
        for (i <- 0 to 4) {
            if (!marked(x)(i)) {
              winH = false
            }
        }
        for (i <- 0 to 4) {
            if (!marked(i)(y)) {
              winV = false
            }
        }
        if (!winV && !winH) return 0
        won = true
        return total
    }

}

object day04 {
    def main(args: Array[String]) = {
        val nums = scala.io.StdIn.readLine().split(',').map(_.toInt)
        var boards = Array[Bingo]()
        while (scala.io.StdIn.readLine() != null) {
            var b = new Bingo()
            b.init()
            boards :+= b
        }
        var won = 0
        for (n <- nums) {
            for (b <- boards) {
                val r = b.mark(n)
                if (r != 0) {
                    if (won == 0 || won == boards.length-1) {
                        println(r*n);
                    }
                    won += 1
                }
            }
        }
    }
}

