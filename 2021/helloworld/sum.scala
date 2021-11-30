object sum {
    def main(args: Array[String]) = {
        val nums = scala.io.StdIn.readLine().split(' ').map(_.toInt)
        println(nums(0) + nums(1))
    }
}

