// Use setInterval to build a small clock in your terminal.It should display the 
// current time every second.However, you can only query the system time once.
// Your clock must store that time, increment it, and display it in HH:MM:SS (use 24hr format).

class Clock {
    constructor() {
        this.today = new Date();
        this.hours = this.today.getHours();
        console.log(this.hours);
        this.minutes = this.today.getMinutes();
        this.seconds = this.today.getSeconds();
        
        this.printTime();
        
        this.intervalID = setInterval(this._tick.bind(this), 1000);
    }

    printTime() {
        const hourStr = String(this.hours).padStart(2, '0');
        const minStr = String(this.minutes).padStart(2, '0');
        const secStr = String(this.seconds).padStart(2, '0');

        console.log(`${hourStr}:${minStr}:${secStr}`);
    }

    _tick() {
        this.seconds += 1;

        if(this.seconds === 60){
            this.seconds = 0;
            this.minutes += 1;
        }

        if(this.minutes === 60){
            this.minutes = 0;
            this.hours += 1;
        }

        if(this.hours === 24){
            this.hours = 0;
        }

        this.printTime();
    }
}

// uncomment for testing
// const clock = new Clock();



// Let's write a function that will read several numbers, one after another, 
// and sum up the total. After each number, let's print out the partial sums along the way, 
// and pass the total sum to a callback when done.
const readline = require('readline');
const reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
    if (numsLeft === 0) {
        completionCallback(sum);
        reader.close();
        return;
    }

    console.log(`You have ${numsLeft} more number${numsLeft > 1 ? 's' : ''} to pick.`);
    reader.question("Choose a number: ", resp => {
        let num = parseInt(resp, 10);
        let newSum = sum + num;
        let newNumsLeft = numsLeft - 1;
        console.log(`The new sum is ${newSum}`);
        addNumbers(newSum, newNumsLeft, completionCallback);
    });
}

// uncomment for testing
// addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));


// Write a method called absurdBubbleSort(arr, sortCompletionCallback).Instead of 
// using the traditional >, we'll prompt the user to perform each comparison for us.
function askIfGreaterThan(el1, el2, callback) {
    reader.question(`Is ${el1} > ${el2}? ('yes' or 'no')`, (resp) => {
        const result = (resp === 'yes') ? true : false;
        callback(result);
    })
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
    if (i < arr.length - 1) {
        askIfGreaterThan(arr[i], arr[i + 1], (needSwap) => {
            if (needSwap) {
                const [ el1, el2 ] = [ arr[i], arr[i+1] ];
                arr[i] = el2;
                arr[i+1] = el1;
                madeAnySwaps = true;
            }

            innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
        });
    } else {
        outerBubbleSortLoop(madeAnySwaps);
    }

}

function absurdBubbleSort(arr, sortCompletionCallback) {
    function outerBubbleSortLoop(madeAnySwaps) {
        if (madeAnySwaps) {
            innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
        } else {
            sortCompletionCallback(arr);
        }
    }

    outerBubbleSortLoop(true);
}

// uncomment for testing
// absurdBubbleSort([3, 2, 1, 4], function (arr) {
//     console.log("Sorted array: " + JSON.stringify(arr));
//     reader.close();
// });



// Write your own myBind(context)
function myBind(context) {
    const closure = () => {
        return this.apply(context);
    }

    return closure;
}

Function.prototype.myBind = myBind;

// uncomment for testing
// class Lamp {
//     constructor() {
//         this.name = "a lamp";
//     }
// }

// const turnOn = function () {
//     console.log("Turning on " + this.name);
// };

// const lamp = new Lamp();
// const myBoundTurnOn = turnOn.myBind(lamp);

// myBoundTurnOn(); // should say "Turning on a lamp"


// Write your own myThrottle(interval) function on the Function.prototype.myThrottle 
// should take an interval as an argument and return a "throttled" version of the 
// original function that can only be invoked every interval milliseconds.
const myThrottle = function (interval) {
    let tooSoon = false;

    const closure = () => {
        if (tooSoon) {
            return;
        } else {
            tooSoon = true;

            setTimeout( () => {
                tooSoon = false;
            }, interval)

            this();
        }
    }

    return closure;
}

// uncomment for testing
// Function.prototype.myThrottle = myThrottle;

// const myFunc = function () {
//     console.log(`Writing stuff!`);
// };

// setInterval(myFunc.myThrottle(5000), 100);


// Like myThrottle, a debounce function is another way of restricting function 
// invocations. In a debounced function, the specified interval represents how 
// much time must pass without the debounced function being invoked, before the 
// original function is invoked automatically.
const myDebounce = function(interval) {
    let timer = null;

    const closure = (...args) => {
        const callFunc = () => {
            timer = null;
            this(...args);
        }

        clearTimeout(timer);
        timer = setTimeout(callFunc, interval);
    }

    return closure;
}

Function.prototype.myDebounce = myDebounce;


// uncomment for testing
// class SearchBar {
//     constructor() {
//         this.query = "";

//         this.type = this.type.bind(this);
//         this.search = this.search.bind(this);
//     }

//     type(letter) {
//         this.query += letter;
//         this.search();
//     }

//     search() {
//         console.log(`searching for ${this.query}`);
//     }
// }

// const searchBar = new SearchBar();

// const queryForHelloWorld = () => {
//     searchBar.type("h");
//     searchBar.type("e");
//     searchBar.type("l");
//     searchBar.type("l");
//     searchBar.type("o");
//     searchBar.type(" ");
//     searchBar.type("w");
//     searchBar.type("o");
//     searchBar.type("r");
//     searchBar.type("l");
//     searchBar.type("d");
// };

// searchBar.search = searchBar.search.myDebounce(2000);
// queryForHelloWorld();