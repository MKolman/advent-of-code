#include<iostream>
#include<stdio.h>
#include<array>
#include<vector>
#include<algorithm>

class vec3 : public std::array<int, 3> {};

class cubes;
class cube : public std::array<vec3, 2> {
public:
    cubes operator-(const cube&) const;
    bool operator&(const cube& o) const;
    int64_t size() const;
};

class cubes : public std::vector<cube> {
public:
    cubes operator-(const cube& o) {
        cubes result;
        for (const cube& c : (*this)) {
            cubes tmp = c - o;
            result.insert(result.end(), tmp.begin(), tmp.end());
        }
        return result;
    }
};

int64_t cube::size() const {
    int64_t result = 1;
    for (int i = 0; i < 3; i++) {
        result *= (*this)[1][i] - (*this)[0][i] + 1;
    }
    return result;
}

bool cube::operator&(const cube& o) const {
    for (int i = 0; i < 3; i++) {
        if ((*this)[0][i] > o[1][i] || (*this)[1][i] < o[0][i]) return false;
    }
    return true;
}

cubes cube::operator-(const cube& o) const {
    cubes result;
    result.push_back(*this);
    for (int i = 0; i < 3; i++) {
        cubes tmp;
        for (const cube& c : result) {
            if (!(c&o)) {
                tmp.push_back(c);
                continue;
            }
            // c is to the left of o
            if (c[0][i] < o[0][i]) {
                cube left = c;
                left[1][i] = std::min(left[1][i], o[0][i]-1);
                tmp.push_back(left);
            }
            // c is to the right of o
            if (c[1][i] > o[1][i]) {
                cube right = c;
                right[0][i] = std::max(right[0][i], o[1][i]+1);
                tmp.push_back(right);
            }
            // c overlaps o - only valid for x in y coordinates
            if (i < 2 && c[0][i] <= o[1][i] && c[1][i] >= o[0][i]) {
                cube mid = c;
                mid[0][i] = std::max(c[0][i], o[0][i]);
                mid[1][i] = std::min(c[1][i], o[1][i]);
                tmp.push_back(mid);
            }
        }
        result = tmp;
    }
    return result;
}

class action {
public:
    bool turn_on;
    cube space;
    action(bool on, cube sp): turn_on(on), space(sp) {}
};

std::ostream &operator<<(std::ostream &os, const cube &c) { 
    os << "[";
    for (const vec3 &v : c) {
        os << "<";
        bool first = true;
        for (const int i : v) {
            if (!first) os << ",";
            os << i;
            first = false;
        }
        os << ">";
    }
    return os << "]";
}

std::ostream &operator<<(std::ostream &os, const action &m) { 
    return os << (m.turn_on ? 1 : 0) << ": " << m.space;
}

template<class T>
std::ostream &operator<<(std::ostream &os, const std::vector<T> &m) { 
    if (m.size() == 0) return os << "{}";
    if (m.size() == 1) return os << "{" << m[0] << "}";
    os << "{\n";
    for (const T &v : m) {
        os << "  " << v << ",\n";
    }
    return os << "}";
}

std::vector<action> read_data() {
    int x, X, y, Y, z, Z;
    char on[3];
    std::vector<action> result;
    while (scanf("%3s x=%d..%d,y=%d..%d,z=%d..%d\n", on, &x, &X, &y, &Y, &z, &Z) != -1) {
        result.emplace_back(on[1] == 'n', cube{vec3{x, y, z}, vec3{X, Y, Z}});
    }
    return result;
}

int count50(const std::vector<action>& data) {
    std::vector<bool> space(102*102*102);
    for (const auto& a : data) {
        for (int x = std::max(0, 50+a.space[0][0]); x <= std::min(101, 50+a.space[1][0]); x++) {
            for (int y = std::max(0, 50+a.space[0][1]); y <= std::min(101, 50+a.space[1][1]); y++) {
                for (int z = std::max(0, 50+a.space[0][2]); z <= std::min(101, 50+a.space[1][2]); z++) {
                    space[x+y*101+z*101*101] = a.turn_on;
                }
            }
        }
    }
    int cnt = 0;
    for (const bool v : space) cnt += v;
    return cnt;
}

int64_t count_all(const std::vector<action>& data) {
    cubes space;
    for (const action& a : data) {
        space = space - a.space;
        if (a.turn_on) space.push_back(a.space);
    }

    int64_t result = 0;
    for (const cube& c : space) {
        result += c.size();
    }
    return result;
}


int main() {
    auto data = read_data();
    std::cout << count50(data) << "\n";
    std::cout << count_all(data) << "\n";
}
