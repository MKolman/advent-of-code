import Foundation

typealias Graph = Dictionary<String, [String]>

func readGraph() -> Graph {
    var graph: Graph = [:]
    while let line = readLine() {
        let caves = line.components(separatedBy: "-")
        let (a, b) = (caves[0], caves[1])
        if graph[a] != nil {
            graph[a]?.append(b)
        } else {
            graph[a] = [b]
        }
        if graph[b] != nil {
            graph[b]?.append(a)
        } else {
            graph[b] = [a]
        }
    }
    return graph
}

func countPaths(
    graph: inout Graph,
    visited: Set<String> = [],
    start: String = "start",
    doubled: Bool = true
) -> Int {
    if start == "end" {
        return 1
    }
    var visited = visited
    if start == start.lowercased() {
        visited.insert(start)
    }
    
    var result = 0
    for conn in graph[start]! {
        if conn == "start" || (doubled && visited.contains(conn)) { continue }
        result += countPaths(
            graph: &graph,
            visited: visited,
            start: conn,
            doubled: doubled || visited.contains(conn)
        )
    }
    return result
}

var graph = readGraph()
print(countPaths(graph: &graph))
print(countPaths(graph: &graph, doubled: false))
