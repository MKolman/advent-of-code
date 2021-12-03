*n,=map(int,open(0))
f=lambda x:sum(i<j for i,j in zip(n,n[x:]))
print(f(1),f(3))
