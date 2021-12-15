function readMap()
    local result = {}
    while true do
        local line = io.read("*line")
        if line == nil then
            break
        end
        local nums = {}
        for i = 1, #line do
            local c = line:sub(i,i)
            table.insert(nums, tonumber(c))
        end
        table.insert(result, nums)
    end
    return result
end

function join(a, b, c)
    local nums = {}
    table.insert(nums, a)
    table.insert(nums, b)
    table.insert(nums, c)
    return nums
end
function unjoin(s)
    return s[1], s[2], s[3]
end

function key(x, y)
    return string.format("%d/%d", x, y)
end
function findPath(caves)
    local visited = {}
    local q = PriorityQueue()
    q:put(join(1, 1, -caves[1][1]), 0)
    while not q:empty() do
        local i, j, cost = unjoin(q:pop())
        cost = cost + caves[i][j]
        if i == #caves and j == #caves[i] then
            return cost
        end
        if not visited[key(i, j)] then
            visited[key(i, j)] = true
            if i > 1 and not visited[key(i-1, j)] then
                q:put(join(i-1, j, cost), cost)
            end
            if i < #caves and not visited[key(i+1, j)] then
                q:put(join(i+1, j, cost), cost)
            end
            if j > 1 and not visited[key(i, j-1)] then
                q:put(join(i, j-1, cost), cost)
            end
            if j < #caves[i] and not visited[key(i, j+1)] then
                q:put(join(i, j+1, cost), cost)
            end
        end
    end
    return -1
end

function extend(caves)
    n = #caves
    m = #caves[1]
    for i = 1, 4 do
        for j = 1, n do
            local line = {}
            for k = 1, #caves[j] do
                local x = caves[j][k]+i
                if x > 9 then
                    x = x - 9
                end
                table.insert(line, x)
            end
            table.insert(caves, line)
        end
        for j = 1, m do
            for k = 1, #caves do
                local x = caves[k][j]+i
                if x > 9 then
                    x = x - 9
                end
                table.insert(caves[k], x)
            end
        end
    end
    return caves
end

function main()
    caves = readMap()
    print(findPath(caves))
    caves = extend(caves)
    print(findPath(caves))
end



-- https://gist.github.com/LukeMS/89dc587abd786f92d60886f4977b1953 --

local floor = math.floor


PriorityQueue = {}
PriorityQueue.__index = PriorityQueue

setmetatable(
    PriorityQueue,
    {
        __call = function (self)
            setmetatable({}, self)
            self:initialize()
            return self
        end
    }
)


function PriorityQueue:initialize()
    --[[  Initialization.

    Example:
        PriorityQueue = require("priority_queue")
        pq = PriorityQueue()
    ]]--
    self.heap = {}
    self.current_size = 0
end

function PriorityQueue:empty()
    return self.current_size == 0
end

function PriorityQueue:size()
    return self.current_size
end

function PriorityQueue:swim()
    -- Swim up on the tree and fix the order heap property.
    local heap = self.heap
    local floor = floor
    local i = self.current_size

    while floor(i / 2) > 0 do
        local half = floor(i / 2)
        if heap[i][2] < heap[half][2] then
            heap[i], heap[half] = heap[half], heap[i]
        end
        i = half
    end
end

function PriorityQueue:put(v, p)
    --[[ Put an item on the queue.

    Args:
        v: the item to be stored
        p(number): the priority of the item
    ]]--
    --

    self.heap[self.current_size + 1] = {v, p}
    self.current_size = self.current_size + 1
    self:swim()
end

function PriorityQueue:sink()
    -- Sink down on the tree and fix the order heap property.
    local size = self.current_size
    local heap = self.heap
    local i = 1

    while (i * 2) <= size do
        local mc = self:min_child(i)
        if heap[i][2] > heap[mc][2] then
            heap[i], heap[mc] = heap[mc], heap[i]
        end
        i = mc
    end
end

function PriorityQueue:min_child(i)
    if (i * 2) + 1 > self.current_size then
        return i * 2
    else
        if self.heap[i * 2][2] < self.heap[i * 2 + 1][2] then
            return i * 2
        else
            return i * 2 + 1
        end
    end
end

function PriorityQueue:pop()
    -- Remove and return the top priority item
    local heap = self.heap
    local retval = heap[1][1]
    heap[1] = heap[self.current_size]
    heap[self.current_size] = nil
    self.current_size = self.current_size - 1
    self:sink()
    return retval
end

main()
