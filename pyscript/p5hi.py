import js

p5js = js.window

def setup():
    p5js.createCanvas(400, 400)
    p5js.background(220)
    p5js.ellipse(50, 50, 80, 80)

setup()