import itertools
import numpy as np

def partitions(n, k):
    for c in itertools.combinations(range(n+k-1), k-1):
        yield [b-a-1 for a, b in zip((-1,)+c, c+(n+k-1,))]

def generate(n ,k):
    return [p for p in partitions(n,k)]
