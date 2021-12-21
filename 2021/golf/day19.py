from time import time


class Vec(tuple):
    def __new__ (cls, x, y, z):
        return super(Vec, cls).__new__(cls, (x, y, z))

    def __add__(self, o):
        return Vec(self[0] + o[0], self[1] + o[1], self[2] + o[2])

    def __sub__(self, o):
        return Vec(self[0] - o[0], self[1] - o[1], self[2] - o[2])

    def __abs__(self):
        return sum(map(abs, self))

    def roll(self):
        return Vec(self[0], self[2], -self[1])

    def turn(self):
        return Vec(-self[1], self[0], self[2])

    def rot(self, pos, start=0):
        result = self
        for i in range(max(0, start), pos):
            if i % 4:
                result = result.turn()
            else:
                result = result.roll()
            if i == 11:
                result = result.roll().turn().roll()
        return result

class Probe:
    def __init__(self):
        self.points = []
        self.position = Vec(0, 0, 0)
        line = input()
        while line != '':
            self.points.append(Vec(*map(int, line.split(','))))
            try:
                line = input()
            except EOFError:
                break

        self.cached_points = [self.points]
        self.cache = []
        self.fill_cache()
        #self.prefill_cache()

    def prefill_cache(self):
        self.all_cached = set()
        points = self.points
        for rot in range(24):
            points = [v.rot(rot, rot-1) for v in points]
            tmp = []
            for center in points:
                tmp.append(set(p - center for p in points))
                self.all_cached |= tmp[-1]
            self.cache.append(tmp)

    def fill_cache(self):
        for i in range(len(self.cache), len(self.cached_points)):
            tmp = []
            for center in self.cached_points[i]:
                tmp.append(set(p - center for p in self.cached_points[i]))
            self.cache.append(tmp)

    def get_rot(self, rot):
        if len(self.cache) <= rot:
            for i in range(len(self.cached_points), rot+1):
                self.cached_points.append([v.rot(i, i-1) for v in self.cached_points[-1]])
                self.fill_cache()
        return self.cache[rot]


    def align(self, exp):
        for c, centered in enumerate(self.cache[0][:-10]):
            #if len(centered & exp.all_cached) < 12:
            #    continue
            #for r, rotated_exp in enumerate(exp.cache):
            for r in range(24):
                for x, centered_exp in enumerate(exp.get_rot(r)):
                    if len(centered_exp & centered) >= 12:
                        return c, r, x
        return None


def main():
    start = time()
    probes = []
    l = input()
    while l.startswith('---'):
        probes.append(Probe())
        try:
            line = input()
        except EOFError:
            break
    print(f"Read all data in {time() - start}s")
    ordered = [0]
    unordered = set(range(1, len(probes)))
    tried = set()
    while unordered:
        for un_idx in list(unordered):
            for o_idx in ordered:
                if (o_idx, un_idx) in tried:
                    continue
                data = probes[o_idx].align(probes[un_idx])
                if data is None:
                    tried.add((o_idx, un_idx))
                    continue
                c, r, x = data
                probes[un_idx].cache[0] = probes[un_idx].cache[r]
                probes[un_idx].points = [p.rot(r) for p in probes[un_idx].points]
                move = probes[un_idx].points[x] - probes[o_idx].points[c]
                probes[un_idx].position = move
                probes[un_idx].points = [p-move for p in probes[un_idx].points]
                unordered.remove(un_idx)
                ordered.append(un_idx)
                break

    print(len(set(sum([p.points for p in probes], []))))
    print(max(abs(p.position - q.position) for p in probes for q in probes))
    print(f"Done in {time()-start}s")

if __name__ == '__main__':
    main()

