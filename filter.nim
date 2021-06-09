import sugar

func greyscale*(img: seq[seq[array[3, float]]]): seq[seq[float]] =
    ## Convert an RGB image to greyscale
    ## Formula: `0.299*r + 0.587*g + 0.114*b`
    
    # Return a new seq with grey values
    collect(newSeq):
        for row in img:
            collect(newSeq):
                for col in row:
                    0.299*float(col[0]) + 0.587*float(col[1]) + 0.114*float(col[2])

func stretch*(img: seq[seq[float]]): seq[seq[float]] =
    ## Perform contrast stretching on the image
    ## The minimum and maximum grey value will become 0 and 255 respectively
    
    # Flatten the 2D sequence
    let flat = collect(newSeq):
        for row in img:
            for col in row:
                col

    # Get the lowest and highest grey value
    let fLow = min(flat)
    let fHigh = max(flat)

    # Get the required gain
    let gain = 255.0/(fHigh-fLow)

    # Return a new seq with scaled grey values
    collect(newSeq):
        for row in img:
            collect(newSeq):
                for col in row:
                    (col-fLow) * gain