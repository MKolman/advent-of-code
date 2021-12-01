n=[int(l)for l in open(0)]
print(sum(i<j for i,j in zip(n,n[1:])),sum(i<j for i,j in zip(n,n[3:])))
