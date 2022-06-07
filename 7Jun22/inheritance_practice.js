// Write a Function.prototype.inherits method that will do this for you.
// Do not use Object.create right now; you should deeply understand what the 
// new keyword does and how the __proto__ chain is constructed.

function inheritsSurrogate(classToInherit) {
    function Surrogate() {}
    Surrogate.prototype = classToInherit.prototype;

    this.prototype = new Surrogate();
    this.prototype.constructor = this;
}

Function.prototype.inheritsSurrogate = inheritsSurrogate;

function MovingObject() { }
MovingObject.prototype.move = () => {
    console.log('Moving!');
};

function Ship() { }
Ship.inheritsSurrogate(MovingObject);
const ship = new Ship();
ship.move();

// Refactor your solution using Object.create
function inherits(classToInherit) {
    this.prototype = Object.create(classToInherit.prototype);
    this.prototype.constructor = this;
}

Function.prototype.inherits = inherits;

function LazyObject() { }
LazyObject.prototype.move = () => {
    console.log('Not moving!');
};

function Rock() { }
Rock.inherits(LazyObject);
const rock = new Rock();
rock.move();

function LazyDog() { }
LazyDog.inherits(LazyObject);
const dog = new LazyDog();
dog.move();

LazyDog.prototype.bark = () => console.log('Werf.');
dog.bark();

try {
    rock.bark();
    console.log('Should not reach this code!');
} catch (error) {
    console.log('No bark method, as expected.')
}