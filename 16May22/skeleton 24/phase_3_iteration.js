// Array#bubbleSort - receives an array, returns a sorted array by implementing 
// bubble sort sorting algorithm

Array.prototype.bubbleSort = function() {
    let sorted = false
    let sortArr = [...this];

    while( !sorted ){
        sorted = true;

        for( let i = 0; i < sortArr.length - 1; i++ ){
            let x = sortArr[i];
            let y = sortArr[i+1];
            if( x > y ){
                sortArr[i] = y;
                sortArr[i+1] = x;
                sorted = false;
            }
        }
    }

    return sortArr;
}

// String#substrings - receives a string, returns an array of all substrings

String.prototype.substrings = function(){
    let subStrArr = [];
    
    for( let i = 0; i < this.length; i++ ){
        for( let j = i+1; j <= this.length; j++ ){
            subStrArr.push(this.slice(i, j));
        }
    }

    return subStrArr;
}



console.log('Begin testing...');
console.log('All tests should return `true`.');

let testArr = [4,1,3,6,5,2];

let bubbleSortTest = testArr.bubbleSort();
console.log(bubbleSortTest[0] === 1);
console.log(bubbleSortTest[5] === 6);

let substringsTest = 'abcd'.substrings();
console.log(substringsTest[0] === 'a');
console.log(substringsTest[1] === 'ab');
console.log(substringsTest[2] === 'abc');