// The most basic object in JavaScript is {}
var basic_object = {};
console.log(basic_object instanceof Object);    // => true

// An object with properties
var obj = {
  foo: 'bar',
  nothing: null
};
console.log(obj.foo);         // => 'bar'
console.log(obj.nothing);     // => null
console.log(obj.missing);     // => undefined

// Set new properties
obj.num = 5;
console.log(obj.num);         // => 5

