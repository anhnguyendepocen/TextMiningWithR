import csv
import csv
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
stop_words=set(stopwords.words("english"))
f=open("data.txt","w+")
f1=open("data2.txt","w+")
count=0
with open('ActualDataCSV.csv') as csvfile :
    csvReader=csv.reader(csvfile)
    for row in csvReader :
        count+=1
        comment=" ".join(row[3:])
        wl=word_tokenize(comment)
        fcomm=""
        for words in wl :
           if words not in stop_words :
               fcomm+=words+" "
        if count>25000 :
            f1.write(fcomm+'\n')
        else :
            f.write(fcomm+'\n')
f.close()
f1.close()
