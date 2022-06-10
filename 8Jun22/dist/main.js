/*
 * ATTENTION: The "eval" devtool has been used (maybe by default in mode: "development").
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "./src/asteroid.js":
/*!*************************!*\
  !*** ./src/asteroid.js ***!
  \*************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Util = __webpack_require__(/*! ./utils */ \"./src/utils.js\");\nconst MovingObject = __webpack_require__(/*! ./moving_object */ \"./src/moving_object.js\");\nconst Ship = __webpack_require__(/*! ./ship */ \"./src/ship.js\");\n\nfunction Asteroid(options) {\n    MovingObject.call(this, {\n        radius: Asteroid.RADIUS,\n        color: Asteroid.COLOR,\n        game: options.game,\n        pos: options.pos\n    });\n\n    this.vel = Util.randomVec(1);\n}\n\nAsteroid.RADIUS = 20;\nAsteroid.COLOR = 'rgba(95, 74, 61, .95)';\n\nUtil.inherits(Asteroid, MovingObject);\n\nAsteroid.prototype.collideWith = function (otherObj) {\n    if (otherObj instanceof Ship) {\n        otherObj.relocate();\n    }\n}\n\n\nmodule.exports = Asteroid;\n\n//# sourceURL=webpack:///./src/asteroid.js?");

/***/ }),

/***/ "./src/game.js":
/*!*********************!*\
  !*** ./src/game.js ***!
  \*********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Asteroid = __webpack_require__(/*! ./asteroid */ \"./src/asteroid.js\");\nconst Ship = __webpack_require__(/*! ./ship */ \"./src/ship.js\");\nconst Util = __webpack_require__(/*! ./utils */ \"./src/utils.js\");\n\nfunction Game(ctx) {\n    this.asteroids = [];\n    this.ship = new Ship( { game: this, pos: this.randomPos() } );\n    this.ctx = ctx;\n\n    this.addAsteroids();\n}\n\nGame.DIM_X = 800;\nGame.DIM_Y = 500;\nGame.NUM_ASTEROIDS = 5;\n\nGame.prototype.randomPos = function () {\n    const randX = Math.floor( Math.random() * Game.DIM_X);\n    const randY = Math.floor( Math.random() * Game.DIM_Y);\n\n    return [randX, randY];\n}\n\nGame.prototype.addAsteroids = function () {\n    for(let i = 0; i < Game.NUM_ASTEROIDS; i++) {\n        let asteroid = new Asteroid( { pos: this.randomPos(), game: this } );\n        this.asteroids.push(asteroid);\n    }\n}\n\nGame.prototype.allObjects = function () {\n    return this.asteroids.concat(this.ship);\n}\n\nGame.prototype.draw = function () {\n    Util.clearCanv(this.ctx);\n\n    this.allObjects().forEach( obj => obj.draw(this.ctx) );\n}\n\nGame.prototype.moveObjects = function () {\n    this.allObjects().forEach( obj => obj.move() );\n}\n\nGame.prototype.wrap = function (pos) {\n    const [currX, currY] = pos;\n    const maxX = Game.DIM_X;\n    const maxY = Game.DIM_Y;\n    const newPos = [];\n\n    if(currX < 0 || currX > maxX){\n        (currX < 0) ? newPos.push(currX + maxX) : newPos.push(currX - maxX);\n    } else {\n        newPos.push(currX);\n    }\n\n    if (currY < 0 || currY > maxY) {\n        (currY < 0) ? newPos.push(currY + maxY) : newPos.push(currY - maxY);\n    } else {\n        newPos.push(currY);\n    }\n\n    return newPos;\n}\n\nGame.prototype.checkCollisions = function () {\n    const allObjects = this.allObjects();\n    for (let i = 0; i < allObjects.length; i++) {\n        const obj = allObjects[i];\n\n        for (let j = 0; j < allObjects.length; j++) {\n            const otherObj = allObjects[j];\n\n            if (obj === otherObj) {\n                continue;\n            } else {\n                if ( obj.isCollidedWith(otherObj) ) {\n                    obj.collideWith(otherObj);\n                }\n            }\n        }\n    }\n}\n\nGame.prototype.step = function () {\n    this.moveObjects();\n    this.checkCollisions();\n}\n\nGame.prototype.remove = function (obj) {\n    const astIdx = this.asteroids.findIndex( ele => ele === asteroid );\n    this.asteroids.splice(astIdx, 1);\n}\n\n\nmodule.exports = Game;\n\n//# sourceURL=webpack:///./src/game.js?");

/***/ }),

/***/ "./src/game_view.js":
/*!**************************!*\
  !*** ./src/game_view.js ***!
  \**************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Game = __webpack_require__(/*! ./game */ \"./src/game.js\");\n\nfunction GameView(ctx) {\n    this.game = new Game(ctx);\n    this.ctx = ctx;\n}\n\nGameView.prototype.bindKeyHandlers = function () {\n    //key global from Keymaster lib\n    key('up, w', () => {\n        this.game.ship.power([0, -1]);\n    });\n\n    key('down, s', () => {\n        this.game.ship.power([0, 1]);\n    });\n\n    key('left, a', () => {\n        this.game.ship.power([-1, 0]);\n    });\n\n    key('right, d', () => {\n        this.game.ship.power([1, 0]);\n    });\n}\n\nGameView.prototype.start = function () {\n    this.bindKeyHandlers();\n    setInterval( () => {\n        this.game.draw(this.ctx);\n        this.game.step();\n    }, 20);\n}\n\n\nmodule.exports = GameView;\n\n//# sourceURL=webpack:///./src/game_view.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

eval("const MovingObject = __webpack_require__(/*! ./moving_object */ \"./src/moving_object.js\");\nconst Asteroid = __webpack_require__(/*! ./asteroid */ \"./src/asteroid.js\");\nconst Game = __webpack_require__(/*! ./game */ \"./src/game.js\");\nconst Util = __webpack_require__(/*! ./utils */ \"./src/utils.js\");\nconst GameView = __webpack_require__(/*! ./game_view */ \"./src/game_view.js\");\n\nwindow.MovingObject = MovingObject;\n\nwindow.addEventListener('DOMContentLoaded', (event) => {\n    const canv = document.getElementById('game-canvas');\n    const ctx = canv.getContext(\"2d\");\n    const gameView = new GameView(ctx);\n    window.canv = canv;\n    // window.ctx = ctx;\n\n    gameView.start(ctx);\n});\n\n//# sourceURL=webpack:///./src/index.js?");

/***/ }),

/***/ "./src/moving_object.js":
/*!******************************!*\
  !*** ./src/moving_object.js ***!
  \******************************/
/***/ ((module) => {

eval("function MovingObject(options) {\n    this.pos = options.pos;\n    this.vel = options.vel;\n    this.radius = options.radius;\n    this.color = options.color;\n    this.game = options.game;\n}\n\nMovingObject.prototype.draw = function(ctx) {\n    ctx.beginPath();\n    ctx.arc(\n        this.pos[0],\n        this.pos[1],\n        this.radius,\n        0,\n        2 * Math.PI\n    );\n\n    ctx.fillStyle = this.color;\n    ctx.fill();\n}\n\nMovingObject.prototype.move = function() {\n    const newX = this.pos[0] + this.vel[0];\n    const newY = this.pos[1] + this.vel[1];\n\n    this.pos = this.game.wrap([ newX, newY ]);\n}\n\nMovingObject.prototype.isCollidedWith = function (otherObject) {\n    const diffX = (this.pos[0] - otherObject.pos[0]);\n    const diffY = (this.pos[1] - otherObject.pos[1]);\n    const dist = Math.sqrt(diffX ** 2 + diffY ** 2);\n    const sumRadii = this.radius + otherObject.radius;\n\n    return (dist < sumRadii) ? true : false;\n}\n\nMovingObject.prototype.collideWith = function (otherObj) {\n    //by default, do nothing\n}\n\nmodule.exports = MovingObject;\n\n//# sourceURL=webpack:///./src/moving_object.js?");

/***/ }),

/***/ "./src/ship.js":
/*!*********************!*\
  !*** ./src/ship.js ***!
  \*********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Util = __webpack_require__(/*! ./utils */ \"./src/utils.js\");\nconst MovingObject = __webpack_require__(/*! ./moving_object */ \"./src/moving_object.js\");\n\nfunction Ship(options) {\n    MovingObject.call(this, {\n        color: Ship.COLOR,\n        radius: Ship.RADIUS,\n        game: options.game,\n        pos: options.pos,\n        vel: [0,0]\n    });\n\n}\n\nShip.COLOR = '#6E7FAA';\nShip.RADIUS = 15;\n\nUtil.inherits(Ship, MovingObject);\n\nShip.prototype.relocate = function () {\n    this.pos = this.game.randomPos();\n};\n\nShip.prototype.power = function (impulse) {\n    const [ addVelX, addVelY] = impulse;\n    this.vel[0] += addVelX;\n    this.vel[1] += addVelY;\n}\n\n\n\nmodule.exports = Ship;\n\n//# sourceURL=webpack:///./src/ship.js?");

/***/ }),

/***/ "./src/utils.js":
/*!**********************!*\
  !*** ./src/utils.js ***!
  \**********************/
/***/ ((module) => {

eval("const Util = {\n    inherits: function inherits(subClass, superClass) {\n        subClass.prototype = Object.create(superClass.prototype);\n        subClass.prototype.constuctor = subClass;\n    },\n\n    randomVec: function randomVec(length) {\n        const deg = 2 * Math.PI * Math.random();\n        return Util.scale([Math.sin(deg), Math.cos(deg)], length);\n    },\n\n    // Scale the length of a vector by the given amount.\n    scale: function scale(vec, m) {\n        return [vec[0] * m, vec[1] * m];\n    },\n\n    clearCanv: function clearCanv(ctx) {\n        ctx.clearRect(0, 0, window.canv.width, window.canv.height);\n    }\n}\n\nmodule.exports = Util;\n\n//# sourceURL=webpack:///./src/utils.js?");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module can't be inlined because the eval devtool is used.
/******/ 	var __webpack_exports__ = __webpack_require__("./src/index.js");
/******/ 	
/******/ })()
;