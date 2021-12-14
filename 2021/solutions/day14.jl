function readMap()
    map = Dict()
    while !eof(stdin)
        line = split(readline(stdin), " -> ")
        map[line[1]] = line[2][1]
    end
    return map
end

function rec(left, right, d)
    memokey = (left, right, d)
    if memokey in keys(memo)
        return memo[memokey]
    end
    k = left*right
    if d == 0 || k ∉ keys(map)
        if left == right
            return Dict{Char, Int64}(left => 2)
        else
            return Dict{Char, Int64}(left => 1, right => 1)
        end
    end
    mid = map[k]
    l = rec(left, mid, d-1)
    r = rec(mid, right, d-1)
    result = merge(+, l, r)
    result[mid] -= 1
    memo[memokey] = result
    return result
end

function solve(p, n)
    cnt = Dict{Char, Int64}(p[1] => 1)
    for i in 2:length(p)
        cnt = merge(+, cnt, rec(p[i-1], p[i], n))
        cnt[p[i-1]] -= 1
    end
    return maximum(values(cnt)) - minimum(values(cnt))
end

poly = readline()
readline()
map = readMap()
memo = Dict{Tuple{Char, Char, Int64}, Dict{Char, Int64}}()
println(solve(poly, 10))
println(solve(poly, 40))
