// Array#uniq - returns a new array containing each individual element of the 
// original array only once(creating all unique elements)

Array.prototype.uniq = function() {
    let uniques = [];
    this.forEach( (ele) => {
        if (uniques.includes(ele)) {
            return;
        } else {
            uniques.push(ele);
        }
    })

    return uniques;
}

// Array#twoSum - returns an array of position pairs where the elements sum to zero
Array.prototype.twoSum = function() {
    let loopIndices = this.length - 1
    let posPairs = [];
    
    for( let i = 0; i < loopIndices; i++ ){
        for(let j = i + 1; j <= loopIndices; j++ ){
            if(this[i] + this[j] === 0){
                posPairs.push([i, j]);
            }
        }
    }

    return posPairs;
}

// Array#transpose - where we have a two - dimensional array representing a 
// matrix.returns the transpose
Array.prototype.transpose = function(){
    let subArrLen = this[0].length;
    let transArr = [];

    for( let i = 0; i < subArrLen; i++ ) { transArr.push([]); }

    this.forEach( (subArr) => {
        subArr.forEach( (ele, idx) => {
            transArr[idx].push(ele);
        })
    })

    return transArr;
}




console.log('Begin testing...');
console.log('All tests should return `true`.');

let uniqTest = [1, 2, 2, 3, 3, 3].uniq().length === 3;
console.log(uniqTest);

let twoSumTest = [-9, 0, -1, -2, -3, 3, 2, 1, 9].twoSum().length === 4;
console.log(twoSumTest);

let transposeArr = [[1, 1], [2, 2], [3, 3], [4, 4]]
let transposeResult = transposeArr.transpose();
let transposeTest = transposeResult.length === transposeArr[0].length;
let transposeSubTest = transposeResult[0].length === transposeArr.length;
console.log(transposeTest);
console.log(transposeSubTest);