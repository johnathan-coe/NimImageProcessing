import sugar
import math
import sequtils

type Mask = object
    mask*: array[3, array[3, int]]
    coefficient*: float

const VERTICAL_SOBEL* = Mask(
    mask: [
        [-1, 0, 1],
        [-2, 0, 2],
        [-1, 0, 1]
    ],
    coefficient: 1.0/8
)

const HORIZONTAL_SOBEL* = Mask(
    mask: [
        [ 1,  2,  1],
        [ 0,  0,  0],
        [-1, -2, -1]
    ],
    coefficient: 1.0/8
)

const GAUSSIAN* = Mask(
    mask: [
        [ 1,  2,  1],
        [ 2,  4,  2],
        [ 1,  2,  1]
    ],
    coefficient: 1.0/16
)

# Run a mask over an image, ignore
func mask*(img: seq[seq[float]], mask: Mask): seq[seq[float]] =
    collect(newSeq):
        for y, row in img:
            if y == 0 or y == img.len - 1:
                repeat(0.0, row.len)
            else:
                collect(newSeq):
                    for x, col in row:
                        if x == 0 or x == row.len - 1:
                            0.0
                        else:
                            let applied = collect(newSeq):
                                for i in -1 .. 1:
                                    for j in -1 .. 1:
                                        float(img[y+i][x+j]) * float(mask.mask[1+i][1+j])
                            
                            sum(applied) * mask.coefficient

func edgeMagnitude*(edgesH: seq[seq[float]], edgesV: seq[seq[float]]): seq[seq[float]] =
    collect(newSeq):
        for y, row in edgesH:
            collect(newSeq):
                for x, col in row:
                    abs(col) + abs(edgesV[y][x])