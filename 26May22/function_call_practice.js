class Cat {
    constructor() {
        this.name = 'Markov';
        this.age = 3;
    }
}

class Dog {
    constructor() {
        this.name = 'Noodles';
        this.age = 4;
    }

    chase(cat) {
        console.log(`My name is ${this.name} and I'm chasing ${cat.name}! Woof!`);
    }
}


const Markov = new Cat();
const Noodles = new Dog();

Noodles.chase(Markov);
Noodles.chase.call(Markov, Noodles);
Noodles.chase.apply(Noodles, [Markov]);