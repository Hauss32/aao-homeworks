const Util = {
    inherits: function inherits(subClass, superClass) {
        subClass.prototype = Object.create(superClass.prototype);
        subClass.prototype.constuctor = subClass;
    }
}

module.exports = Util;