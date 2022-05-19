function Cat(name, owner) {
    this.name = name;
    this.owner = owner;
}

Cat.prototype.cuteStatement = function(){
    console.log(`${this.owner} loves ${this.name}`);
};

let cat1 = new Cat('Chairman Meow', 'Noone');
cat1.cuteStatement();
let cat2 = new Cat('Whiskers', 'The Street');
cat2.cuteStatement();
let cat3 = new Cat('Snowball', 'Lisa');
cat3.cuteStatement();

Cat.prototype.cuteStatement = function () {
    console.log(`Everyone loves ${this.name}`);
};

cat1.cuteStatement();
cat2.cuteStatement();
cat3.cuteStatement();

Cat.prototype.meow = function () {
    console.log(`MeeeeEeEeeOWWWWWW!`);
};

cat1.meow();
cat1.meow = function () {
    console.log('meow.');
};
cat1.meow();
