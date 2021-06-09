import math
import sugar

func floatsToChars*(img: seq[seq[float]]): seq[seq[char]] = 
    collect(newSeq):
        for row in img:
            collect(newSeq):
                for col in row:
                    char(round(col))