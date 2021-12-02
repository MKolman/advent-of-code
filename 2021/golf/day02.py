a=x=0
exec(open(0).read().replace('forward','x+=(1j+a)*').replace('up','a-=').replace('down','a+='))
print(int(x.imag*a),int(x.imag*x.real))
