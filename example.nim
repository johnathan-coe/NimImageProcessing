import nimPNG
import sugar
import filter
import mask
import convert

# Load a sample image 
let png = loadPNG24("./samples/qr.png")

# Convert image to a 2d seq of RGB arrays
let img = collect(newSeq):
    for y in 0 ..< png.height:
        collect(newSeq):
            for x in 0 ..< png.width:
                let offset = y*png.width*3 + x*3
                [float(png.data[offset]),
                 float(png.data[offset+1]),
                 float(png.data[offset+2])]
            
let bw = filter.greyscale(img)
let vertEdges = mask(bw, VERTICAL_SOBEL)
let horizEdges = mask(bw, HORIZONTAL_SOBEL)
let edgeMag = edgeMagnitude(horizEdges, vertEdges)
let stretched = stretch(edgeMag)
var gauss = stretched
for i in 1 .. 12:
    gauss = mask(gauss, GAUSSIAN)

var rgb_out = newStringOfCap(png.width*png.height*3)
for row in floatsToChars(gauss):
    for col in row:
        rgb_out.add(col)
        rgb_out.add(col)
        rgb_out.add(col)

discard savePNG24("out.png", rgb_out, png.width, png.height)