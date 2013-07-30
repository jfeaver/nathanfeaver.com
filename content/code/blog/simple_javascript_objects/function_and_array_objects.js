// Functions are Objects
var fn = function() {};
console.log(fn instanceof Function);    // => true
console.log(fn instanceof Object);      // => true

// You can add properties to a function but this is
// rarely done in practice:
fn.foo = 'bar';
console.log(fn.foo);                    // => 'bar'

// Arrays are Objects Too!
var ar = [];
console.log(ar instanceof Array);       // => true
console.log(ar instanceof Object);      // => true
ar.category = 'supercool';

