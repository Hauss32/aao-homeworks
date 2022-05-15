// Write a function titleize that takes an array of names and a function (callback). 
// titleize should use Array.prototype.map to create a new array full of titleized 
// versions of each name - titleize meaning "Roger" should be made to read 
// "Mx. Roger Jingleheimer Schmidt".Then pass this new array of names to the callback, 
// which should use Array.prototype.forEach to print out each titleized name.

function titleize(namesArr, func) {
    names = namesArr.map(name => `Mx. ${name} Jingleheimer Schmidt`);

    names.forEach(name => func(name));
}



// First write a constructor function for an elephant.Each elephant should have 
// a name, height(in inches), and array of tricks

function Elephant(name, height, tricksArr) {
    this.name = name;
    this.height = height;
    this.tricks = tricksArr;   
}

Elephant.prototype.trumpet = function() {
    console.log(`${this.name} the elephant goes 'phrRRRRRRRRRRR!!!!!!!'`);
}

Elephant.prototype.grow = function(numInches) {
    this.height += numInches
    console.log(`${this.name} grew to ${this.height} inches!`);
}

Elephant.prototype.addTrick = function(trick) {
    this.tricks.push(trick)
    console.log(`'${trick}' added to ${this.name}'s list of tricks!`);
}

Elephant.prototype.play = function() {
    if(this.tricks.length === 0){
        console.log(`${this.name} hasn't learned any tricks yet!`)
        return;
    }
    randomIndex = Math.floor(Math.random() * this.tricks.length);
    trick = this.tricks[randomIndex];
    return trick
}

// First, let's make a few elephants so we have a small herd. 
let ellie = new Elephant("Ellie", 185, ["giving human friends a ride", "playing hide and seek"]);
let charlie = new Elephant("Charlie", 200, ["painting pictures", "spraying water for a slip and slide"]);
let kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
let micah = new Elephant("Micah", 143, ["trotting", "playing tic tac toe", "doing elephant ballet"]);

let herd = [ellie, charlie, kate, micah];

// Now let's create a function called paradeHelper that we'll use to have an 
// elephant parade.It should take a single elephant as an argument; this way, 
// we can pass it as a callback to forEach when called on our herd.
// Make sure to store it as a property on the Elephant object.You can populate it 
// with any console.log statement you want to build your 
// parade(e.g. "___ is trotting by!").

Elephant.paradeHelper = function(elephant){
    console.log(`${elephant.name} is up next, standing at ${elephant.height} inches tall.`)
    console.log(`Look at that! ${elephant.name} is ${elephant.play()}!!`)
}

// Let's make a function dinerBreakfast. Ultimately, we want it to return an 
// anonymous closure, which we will be able to use to keep adding breakfast foods 
// to our initial order.

function dinerBreakfast(food='eggs over-easy') {
    let order = [];

    let addToOrder = (item) => { 
        order.push(item); 
        let orderStr = order.join(' and ');
        console.log(`I'd like ${orderStr}, please.`);
        return order;
    };

    addToOrder(food);
    return addToOrder;
}




// Tests
console.log('Begin testing...');
console.log('All tests should print `true`');

let titleizeFunc = function(arg){
    console.log(arg);
};
titleize(["Mary", "Brian", "Leo"], titleizeFunc);

let mrTrunk = new Elephant('Mr. Trunk', 150, ['playing the drums', 'eating a watermelon', 'flipping over safari jeeps']);
mrTrunk.trumpet();
mrTrunk.grow(5);
mrTrunk.addTrick('stepping on grapes');
mrTrunk.play();

herd.forEach(Elephant.paradeHelper);

let bfastOrder = dinerBreakfast();
bfastOrder('avocado toast');
bfastOrder('bacon');
bfastOrder('coffee');


