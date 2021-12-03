l=list(open(0))
m=lambda l:''.join('0'if sum(w[i]>'0'for w in l)<len(l)/2else'1'for i in range(12))
f=lambda l,c,i=0:int(l[0],2)if 2>len(l)else f([w for w in l if(w[i]==m(l)[i])^c],c,i+1)
print((4095^int(m(l),2))*int(m(l),2),f(l,0)*f(l,1))


