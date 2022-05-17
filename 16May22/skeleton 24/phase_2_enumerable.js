// Array#myEach(callback) - receives a callback function and executes 
// the callback for each element in the array

Array.prototype.myEach = function(callback){
    for( let i = 0; i < this.length; i++ ){
        callback(this[i]);
    }

    return;
}

Array.prototype.myMap = function (callback) {
    let newArr = [];

    this.myEach( (ele) => newArr.push(callback(ele)) );

    return newArr;
}

Array.prototype.myReduce = function (callback, initialValue) {
    let idx = 0;
    let currVal;

    if(initialValue){
        currVal = initialValue;
    } else{
        currVal = this[idx];
        idx++;
    }

    for( let i = idx; i < this.length; i++ ){
        currVal = callback(currVal, this[i]);
    }

    return currVal;
}


console.log('Begin testing...');
console.log('All tests should return `true`.');

let strArr = ['some', 'pieces', 'of', 'string'];

let myEachTest = [];
strArr.myEach( (ele) => myEachTest.push( ele.toUpperCase() ) );
console.log( myEachTest.length === strArr.length );
console.log( myEachTest[0] === strArr[0].toUpperCase() );

let myMapTest = strArr.myMap( (ele) => ele.toUpperCase() );
console.log( myMapTest.length === strArr.length );
console.log( myMapTest[0] === strArr[0].toUpperCase() );

let myReduceTestNoInitial = [1, 2, 3].myReduce(function (acc, el) {
    return acc + el;
}) === 6;
let myReduceTestWithInitial = [1, 2, 3].myReduce(function (acc, el) {
    return acc + el;
}, 25) === 31;
console.log(myReduceTestNoInitial);
console.log(myReduceTestWithInitial);



