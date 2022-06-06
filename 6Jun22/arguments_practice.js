// Write a sum function that takes any number of arguments. Solve it first using 
// the arguments keyword, then rewrite your solution to use the ... rest operator.

function sumArgs() {
    if(arguments.length === 0) {
        return undefined;
    }

    let sum = 0;
    for(let i = 0; i < arguments.length; i++) {
        sum += arguments[i];
    }

    return sum;
}

console.log(sumArgs(1, 2, 3, 4) === 10);
console.log(sumArgs(1, 2, 3, 4, 5) === 15);

function sumRest(...args) {
    return args.reduce( (agg, val) => agg + val );
}

console.log(sumRest(1, 2, 3, 4) === 10);
console.log(sumRest(1, 2, 3, 4, 5) === 15);

// Rewrite your myBind method so that it can take both bind - time arguments 
// and call - time arguments.

function myBind(context, ...bindArgs) {
    const closure = (...callArgs) => {
        let allArgs = bindArgs.concat(callArgs)
        return this.apply(context, allArgs);
    }

    return closure;
}

Function.prototype.myBind = myBind;


// Begin test setup for myBind();
class Cat {
    constructor(name) {
        this.name = name;
    }

    says(sound, person) {
        return `${this.name} says ${sound} to ${person}!`;
    }
}

class Dog {
    constructor(name) {
        this.name = name;
    }
}

const markov = new Cat("Markov");
const pavlov = new Dog("Pavlov");

const controlTest = markov.says("meow", "Ned") === 'Markov says meow to Ned!';
const bindArgsTest = markov.says.myBind(pavlov, "meow", "Kush")() === 'Pavlov says meow to Kush!';
const callArgsTest = markov.says.myBind(pavlov)("meow", "a tree") === 'Pavlov says meow to a tree!';
const bindAndCallArgsTest = markov.says.myBind(pavlov, "meow")("Markov") === 'Pavlov says meow to Markov!';
// no bind time args (other than context), call time args are "meow" and "me"
const notMarkovSays = markov.says.myBind(pavlov);
const bindThenCallArgsTest = notMarkovSays("meow", "me") === 'Pavlov says meow to me!';

console.log([controlTest, bindArgsTest, callArgsTest, bindAndCallArgsTest, bindThenCallArgsTest]);
//End tests for myBind();

// Write a curriedSum function that takes an integer(how many numbers to sum) and 
// returns a function that can be successively called with single arguments until 
// it finally returns a sum.
function curriedSum(numArgs) {
    const nums = [];

    const _curriedSum = (num) => {
        let _numArgs = numArgs;
        let _nums = nums;
        _nums.push(num);
        if ( _nums.length === _numArgs ) {
            return _nums.reduce( (acc, val) => acc + val );
        } else {
            return _curriedSum;
        }
    }

    return _curriedSum;
}

const sum = curriedSum(4);
console.log(sum(5)(30)(20)(1) === 56);

// Write a method Function.prototype.curry(numArgs).This should return a function that will:
// Collect up arguments until there are numArgs of them,
// If there are too few arguments still, it should return itself.
// When there are numArgs arguments, it should call the original function.
// Write a version that uses Function.prototype.apply and another one that uses 
// ... (the spread operator).
function curryFunc(numArgs) {
    const args = [];

    const curriedFunc = (...givenArgs) => {
        const _numArgs = numArgs;
        const _args = args;
        givenArgs.forEach( arg => _args.push(arg) )

        if ( _args.length === _numArgs ){
            return this.apply(this, _args)
        } else {
            return curriedFunc;
        }
    }

    return curriedFunc;
}

Function.prototype.curryFunc = curryFunc;

function threeSum(num1, num2, num3) {
    return num1 + num2 + num3;
}

const threeSumCurrySingle = threeSum.curryFunc(3);
console.log(threeSumCurrySingle(1)(3)(5) === 9);
const threeSumCurryMulti = threeSum.curryFunc(3);
console.log(threeSumCurryMulti(1,3)(5) === 9);