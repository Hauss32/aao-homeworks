// range(start, end) - receives a start and end value, returns an array 
// from start up to end
function range(start, end) {
    if( start === end ) { return end; }

    let nums = [];
    nums.push(start);

    return nums.concat(range(start + 1, end));
}

// sumRec(arr) - receives an array of numbers and recursively sums them
function sumRec(arr) {
    if( arr.length === 0){ return 0; }

    let sum = arr[0];

    return sum += sumRec(arr.slice(1, arr.length));
}

// exponent(base, exp) - receives a base and exponent, returns the base raise to 
// the power of the exponent(base ^ exp)
function exponent(base, exp) {
    if ( exp === 0) { return 1; }

    return base * exponent(base, exp - 1);
}

// fibonacci(n) - receives an integer, n, and returns the first n Fibonacci numbers
function fibonacci(n) {
    if(n <= 0){
        return [];
    } else if(n < 3){
        return [0,1].slice(0,n);
    }
    
    let fib = fibonacci(n-1);
    let lastNum = fib[fib.length - 1];
    let secLastNum = fib[fib.length - 2];

    return fib.concat(lastNum + secLastNum);
}

// deepDup(arr) - deep dup of an Array!
function deepDup(arr) {
    let newArr = [];

    arr.forEach( (ele) => {
        if( ele instanceof Array){
            newArr = newArr.concat([deepDup(ele)]);
        } else{
            newArr = newArr.concat(ele);
        }
    })

    return newArr;
}

// bsearch(arr, target) - receives a sorted array, returns the index of 
// the target or - 1 if not found
function bsearch(arr, target) {
    if(arr.length === 0 || (arr.length === 1 && arr[0] !== target)){ 
        return -1; 
    }

    let halfLen = Math.ceil(arr.length / 2);
    let midNum = arr[halfLen];
    let idx = 0;

    if(midNum === target){
        return idx += halfLen;
    } else if(midNum > target) {
        let subArr = arr.slice(0, halfLen);
        let next = bsearch(subArr, target);

        if(next === -1){ return -1; }
        
        return idx += next;
    } else {
        idx += halfLen;
        let subArr = arr.slice(halfLen, arr.length);
        let next = bsearch(subArr, target);

        if (next === -1) { return -1; }
        
        return idx += next;
    }
}

// mergesort(arr) - receives an array, returns a sorted copy of the array by 
// implementing merge sort sorting algorithm
function mergeSort(arr) {
    if( arr.length <= 1){ return arr; }

    let midIdx = Math.floor(arr.length / 2);
    let subArr1 = arr.slice(0, midIdx);
    let subArr2 = arr.slice(midIdx, arr.length);

    let sortArr1 = mergeSort(subArr1);
    let sortArr2 = mergeSort(subArr2);

    let sorted = [];

    while(sortArr1.length && sortArr2.length){
        if(sortArr1[0] > sortArr2[0]){
            let el = sortArr2.shift();
            sorted.push(el);
        } else{
            let el = sortArr1.shift();
            sorted.push(el);  
        }
    }

    let remainArr = sortArr1.concat(sortArr2);
    sorted = sorted.concat(remainArr);
    
    return sorted;
}

// subsets(arr) - receives an array, returns an array containing all the 
// subsets of the original array
function subsets(arr) {
    if( arr.length <= 1 ){ return [arr]; }

    let allSubsets = [];
    
    for(let i = 0; i < arr.length; i++){
        let slice = arr.slice(0, i + 1)
        allSubsets.push(slice)
    }

    return allSubsets.concat(subsets( arr.slice(1,arr.length) ));
}


console.log('Begin testing...');
console.log('All tests should return `true`.');

let rangeTest = range(1,5);
console.log(rangeTest.length === 5);
console.log(rangeTest[0] === 1);
console.log(rangeTest[4] === 5);

let sumRecTest = sumRec([1,2,3,4,5]);
console.log( sumRecTest === 15 );

let exponentTest = exponent(2, 4);
console.log( exponentTest === 2**4 );

let fibonacciTest = fibonacci(8);
console.log(fibonacciTest[0] === 0);
console.log(fibonacciTest[7] === 13);

let deepDupArr = [1,[2,3,4,5],[[6,7],[8,9,10]]];
let deepDupTest = deepDup(deepDupArr);
console.log(deepDupArr.length === deepDupTest.length);
console.log(deepDupTest[1] instanceof Array);
console.log(deepDupArr[1] !== deepDupTest[1]); //arr @ second idx's are diff objs
console.log(deepDupTest[2][0] instanceof Array);
console.log(deepDupTest[2][0] !== deepDupArr[2][0]); //first nested arr @ first idx's are diff objs

let bsearchArr = [1,2,3,4,5,6,7,8,9];
let bsearchTest1 = bsearch(bsearchArr, 5); //middle
let bsearchTest2 = bsearch(bsearchArr, 2); //left
let bsearchTest3 = bsearch(bsearchArr, 9); //right
let bsearchTest4 = bsearch(bsearchArr, 100); //mising
console.log(bsearchTest1 === 4);
console.log(bsearchTest2 === 1);
console.log(bsearchTest3 === 8);
console.log(bsearchTest4 === -1);

let mergeSortTest = mergeSort([5,1,4,3,0,2]);
console.log(mergeSortTest.length === 6);
console.log(mergeSortTest[0] === 0);
console.log(mergeSortTest[5] === 5);

let subsetsTest = subsets([1,2,3]);
console.log(subsetsTest.length === 6); // [ [1],[1,2],[1,2,3],[2],[2,3],[3] ]
console.log(subsetsTest[0].length === 1); // [1]
console.log(subsetsTest[2].length === 3); // [1,2,3]
console.log(subsetsTest[5].length === 1); // [3]
