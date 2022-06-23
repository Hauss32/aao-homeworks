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

eval("class Board {\n    constructor(snake) {\n        this.snake = snake;\n    }\n}\n\nBoard.NUM_CELLS_WIDE = 21;\n\nmodule.exports = Board;\n\n//# sourceURL=webpack:///./src/board.js?");

/***/ }),

/***/ "./src/main.js":
/*!*********************!*\
  !*** ./src/main.js ***!
  \*********************/
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

eval("//require some stuff\nconst Snake = __webpack_require__(/*! ./snake */ \"./src/snake.js\");\nconst Board = __webpack_require__(/*! ./board */ \"./src/board.js\");\nconst SnakeView = __webpack_require__(/*! ./snake_view */ \"./src/snake_view.js\")\n\n$( () => {\n    const $el = $( '.snake' );\n    const snake = new Snake();\n    const board = new Board(snake); \n    const view = new SnakeView(board, $el);\n})\n\n//# sourceURL=webpack:///./src/main.js?");

/***/ }),

/***/ "./src/snake.js":
/*!**********************!*\
  !*** ./src/snake.js ***!
  \**********************/
/***/ ((module) => {

eval("class Snake {\n    constructor() {\n        this.direction = [ 0, 0 ];\n        this.segments = [ [ 10, 10 ] ];\n    }\n\n    turn(dir) {\n        this.direction = Snake.DIRECTIONS[dir];\n    }\n\n    move() {\n        this.segments.forEach( (seg, idx) => {\n            this.moveSegment(seg, idx);\n        })\n    }\n\n    moveSegment(currLoc, idx) {\n        const [ xPos, yPos ] = currLoc;\n        const [ xMove, yMove ] = this.direction;\n        const xNewPos = xPos + xMove;\n        const yNewPos = yPos + yMove;\n        this.segments[idx] = [ xNewPos, yNewPos ];\n    }\n\n    segmentsIncludes(arr) {\n        for (let i = 0; i < this.segments.length; i++) {\n            const segmentArr = this.segments[i];\n            if ( this.equals(segmentArr, arr) ) {\n                return true;\n            }\n        }\n\n        return false;\n    }\n\n    equals(arr1, arr2) {\n        if (arr1.length != arr2.length) {\n            return false;\n        } else {\n            for (let i = 0; i < arr1.length; i++) {\n                if (arr1[i] != arr2[i]) {\n                    return false;\n                }\n            }\n        }\n\n        return true;\n    }\n}\n\nSnake.DIRECTIONS = {\n    'U': [0, -1], \n    'D': [0, 1],\n    'L': [-1, 0],\n    'R': [1, 0]\n};\n\nmodule.exports = Snake;\n\n//# sourceURL=webpack:///./src/snake.js?");

/***/ }),

/***/ "./src/snake_view.js":
/*!***************************!*\
  !*** ./src/snake_view.js ***!
  \***************************/
/***/ ((module) => {

eval("class View {\n    constructor(board, $el) {\n        this.board = board;\n        this.$el = $el;\n        this.setupBoard();\n        this.bindKeydown();\n        this.interval = setInterval( () => {\n            this.step();\n        }, 500);\n    }\n\n    setupBoard() {\n        for (let i = 0; i < View.BOARD_WIDTH; i++) {\n            const $ul = $( '<ul></ul>' );\n            this.$el.append( $ul );\n\n            for (let j = 0; j < View.BOARD_WIDTH; j++) {\n                const $li = $( '<li></li>' );\n                $li.data( 'pos', [ j, i ] );\n                $ul.append( $li );\n            }\n        }\n    }\n\n    step() {\n        this.board.snake.move();\n        this.draw();\n    }\n\n    draw() {\n        const $snakeCells = this.getSnakeCells();\n\n        $('.snake li.segment').removeClass( 'segment' );\n\n        $snakeCells.each( function() {\n            $( this ).addClass( 'segment' );\n        })\n    }\n\n    getSnakeCells() {\n        const snake = this.board.snake;\n        const $cells = $( '.snake li' );\n        const $snakeCells = $cells.filter( function() {\n            const $cell = $( this );\n            const cellPos = $cell.data( 'pos' );\n            return snake.segmentsIncludes( cellPos );\n        });\n        return $snakeCells;\n    }\n\n    bindKeydown() {\n        $('body').on( 'keydown', event => {\n            const direction = View.KEYMAP[event.keyCode];\n            if ( direction ) {\n                this.board.snake.turn(direction);\n            }\n        });\n    }\n}\n\nView.BOARD_WIDTH = 21;\nView.KEYMAP = {\n    37: 'L',\n    38: 'U',\n    39: 'R',\n    40: 'D'\n}\n\nmodule.exports = View;\n\n//# sourceURL=webpack:///./src/snake_view.js?");

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