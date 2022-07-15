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

/***/ "./src/dom_node_collection.js":
/*!************************************!*\
  !*** ./src/dom_node_collection.js ***!
  \************************************/
/***/ ((module) => {

eval("class DomNodeCollection {\n    constructor(collection) {\n        this.collection = collection;\n    }\n\n    html(str) {\n        if (str) {\n            this.collection.forEach( elem => {\n                elem.innerHTML = str;\n            })\n        } else {\n            return this.collection[0].innerHTML;\n        }\n    }\n\n    empty() {\n        this.collection.forEach( elem => {\n            elem.innerHTML = '';\n        })\n    }\n\n    append(data) {\n        if (data instanceof DomNodeCollection) {\n            data.collection.forEach( elem => {\n                const dataToAppend = elem.outerHTML;\n\n                this.collection.forEach( domElem => {\n                    domElem.innerHTML += dataToAppend;\n                })\n            })\n        } else if (data instanceof HTMLElement) {\n            this.collection.forEach( domElem => {\n                domElem.innerHTML += data.outerHTML;\n            } )    \n        } else {\n            this.collection.forEach(domElem => {\n                domElem.innerHTML += data;\n            })   \n        }\n    }\n\n    attr(name, value) {\n        this.collection.forEach( elem => {\n            elem.setAttribute(name, value);\n        })\n    }\n\n    addClass(className) {\n        this.collection.forEach( elem => {\n            elem.classList.add(className);\n        })\n    }\n\n    removeClass(className) {\n        this.collection.forEach(elem => {\n            elem.classList.remove(className);\n        })\n    }\n\n    children() {\n        let children = [];\n\n        this.collection.forEach( elem => {\n            const childrenArr = Array.from( elem.children );\n            children = children.concat( childrenArr );\n        })\n\n        return new DomNodeCollection( children );\n    }\n\n    parent() {\n        const parents = [];\n\n        this.collection.forEach( elem => {\n            const parent = elem.parentElement;\n\n            if ( !parents.includes( parent ) ) {\n                parents.push( elem.parentElement );\n            }\n        })\n\n        return new DomNodeCollection(parents);\n    }\n\n    find(selector) {\n        let matches = [];\n        \n        this.collection.forEach( elem => {\n            const matchArr = Array.from( elem.querySelectorAll(selector))\n            matches = matches.concat( matchArr );\n        })\n\n        return new DomNodeCollection( matches );\n    }\n\n    remove() {\n        this.collection.forEach( elem => {\n            elem.remove();\n        })\n    }\n\n    on(eventName, callback) {\n        this.collection.forEach( elem => {\n            elem.addEventListener(eventName, callback);\n            elem.callback = callback;\n        })\n    }\n\n    off(eventName) {\n        this.collection.forEach( elem => {\n            elem.removeEventListener(eventName, elem.callback);\n        } )\n    }\n}\n\nmodule.exports = DomNodeCollection;\n\n//# sourceURL=webpack:///./src/dom_node_collection.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

eval("const DomNodeCollection = __webpack_require__(/*! ./dom_node_collection */ \"./src/dom_node_collection.js\"); \n\nwindow.functionQueue = [];\n\nwindow.$l = function(selector) {\n    if ( selector instanceof HTMLElement) {\n        return new DomNodeCollection( [selector] );\n    } else if ( selector instanceof Function) {\n        if (document.readyState === 'complete') {\n            selector();\n        } else {\n            window.functionQueue.push(selector);\n        }\n    } else {\n        const htmlArr = Array.from( document.querySelectorAll(selector) );\n        return new DomNodeCollection( htmlArr );\n    }\n}\n\n$l.extend = (...objs) => {\n    const finalObj = objs[0];\n    objs.forEach( obj => {\n        for ( const key in obj) {\n            finalObj[key] = obj[key];\n        }\n    })\n\n    return finalObj;\n}\n\nwindow.addEventListener('DOMContentLoaded', (event) => {\n    for( let i = 0; i < window.functionQueue.length; i++ ) {\n        functionQueue[i]();\n    }\n});\n\n//# sourceURL=webpack:///./src/index.js?");

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