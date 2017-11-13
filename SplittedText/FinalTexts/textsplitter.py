lines_per_file = 1
smallfile = None
with open('data2.txt') as bigfile:
    for lineno, line in enumerate(bigfile):
        if len(line) > 100 :
            if lineno % lines_per_file == 0:
                if smallfile:
                    smallfile.close()
                small_filename = 'small_file2_{}.txt'.format(lineno + lines_per_file)
                smallfile = open(small_filename, "w+")
            smallfile.write(line)
    if smallfile:
        smallfile.close()
