import sugar

func greyscale*(img: seq[seq[array[3, float]]]): seq[seq[float]] =
    collect(newSeq):
        for row in img:
            collect(newSeq):
                for col in row:
                    0.299*float(col[0]) + 0.587*float(col[1]) + 0.114*float(col[2])

func stretch*(img: seq[seq[float]]): seq[seq[float]] =
    let flat = collect(newSeq):
        for row in img:
            for col in row:
                col

    let fLow = min(flat)
    let fHigh = max(flat)
    let gain = 255.0/(fHigh-fLow)

    collect(newSeq):
        for row in img:
            collect(newSeq):
                for col in row:
                    (col-fLow) * gain