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

/***/ "./src/board.js":
/*!**********************!*\
  !*** ./src/board.js ***!
  \**********************/
/***/ ((module) => {

eval("class Board {\n    constructor(snake, $el) {\n        this.snake = snake;\n        this.$el = $el;\n    }\n}\n\nBoard.NUM_CELLS_WIDE = 21;\n\nmodule.exports = Board;\n\n//# sourceURL=webpack:///./src/board.js?");

/***/ }),

/***/ "./src/main.js":
/*!*********************!*\
  !*** ./src/main.js ***!
  \*********************/
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

eval("//require some stuff\nconst Snake = __webpack_require__(/*! ./snake */ \"./src/snake.js\");\nconst Board = __webpack_require__(/*! ./board */ \"./src/board.js\");\n\n$( () => {\n    const $el = $( '.snake' );\n    const snake = new Snake();\n    const board = new Board(snake, $el);\n})\n\n//# sourceURL=webpack:///./src/main.js?");

/***/ }),

/***/ "./src/snake.js":
/*!**********************!*\
  !*** ./src/snake.js ***!
  \**********************/
/***/ ((module) => {

eval("class Snake {\n    constructor() {\n        this.direction = [ 0, 0 ];\n        this.segments = [ [ 10, 10 ] ];\n    }\n\n    turn(dir) {\n        this.direction = dir;\n        this.move();\n    }\n\n    move() {\n        const headLoc = this.segments[0];\n\n        this.segments.forEach( seg => {\n            this.moveSegment(seg);\n        })\n    }\n\n    moveSegment(currLoc) {\n        const [ xPos, yPos ] = currLoc;\n        const [ xMove, yMove ] = this.direction;\n        const xNewPos = xPos + xMove;\n        const yNewPos = yPos + yMove;\n        return [ xNewPos, yNewPos ];\n    }\n}\n\nSnake.DIRECTIONS = {\n    'U': [0, 1], \n    'D': [0, -1],\n    'L': [-1, 0],\n    'R': [1, 0]\n};\n\nmodule.exports = Snake;\n\n//# sourceURL=webpack:///./src/snake.js?");

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
/******/ 	var __webpack_exports__ = __webpack_require__("./src/main.js");
/******/ 	
/******/ })()
;