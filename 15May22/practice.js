// Test out each of following functions in Node.What does each log to the console? 
// Do any of them throw errors ? See if you can figure out why.

// prints 'in block' twice because function-level `var` is used
function mysteryScoping1() {
    var x = 'out of block';
    if (true) {
        var x = 'in block';
        console.log(x);
    }
    console.log(x);
}

// prints 'in block' then 'out of block' because block-level `const` is used
function mysteryScoping2() {
    const x = 'out of block';
    if (true) {
        const x = 'in block';
        console.log(x);
    }
    console.log(x);
}

// throws error because x constant is being reassigned from function-level `var`
function mysteryScoping3() {
    const x = 'out of block';
    if (true) {
        var x = 'in block';
        console.log(x);
    }
    console.log(x);
}

// prints 'in block' then 'out of block' because of block-level `let`
function mysteryScoping4() {
    let x = 'out of block';
    if (true) {
        let x = 'in block';
        console.log(x);
    }
    console.log(x);
}

// throws error because x is already declared (as opposed to reassigning the value)
function mysteryScoping5() {
    let x = 'out of block';
    if (true) {
        let x = 'in block';
        console.log(x);
    }
    let x = 'out of block again';
    console.log(x);
}


// Write a function that takes three strings - a verb, an adjective, and a noun - 
// uppercases and interpolates them into the sentence "We shall VERB the ADJECTIVE NOUN".
// Use ES6 template literals.
function madLib(verb, adj, noun) {
    result = `We shall ${verb.toUpperCase()} the ${adj.toUpperCase()
        } ${noun.toUpperCase() }.`;
    return result;    
}

// Input
// 1) A String, called searchString.
// 2) A String, called subString.
// Output: A Boolean. true if the subString is a part of the searchString.
function isSubstring(str, substr) {
    return str.includes(substr);
}

// Define a function fizzBuzz(array) that takes an array and returns a new array 
// of every number in the array that is divisible by either 3 or 5, but not both.
function fizzBuzz(arr) {
    return arr.filter(function(num){
        // bitwise XOR converted back to boolean
        return !!(num % 5 === 0 ^ num % 3 === 0);
    });
}

// Define a function isPrime(number) that returns true if number is prime.
// Otherwise, false.Assume number is a positive integer.
function isPrime(num) {
    maxFactor = Math.floor(num / 2);
    for(let i = 2; i <= maxFactor; i++){
        if(num % i === 0){
            return false;
        }
    };

    return true;
}

// Using firstNPrimes, write a function sumOfNPrimes(n) that returns the sum of 
// the first n prime numbers.Hint: use isPrime as a helper method.

function sumOfNPrimes(n) {
    if(n <= 0){ return 0; }
    i = 2;
    primes = [2];
    while(primes.length < n){
        i++;
        if(isPrime(i)){ primes.push(i); }
    }
    sum = primes.reduce((acc, num) => acc + num);
    return sum;
}



console.log('Starting tests...');
console.log('All tests should log `true`');

madLibTest = madLib('sail', 'high', 'seas') === 'We shall SAIL the HIGH SEAS.';
console.log(madLibTest);

subStrTestPos = isSubstring("time to program", "time") === true;
console.log(subStrTestPos);

subStrTestNeg = isSubstring("Jump for joy", "joys") === false;
console.log(subStrTestNeg);

fizzBuzzTest = fizzBuzz([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]).length === [3,5,6,9,10,12].length;
console.log(fizzBuzzTest);

isPrimeTestPos = isPrime(15485863) === true;
console.log(isPrimeTestPos);
isPrimeTestNeg = isPrime(3548563) === false;
console.log(isPrimeTestNeg);

sumOfNPrimesZero = sumOfNPrimes(0) === 0;
console.log(sumOfNPrimesZero);
sumOfNPrimesNonZero = sumOfNPrimes(4) === 17;
console.log(sumOfNPrimesNonZero);
