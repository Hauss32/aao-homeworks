const Util = {
    inherits: function inherits(subClass, superClass) {
        subClass.prototype = Object.create(superClass.prototype);
        subClass.prototype.constuctor = subClass;
    },

    randomVec: function randomVec(length) {
        const deg = 2 * Math.PI * Math.random();
        return Util.scale([Math.sin(deg), Math.cos(deg)], length);
    },

    // Scale the length of a vector by the given amount.
    scale: function scale(vec, m) {
        return [vec[0] * m, vec[1] * m];
    },

    clearCanv: function clearCanv(ctx) {
        ctx.clearRect(0, 0, window.canv.width, window.canv.height);
    }
}

module.exports = Util;