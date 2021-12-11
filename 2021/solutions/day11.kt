class Oct(var value: Int) {
    var shined: Boolean = false

    fun increase(): Boolean {
        if (shined) return false
        value += 1
        shined = value > 9
        return shined
    }

    fun reset() {
        if (shined) value = 0
        shined = false
    }

    override fun toString(): String {
        return value.toString()
    }
}

fun main() {
    val oct = Array(10, { _ -> listOf<Oct>() })
    for (i in 0..9) {
        oct.set(i, readLine()!!.map({ x -> Oct(x.toString().toInt()) }))
    }
    var part1 = 0
    var part2 = 0
    while (true) {
        part2 += 1
        var q = mutableListOf<Pair<Int, Int>>()
        for (i in 0..9) for (j in 0..9) q.add(Pair(i, j))
        while (!q.isEmpty()) {
            var (i, j) = q.removeLast()
            if (oct.get(i).get(j).shined) continue
            if (oct.get(i).get(j).increase()) {
                if (part2 <= 100) part1 += 1
                for (x in maxOf(i-1, 0)..minOf(i+1, 9)) {
                    for (y in maxOf(j-1, 0)..minOf(j+1, 9)) {
                        if (!oct.get(x).get(y).shined) q.add(Pair(x,y))
                    }
                }
            }
        }
        var all = true
        for (row in oct) for (o in row){
            if (!o.shined) all = false
            o.reset()
        }
        if (all) break
    }
    println(part1)
    println(part2)
}
