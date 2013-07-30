// An object with no properties
var basic_object = {};

// An object with properties
var my_object = {
  foo: 'bar',
  nothing: null
};
my_object.foo;            // => 'bar'
my_object.nothing;        // => null
my_object.missing;        // => undefined

// Find all properties of an object using Object.keys
Object.keys(my_object);   // => ['foo', 'nothing']

// Find out if an object has a specific property (non-inherited)
my_object.hasOwnProperty('foo');    // => true

// Set new properties
my_object.new_property = 5;
my_object.new_property;   // => 5

