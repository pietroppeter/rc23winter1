# from proceso readme
from proceso import Sketch
import random
import math


p5 = Sketch()

objs = []
colors = ['#084b83', '#42bfdd', '#ff7700', '#ed254e', '#f9dc5c', '#5b1865','#5688c7']

def setup():
    p5.create_canvas(900, 900)
    p5.rect_mode(p5.CENTER)
    side = p5.width*0.8
    c = 12
    w = side / c
    for i in range(c):
        for j in range(c):
            x = i * w + (w / 2) + (p5.width - side)/2
            y = j * w + (w / 2) + (p5.width - side)/2
            objs.append(Obj(x, y, w * 0.5))

def draw():
    p5.background(255)
    for o in objs:
        o.run()

def ease_in_out_circ(x):
    if x < 0.5:
        return (1 - math.sqrt(1 - math.pow(2 * x, 2))) / 2
    else:
        return (math.sqrt(1 - math.pow(-2 * x + 2, 2)) + 1) / 2


class Obj:
     
    def __init__(self, x, y, w):
        self.x = x
        self.y = y
        self.w = w
        self.cw = self.w
        self.t = -p5.dist(p5.width/2, p5.height/2, self.x, self.y)/10
        self.t0 = -20
        self.t1 = 80
        self.t2 = self.t1 + 20
        self.t3 = self.t2 + 80
        self.init()

    def show(self):
        ww = self.w - self.cw
        p5.push()
        p5.translate(self.x, self.y)
        p5.no_stroke()
        p5.fill(self.col1)
        p5.circle(ww / 2, -ww / 2, self.w * 0.75)
        p5.fill(self.col2)
        p5.circle(-ww / 2, ww / 2, self.w * 0.75)
        p5.fill('#ffffff')
        p5.circle(0, 0, self.cw+1)
        p5.pop()

    def move(self):
        if (0 < self.t and self.t < self.t1):
            n = p5.norm(self.t, 0, self.t1 - 1)
            self.cw = p5.lerp(self.w, 0, ease_in_out_circ(n))
        elif (self.t2 < self.t and self.t < self.t3):
            n = p5.norm(self.t, self.t2, self.t3 - 1)
            self.cw = p5.lerp(0, self.w, ease_in_out_circ(n))
        if (self.t > self.t3):
            self.init()
        self.t += 1

    def init(self):
        self.col1 = self.col2 = '🐲'
        while (self.col1 == self.col2):
            self.col1 = random.choice(colors)
            self.col2 = random.choice(colors)
        self.t = self.t0

    def run(self):
        self.show()
        self.move()

p5.run_sketch(setup=setup, draw=draw)

# original code from: https://openprocessing.org/sketch/2135904
"""
let objs = [];
let colors = ['#084b83', '#42bfdd', '#ff7700', '#ed254e', '#f9dc5c', '#5b1865','#5688c7'];

function setup() {
    createCanvas(900, 900);
    rectMode(CENTER);
    let side = width*0.8;
    let c = 12;
    let w = side / c;
    for (let i = 0; i < c; i++) {
        for (let j = 0; j < c; j++) {
            let x = i * w + (w / 2) + (width - side)/2;
            let y = j * w + (w / 2) + (width - side)/2;
            objs.push(new OBJ(x, y, w * 0.5));
        }
    }
}

function draw() {
    background(255);
    for (let i of objs) {
        i.run();
    }
}

function easeInOutCirc(x) {
    return x < 0.5
        ? (1 - Math.sqrt(1 - Math.pow(2 * x, 2))) / 2
        : (Math.sqrt(1 - Math.pow(-2 * x + 2, 2)) + 1) / 2;
}

class OBJ {
    constructor(x, y, w) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.cw = this.w;
        this.init();
        this.t = -dist(width/2, height/2, this.x, this.y)/10;
        this.t0 = -20;
        this.t1 = 80;
        this.t2 = this.t1 + 20;
        this.t3 = this.t2 + 80;
    }

    show() {
        let ww = this.w - this.cw;
        push();
        translate(this.x, this.y);
        noStroke();
        fill(this.col1);
        circle(ww / 2, -ww / 2, this.w * 0.75);
        fill(this.col2);
        circle(-ww / 2, ww / 2, this.w * 0.75);
        fill('#ffffff');
        circle(0, 0, this.cw+1);
        pop();
    }

    move() {
        if (0 < this.t && this.t < this.t1) {
            let n = norm(this.t, 0, this.t1 - 1);
            this.cw = lerp(this.w, 0, easeInOutCirc(n));
        }
        else if (this.t2 < this.t && this.t < this.t3) {
            let n = norm(this.t, this.t2, this.t3 - 1);
            this.cw = lerp(0, this.w, easeInOutCirc(n));
        }
        if (this.t > this.t3) {
            this.init();
        }
        this.t++;
    }

    init(){
        this.col1 = this.col2 = '🐲'
        while (this.col1 == this.col2) {
            this.col1 = random(colors);
            this.col2 = random(colors);
        }
        this.t = this.t0;
    }

    run() {
        this.show();
        this.move();
    }
}
"""