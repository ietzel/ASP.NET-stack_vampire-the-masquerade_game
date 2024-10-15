<!DOCTYPE html>
<html>
	<head runat="server">
		<title>Vampire: The Masquerade</title>
	</head>
	<body>
		<canvas id="gC" width="650" height="600"></canvas>
		<script>
var canvas = document.getElementById('gC');
var ctx = canvas.getContext('2d');
canvas.width = 500;
canvas.height = 400;
var keys = {};
var score = 0;
var livesLeft = 10;
window.addEventListener('keydown', function (e) {
keys[e.keyCode] = true;
e.preventDefault();
});
window.addEventListener('keyup', function (e) {
delete keys[e.keyCode];
});
function Box(options) {
this.x = options.x || 10;
this.y = options.y || 10;
this.width = options.width || 40;
this.height = options.height || 50;
this.color = options.color || '#000000'
this.speed = options.speed || 5;
this.direction = options.direction || 'right';
this.gravity = options.gravity || 5;
//Physical: Athletics, Brawl, Craft, Drive, Firearms, Larceny, Melee, Stealth, Survival.
				this.strength = 1;
				this.dexterity = 1;
				this.stamina = 1;
				//Mental: Academics, Awareness, Finance, Investigation, Medicine, Occult, Politics, Science, Technology.
				this.intelligence = 1;
				this.wits = 1;
				this.resolve = 1;
				//Social: Animal Ken, Etiquette, Insight, Intimidation, Leadership, Performace, Persuasion, Streetwise, Subterfuge.
				this.charisma = 1;
				this.manipulation = 1;
				this.composure = 1;
this.collideWith = function(otherobject) {
var myleft = this.x;
var myright = this.x + (this.width);
var mytop = this.y;
var mybottom = this.y + (this.height);
var otherleft = otherobject.x;
var otherright = otherobject.x + (otherobject.width);
var othertop = otherobject.y;
var otherbottom = otherobject.y + (otherobject.height);
var collision = true;
if ((mybottom <= othertop) ||
(mytop >= otherbottom) ||
(myright <= otherleft) ||
(myleft >= otherright)) {
collision = false;
}
return collision;
}
}
var player = new Box({
x: 150,
y: 300,
width: 60,
height: 20,
color: '#44ee11',
speed: 5
});
var food = new Box({
x: Math.floor(Math.random() * (canvas.width - 25)),
y: 100,
width: 20,
height: 20,
color: '#ee3344',
gravity: 0.5,
speed: 2
});
var enemy = new Box({
x: 60,
y: 50,
width: 200,
height: 25,
color: 'rgb('+(Math.floor(Math.random()*256))+','+(Math.floor(Math.random()*256))+','+(Math.floor(Math.random()*256))+')'
});
function input(player) {
if (37 in keys) {
if (player.x - player.speed > 0) {
player.x -= player.speed;
}
player.direction = 'left';
}
if (39 in keys) {
if (player.x + player.width + player.speed < canvas.width) {
player.x += player.speed;
}
player.direction = 'right';
}
}
function drawBox(box) {
ctx.fillStyle = box.color;
ctx.fillRect(box.x, box.y, box.width, box.height);
}
function gravityBounce() {
food.y += food.gravity;
food.x += food.speed;
}
function update() {
input(player);
}
function updateScoreBoard() {
ctx.font = "24px Arial";
ctx.fillStyle = "rgb(255,0,255)";
var str = "Score = " + score;
ctx.fillText(str, 50, 380);
}
function checkBounce() {
if ((food.x <=0) || (food.x >= canvas.width - food.width)){
food.speed = food.speed * -1;
}
if (food.y <= 0){
food.gravity = food.gravity *-1;
}
if (food.y > player.y- food.height+10){
food.x = 200;
food.y = 200;
food.gravity = 0;
food.speed = 0;
}
draw();
}
function draw() {
if (player.collideWith(food)) {
score += 1;
livesLeft -=1;
ctx.clearRect(0, 0, canvas.width, canvas.height);
food.gravity = food.gravity * -1;
gravityBounce();
drawBox(player);
drawBox(food);
drawBox(enemy);
updateScoreBoard();
} else if (food.collideWith(enemy)) {
score += 1;
livesLeft -= 1;
ctx.clearRect(0, 0, canvas.width, canvas.height);
food.gravity = food.gravity * -1;
gravityBounce();
drawBox(player);
drawBox(food);
drawBox(enemy);
updateScoreBoard();
} else {
ctx.clearRect(0, 0, canvas.width, canvas.height);
gravityBounce();
drawBox(player);
drawBox(food);
drawBox(enemy);
updateScoreBoard();
}
}
function loop() {
update();
checkBounce();
window.requestAnimationFrame(loop);
}
loop(); 
		</script>
	</body>
</html>
