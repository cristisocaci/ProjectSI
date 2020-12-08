from itertools import product

def generate(n,k):
    return [list(i) for i in product(range(n+1), repeat=k) if sum(i)==n]


