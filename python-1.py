a = {"abc":{"def":{"ghi":{"jkl":{"mno":{"pqr":{"stu":{"vwx":{"yz":"you are finally here !!!"}}}}}}}}}

d = {}
loop = True
while loop:
    for i in a:
        if i == 'yz':
            loop = False
        d[i] = []
        a = a[i]

for i in d:
    pos = list(d.keys())
    d[i] = pos[pos.index(i) + 1:]
print(d)
