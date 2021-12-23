package main

import (
	"bufio"
	"container/heap"
	"fmt"
	"os"
)

var COST = [5]int64{0, 1, 10, 100, 1000}

type Cave struct {
	Hallway [7]int8
	Rooms   [4][4]int8
	Filled  [4]int
	Correct [4]bool
	Depth   int
}

func (c *Cave) Clone() Cave {
	return Cave{
		Hallway: c.Hallway,
		Rooms:   c.Rooms,
		Filled:  c.Filled,
		Correct: c.Correct,
		Depth:   c.Depth,
	}
}

func (c *Cave) Done() bool {
	for i, r := range c.Filled {
		if !c.Correct[i] || r != c.Depth {
			return false
		}
	}
	return true
}

func countSteps(hall int, room int, depth int) int64 {
	// Find path from position i to hole h
	// 01.2.3.4.56 Hallway
	//   0 1 2 3   Rooms depth = 1
	//   0 1 2 3   Rooms depth = 2
	//   0 1 2 3   Rooms depth = 3
	result := depth
	if hall == 0 {
		result += 1
		hall = 1
	} else if hall == 6 {
		result += 1
		hall = 5
	}
	x := hall*2 - room*2 - 3
	if x > 0 {
		result += x
	} else {
		result -= x
	}
	return int64(result)
}

func (c *Cave) Moves() []State {
	// Move out of hallway
	for i, h := range c.Hallway {
		i := int8(i)
		target := h - 1
		// Can't move back inside
		if h == 0 || !c.Correct[target] {
			continue
		}
		// Find path from position i to hole h
		// 01.2.3.4.5.67 Hallway
		//   0 1 2 3 4   Rooms
		checkFrom, checkTo := i+1, target+1
		if i > target+1 {
			checkFrom = target + 2
			checkTo = i - 1
		}
		hasPath := true
		for j := checkFrom; j <= checkTo; j++ {
			if c.Hallway[j] != 0 {
				hasPath = false
				break
			}
		}
		if !hasPath {
			continue
		}

		n := c.Clone()
		n.Hallway[i] = 0
		n.Rooms[target][n.Filled[target]] = h
		n.Filled[target] += 1
		return []State{
			State{
				Pos:    n,
				Energy: COST[h] * countSteps(int(i), int(target), n.Depth-n.Filled[target]+1),
			},
		}
	}

	// Move from room into hallway
	var result []State
	for i, room := range c.Rooms {
		// Don't move out of your own room that is correct
		if c.Correct[i] {
			continue
		}
		// Will the room be correct after we move the first one
		isCorrect := true
		for j := 0; j < c.Filled[i]-1; j++ {
			if room[j] != int8(i+1) {
				isCorrect = false
				break
			}
		}

		topIdx := c.Filled[i] - 1
		topType := room[topIdx]

		// Move left
		for h := i + 1; h >= 0; h-- {
			if c.Hallway[h] != 0 {
				break
			}
			n := c.Clone()
			n.Filled[i] -= 1
			n.Correct[i] = isCorrect
			n.Hallway[h] = topType
			n.Rooms[i][topIdx] = 0
			result = append(result, State{
				Pos:    n,
				Energy: COST[topType] * countSteps(h, i, n.Depth-topIdx),
			})
		}
		// Move right
		for h := i + 2; h < 7; h++ {
			if c.Hallway[h] != 0 {
				break
			}
			n := c.Clone()
			n.Filled[i] -= 1
			n.Correct[i] = isCorrect
			n.Hallway[h] = topType
			n.Rooms[i][topIdx] = 0
			result = append(result, State{
				Pos:    n,
				Energy: COST[topType] * countSteps(h, i, n.Depth-topIdx),
			})
		}
	}
	return result
}

func (c *Cave) prn() {
	fmt.Print("#############\n#")
	fmt.Print(fmtCell(c.Hallway[0]))
	for _, cell := range c.Hallway[1:5] {
		fmt.Print(fmtCell(cell) + ".")
	}
	fmt.Print(fmtCell(c.Hallway[5]) + fmtCell(c.Hallway[6]))

	fmt.Print("#\n###")
	for i := c.Depth - 1; i >= 0; i-- {
		for _, r := range c.Rooms {
			fmt.Print(fmtCell(r[i]) + "#")
		}
		if i == c.Depth-1 {
			fmt.Print("##")
		}
		fmt.Print("\n  #")
	}
	fmt.Print("########\n   ")
	for _, v := range c.Correct {
		if v {
			fmt.Print("Y ")
		} else {
			fmt.Print("N ")
		}
	}
	fmt.Print("\n   ")
	for _, v := range c.Filled {
		fmt.Printf("%d ", v)
	}
	fmt.Println("")

}

func fmtCell(c int8) string {
	if c == 0 {
		return "."
	}
	return string('A' + rune(c-1))
}

type State struct {
	Pos    Cave
	Energy int64
}

// A PriorityQueue implements heap.Interface and holds States.
type PriorityQueue []State

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].Energy < pq[j].Energy
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(State))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func dij(start Cave) int64 {
	var q PriorityQueue
	visited := make(map[Cave]bool)

	heap.Push(&q, State{Pos: start, Energy: 0})
	for q.Len() > 0 {
		s := heap.Pop(&q).(State)
		if s.Pos.Done() {
			return s.Energy
		}
		if visited[s.Pos] {
			continue
		}
		visited[s.Pos] = true
		for _, m := range s.Pos.Moves() {
			//m.Pos.prn()
			m.Energy += s.Energy
			if !visited[m.Pos] {
				heap.Push(&q, m)
			}
		}
	}
	return 0
}

func main() {
	reader := bufio.NewReader(os.Stdin)
	_, _ = reader.ReadString('\n')
	_, _ = reader.ReadString('\n')
	top, _ := reader.ReadString('\n')
	bot, _ := reader.ReadString('\n')

	c := Cave{Depth: 2, Filled: [4]int{2, 2, 2, 2}}
	for i, ch := range top[3:10] {
		if i%2 == 0 {
			c.Rooms[i/2][1] = int8(ch - 'A' + 1)
		}
	}
	for i, ch := range bot[3:10] {
		if i%2 == 0 {
			c.Rooms[i/2][0] = int8(ch - 'A' + 1)
		}
	}
	fmt.Println(dij(c))
	c.Depth = 4
	extra := [][]int8{{4, 3, 2, 1}, {4, 2, 1, 3}}

	for i, r := range c.Rooms {
		c.Rooms[i][3] = r[1]
		c.Rooms[i][2] = extra[0][i]
		c.Rooms[i][1] = extra[1][i]
		c.Filled[i] = 4
	}
	fmt.Println(dij(c))
}
