<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Heart</title>

<style>
body{
margin:0;
background:black;
overflow:hidden;
font-family:sans-serif;
}

canvas{
display:block;
}

.text{
position:absolute;
bottom:40px;
width:100%;
text-align:center;
color:white;
font-size:38px;
text-shadow:0 0 15px red,0 0 30px red;
}
</style>
</head>

<body>

<canvas id="c"></canvas>
<div class="text">Нима бўлсаям сани севаман </div>

<script>

const canvas=document.getElementById("c")
const ctx=canvas.getContext("2d")

canvas.width=window.innerWidth
canvas.height=window.innerHeight

function heart(t){
return{
x:16*Math.pow(Math.sin(t),3),
y:-(13*Math.cos(t)-5*Math.cos(2*t)-2*Math.cos(3*t)-Math.cos(4*t))
}
}

let particles=[]
let comets=[]

for(let i=0;i<2200;i++){

let t=Math.random()*Math.PI*2
let r=Math.random()

let h=heart(t)

particles.push({
x:canvas.width/2+h.x*20*r,
y:canvas.height/2+h.y*20*r,
baseX:canvas.width/2+h.x*20*r,
baseY:canvas.height/2+h.y*20*r,
size:Math.random()*1.5+0.5
})

}

function spawnComet(){

let side=Math.floor(Math.random()*4)
let x,y,vx,vy

if(side==0){ // top
x=Math.random()*canvas.width
y=-20
vx=(Math.random()-0.5)*6
vy=6+Math.random()*4
}

if(side==1){ // bottom
x=Math.random()*canvas.width
y=canvas.height+20
vx=(Math.random()-0.5)*6
vy=-6-Math.random()*4
}

if(side==2){ // left
x=-20
y=Math.random()*canvas.height
vx=6+Math.random()*4
vy=(Math.random()-0.5)*6
}

if(side==3){ // right
x=canvas.width+20
y=Math.random()*canvas.height
vx=-6-Math.random()*4
vy=(Math.random()-0.5)*6
}

comets.push({
x,y,vx,vy,trail:[]
})

}

setInterval(spawnComet,700)

function animate(){

ctx.fillStyle="rgba(0,0,0,0.25)"
ctx.fillRect(0,0,canvas.width,canvas.height)

ctx.fillStyle="red"

particles.forEach(p=>{

p.x+=(p.baseX-p.x)*0.08
p.y+=(p.baseY-p.y)*0.08

ctx.beginPath()
ctx.arc(p.x,p.y,p.size,0,Math.PI*2)
ctx.fill()

})

comets.forEach(c=>{

c.trail.push({x:c.x,y:c.y})
if(c.trail.length>25)c.trail.shift()

c.x+=c.vx
c.y+=c.vy

ctx.strokeStyle="white"
ctx.beginPath()

for(let i=0;i<c.trail.length;i++){

let t=c.trail[i]

if(i==0)ctx.moveTo(t.x,t.y)
else ctx.lineTo(t.x,t.y)

}

ctx.stroke()

particles.forEach(p=>{

let dx=p.x-c.x
let dy=p.y-c.y
let dist=Math.sqrt(dx*dx+dy*dy)

if(dist<70){

p.x+=dx*0.5
p.y+=dy*0.5

}

})

})

comets=comets.filter(c=>
c.x>-100&&c.x<canvas.width+100&&
c.y>-100&&c.y<canvas.height+100
)

requestAnimationFrame(animate)

}

animate()

</script>

</body>
</html>
