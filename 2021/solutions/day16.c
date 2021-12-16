#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

#define int long long

const int SIZE = 10000;

bool inp[10000];
int start;
int version_sum;

int parsePacket();

int readPackets() {
    int size = 0;
    char c[2] = "\0";
    scanf("%c", &c[0]);
    while (c[0] != EOF && c[0] != '\n') {
        int n = strtol(c, NULL, 16);
        inp[size++] = n&8;
        inp[size++] = n&4;
        inp[size++] = n&2;
        inp[size++] = n&1;
        scanf("%c", &c[0]);
    }
    return size;
}

int parseNum(int start, int len) {
    int result = 0;
    for (int i = start; i < start+len; i++) {
        result *= 2;
        result += inp[i];
    }
    return result;
}

int parseLiteral() {
    int result = 0;
    while (inp[start] == 1) {
        result += parseNum(start+1, 4);
        result *= 16;
        start += 5;
    }
    result += parseNum(start+1, 4);
    start += 5;
    return result;
}

int operate(int type, int* vals, int vals_size) {
    int result = vals[0];
    for (int i = 1; i < vals_size; i++) {
        switch (type) {
            case 0:
                result += vals[i];
                break;
            case 1:
                result *= vals[i];
                break;
            case 2:
                result = vals[i] < result ? vals[i] : result;
                break;
            case 3:
                result = vals[i] > result ? vals[i] : result;
                break;
            case 5:
                result = result > vals[i];
                break;
            case 6:
                result = result < vals[i];
                break;
            case 7:
                result = result == vals[i];
                break;
        }
    }
    return result;
}

int parseOperator(int type) {
    int lent = inp[start];
    start++;
    if (lent) {
        int num_subpackets = parseNum(start, 11);
        start += 11;
        int vals[num_subpackets];
        for (int p = 0; p < num_subpackets; p++) {
            vals[p] = parsePacket(start);
        }
        return operate(type, vals, num_subpackets);
    } else {
        int bit_size = parseNum(start, 15);
        start += 15;
        int packet_end = start + bit_size;
        int vals[100];
        int num_subpackets = 0;
        while (start < packet_end) {
            vals[num_subpackets++] = parsePacket(start);
        }
        return operate(type, vals, num_subpackets);
    }
}

int parsePacket() {
    int version = parseNum(start, 3);
    version_sum += version;
    int type = parseNum(start+3, 3);
    start += 6;

    int val = 0;
    if (type == 4) {
        val = parseLiteral();
    } else {
        val = parseOperator(type);
    }
    return val;
}

int main() {
    version_sum = 0;
    start = 0;
    int size = readPackets();
    int part2 = parsePacket();
    printf("%d\n", version_sum);
    printf("%lld\n", part2);
    return 0;
}
