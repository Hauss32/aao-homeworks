document.addEventListener("DOMContentLoaded", function(){
    const canvas = document.getElementById('mycanvas');
    const ctx = canvas.getContext('2d');

    // Phase II: Draw a Rectangle
    ctx.fillStyle = 'darkblue';
    ctx.fillRect(0, 0, 300, 150);

    ctx.fillStyle = 'darkgreen';
    ctx.fillRect(50, 25, 200, 100);

    // Phase III: Draw a Circle
    ctx.strokeStyle = 'darkred';
    ctx.lineWidth = 15;
    ctx.beginPath();
    ctx.arc(150, 75, 60, 0, (2 * Math.PI));
    ctx.stroke();
    ctx.fillStyle = 'gold';
    ctx.fill();

    // Phase IV: Draw your Favorite Shape!
    ctx.fillStyle = 'purple';
    ctx.beginPath();
    ctx.moveTo(120, 75);
    ctx.bezierCurveTo(120, 50, 155, 50, 150, 75);
    ctx.bezierCurveTo(145, 50, 180, 50, 180, 75);
    ctx.bezierCurveTo(180, 90, 150, 110, 150, 105);
    ctx.bezierCurveTo(150, 110, 120, 90, 120, 75);
    // ctx.lineTo(150, 105);
    // ctx.closePath();
    ctx.fill();
});

