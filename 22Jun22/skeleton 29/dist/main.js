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

/***/ "./src/game.js":
/*!*********************!*\
  !*** ./src/game.js ***!
  \*********************/
/***/ ((module) => {

eval("class Game {\n  constructor() {\n    this.towers = [[3, 2, 1], [], []];\n  }\n\n  isValidMove(startTowerIdx, endTowerIdx) {\n      const startTower = this.towers[startTowerIdx];\n      const endTower = this.towers[endTowerIdx];\n\n      if (startTower.length === 0) {\n        return false;\n      } else if (endTower.length == 0) {\n        return true;\n      } else {\n        const topStartDisc = startTower[startTower.length - 1];\n        const topEndDisc = endTower[endTower.length - 1];\n        return topStartDisc < topEndDisc;\n      }\n  }\n\n  isWon() {\n      // move all the discs to the last or second tower\n      return (this.towers[2].length == 3) || (this.towers[1].length == 3);\n  }\n\n  move(startTowerIdx, endTowerIdx) {\n      if (this.isValidMove(startTowerIdx, endTowerIdx)) {\n        this.towers[endTowerIdx].push(this.towers[startTowerIdx].pop());\n        return true;\n      } else {\n        return false;\n      }\n  }\n\n  print() {\n      console.log(JSON.stringify(this.towers));\n  }\n\n  promptMove(reader, callback) {\n      this.print();\n      reader.question(\"Enter a starting tower: \", start => {\n        const startTowerIdx = parseInt(start);\n        reader.question(\"Enter an ending tower: \", end => {\n          const endTowerIdx = parseInt(end);\n          callback(startTowerIdx, endTowerIdx);\n        });\n      });\n  }\n\n  run(reader, gameCompletionCallback) {\n      this.promptMove(reader, (startTowerIdx, endTowerIdx) => {\n        if (!this.move(startTowerIdx, endTowerIdx)) {\n          console.log(\"Invalid move!\");\n        }\n\n        if (!this.isWon()) {\n          // Continue to play!\n          this.run(reader, gameCompletionCallback);\n        } else {\n          this.print();\n          console.log(\"You win!\");\n          gameCompletionCallback();\n        }\n      });\n  }\n}\n\nmodule.exports = Game;\n\n\n//# sourceURL=webpack:///./src/game.js?");

/***/ }),

/***/ "./src/hanoi-view.js":
/*!***************************!*\
  !*** ./src/hanoi-view.js ***!
  \***************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Game = __webpack_require__(/*! ./game */ \"./src/game.js\");\n\nclass View {\n    constructor(game, $el) {\n        this.game = game;\n        this.$el = $el;\n        this.currTowerIdx;\n\n        this.setupTowers();\n        this.render();\n        this.bindClicks();\n    }\n\n    setupTowers() {\n        const numTowers = 3;\n\n        for (let i = 0; i < numTowers; i++) {\n            const $tower = $( '<ul></ul>' );\n            $tower.data( 'towerNum', i );\n            $tower.addClass( 'unclicked' )\n            this.$el.append( $tower );\n        }\n    }\n\n    render() {\n        const towerState = this.game.towers;\n        const $viewTowers = this.$el.children('ul');\n\n        $viewTowers.empty();\n\n        towerState.forEach( (tower, towerIdx) => {\n            tower.forEach( diskSize => {\n                const $disk = $( '<li></li>' );\n                const $viewTower = $( $viewTowers[towerIdx] );\n                $disk.addClass( `size-${diskSize}` );\n                $viewTower.prepend($disk);\n            })\n        });\n    }\n\n    bindClicks() {\n        const view = this;\n        const $viewTowers = this.$el.children('ul');\n        const addClickHandler = (viewTower) => {\n            const $viewTower = $(viewTower);\n\n            $viewTower.click(function () {\n                const $this = $(this);\n                const towerNumIdx = $this.data('towerNum');\n                if (view.currTowerIdx >= 0) {\n                    view.tryMove(towerNumIdx);\n                    view.currTowerIdx = undefined;\n                    $viewTowers.removeClass('clicked');\n                    $viewTowers.addClass('unclicked');\n                } else {\n                    view.currTowerIdx = towerNumIdx;\n                    $this.addClass('clicked');\n                    $this.removeClass('unclicked');\n                }\n\n                if (view.game.isWon()) {\n                    setTimeout( () => {\n                        alert(\"SOLVED!! You're so awesome! *sarcastic clap*\");\n                        view.finishGame();\n                    }, 10);\n                } \n\n                view.render();\n            });\n        }\n\n        $viewTowers.each( function() {\n            addClickHandler( $(this) );\n        } );\n    }\n\n    tryMove(toTowerIdx) {\n        const fromTowerIdx = this.currTowerIdx;\n        const isValid = this.game.isValidMove(fromTowerIdx, toTowerIdx);\n\n        if ( isValid ) {\n            this.game.move( fromTowerIdx, toTowerIdx );\n        } else {\n            alert('Invalid move. Disks can only move to columns that are empty or' +\n                ' have a larger disk on top than the disk being moved.');\n        }\n    }\n\n    finishGame() {\n        const $viewTowers = this.$el.children('ul');\n        $viewTowers.off('click');\n        $viewTowers.addClass('disabled');\n    }\n}\n\nmodule.exports = View;\n\n//# sourceURL=webpack:///./src/hanoi-view.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

eval("const HanoiGame = __webpack_require__(/*! ./game */ \"./src/game.js\");\nconst HanoiView = __webpack_require__(/*! ./hanoi-view */ \"./src/hanoi-view.js\");\n\n$(() => {\n  const rootEl = $('.hanoi');\n  const game = new HanoiGame();\n  new HanoiView(game, rootEl);\n});\n\n\n//# sourceURL=webpack:///./src/index.js?");

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