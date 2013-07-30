var Logger;
var greeter, tayZonday, zombieKid;

// A constructor that returns a function object
function Logger(message) {
  // set function to a variable
  var logger = function() {
    console.log(message);
  };

  // return the logger.  Don't use parentheses to
  // return the function object rather than the
  // result of the function
  return logger
}

// Each Logger returns a custom function!
greeter   = new Logger('hello world');
tayZonday = new Logger('Chocolate Rain');
zombieKid = new Logger('I like turtles');

greeter();    // => 'hello world'
tayZonday();  // => 'Chocolate Rain'
zombieKid();  // => 'I like turtles'

