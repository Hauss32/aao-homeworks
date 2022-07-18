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

/***/ "./src/inbox.js":
/*!**********************!*\
  !*** ./src/inbox.js ***!
  \**********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const MessageStore = __webpack_require__(/*! ./message_store */ \"./src/message_store.js\");\n\nconst Inbox = {\n    render: () => {\n        const messages = MessageStore.getInboxMessages();\n        const messageContainer = document.createElement( 'ul' );\n        messageContainer.className = 'messages';\n\n        messages.forEach( message => {\n            const msgElem = Inbox.renderMessage( message );\n            messageContainer.appendChild( msgElem );\n        })\n\n        return messageContainer;\n    },\n\n    renderMessage: (message) => {\n        const msgElem = document.createElement('li');\n        msgElem.className = 'message';\n\n        msgElem.innerHTML = `\n            <span class='from'>${message.from}</span>\n            <span class=\"subject\">${message.subject}</span> -\n            <span class=\"body\">${message.body}</span>\n            `\n        return msgElem;\n    }\n}\n\nmodule.exports = Inbox;\n\n//# sourceURL=webpack://mail/./src/inbox.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/***/ ((__unused_webpack_module, __unused_webpack_exports, __webpack_require__) => {

eval("const Inbox = __webpack_require__(/*! ./inbox */ \"./src/inbox.js\");\nconst Router = __webpack_require__(/*! ./router */ \"./src/router.js\");\n\nconst routes = {\n    inbox: Inbox\n}\n\ndocument.addEventListener( 'DOMContentLoaded', function() {\n    const sidebarItemsCollection = document.querySelectorAll( '.sidebar-nav li' );\n    const contentContainer = document.querySelector( '.content' );\n    const sidebarItemsArr = Array.from(sidebarItemsCollection);\n\n    sidebarItemsArr.forEach( item => {\n        item.addEventListener('click', event => {\n            const link = event.target;\n            const text = link.innerText.toLowerCase();\n            window.location.hash = text;\n        });\n    });\n\n    const router = new Router( contentContainer, routes );\n    router.start();\n    window.location.hash = '#inbox';\n})\n\n//# sourceURL=webpack://mail/./src/index.js?");

/***/ }),

/***/ "./src/message_store.js":
/*!******************************!*\
  !*** ./src/message_store.js ***!
  \******************************/
/***/ ((module) => {

eval("let messages = {\n    sent: [\n        {\n            to: \"friend@mail.com\",\n            subject: \"Check this out\",\n            body: \"It's so cool\"\n        },\n        { to: \"person@mail.com\", subject: \"zzz\", body: \"so booring\" }\n    ],\n    inbox: [\n        {\n            from: \"grandma@mail.com\",\n            subject: \"Fwd: Fwd: Fwd: Check this out\",\n            body:\n                \"Stay at home mom discovers cure for leg cramps. Doctors hate her\"\n        },\n        {\n            from: \"person@mail.com\",\n            subject: \"Questionnaire\",\n            body: \"Take this free quiz win $1000 dollars\"\n        }\n    ]\n};\n\nconst MessageStore = {\n    getInboxMessages: function() {\n        return messages.inbox;\n    },\n\n    getSentMessages: function() {\n        return messages.sent;\n    }\n}\n\nmodule.exports = MessageStore;\n\n//# sourceURL=webpack://mail/./src/message_store.js?");

/***/ }),

/***/ "./src/router.js":
/*!***********************!*\
  !*** ./src/router.js ***!
  \***********************/
/***/ ((module) => {

eval("class Router {\n    constructor(node, routes) {\n        this.node = node;\n        this.routes = routes;\n    }\n\n    start() {\n        window.addEventListener( 'hashchange', () => {\n            this.render();\n        })\n\n        this.render();\n    }\n\n    activeRoute() {\n        let route = window.location.hash;\n        route = route.replace( '#', ''); //remove '#' prefix in route\n\n        return this.routes[route];\n    }\n\n    render() {\n        const component = this.activeRoute();\n        this.node.innerHTML = \"\";\n\n        if ( component ) {\n            const messagesElem = component.render();\n            this.node.appendChild( messagesElem );\n        }\n    }\n}\n\nmodule.exports = Router;\n\n//# sourceURL=webpack://mail/./src/router.js?");

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