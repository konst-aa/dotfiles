# stub from https://codeforces.com/blog/entry/71884
import sys

from functools import reduce

input = sys.stdin.readline

############ ---- Input Functions ---- ############
def inp():
    return int(input())


def inlt():
    return list(map(int, input().split()))


def insr():
    s = input()
    return list(s[: len(s) - 1])


def invr():
    return map(int, input().split())


############ ---- Solution ---- ############
def solve():
    cases = inp()
    for c in range(cases):
        pass


solve()
