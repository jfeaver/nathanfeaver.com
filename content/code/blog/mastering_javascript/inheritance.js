// define the Person Class
function Person() {}

Person.prototype.walk = function(){
  alert ('I am walking!');
};
Person.prototype.sayHello = function(){
  alert ('hello');
};

// define the Apprentice class
function Apprentice() {
  // Call the parent constructor
  Person.call(this);
}

// inherit Person
Apprentice.prototype = new Person();

// correct the constructor pointer because it points to Person
Apprentice.prototype.constructor = Apprentice;

// replace the sayHello method
Apprentice.prototype.sayHello = function(){
  alert('hi, I am the apprentice');
}

// add sayGoodBye method
Apprentice.prototype.sayGoodBye = function(){
  alert('goodBye');
}

var apprentice1 = new Apprentice();
apprentice1.sayHello();
apprentice1.walk();
apprentice1.sayGoodBye();

// check inheritance
alert(apprentice1 instanceof Person); // true
alert(apprentice1 instanceof Apprentice); // true

