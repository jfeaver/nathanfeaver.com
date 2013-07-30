// A function that can log it's own message property
var logger = self = function() {
  console.log(self.message);
}
logger.message = 'hello world';

// Grab some copies of the function to log different messages
var tayZonday = logger;
tayZonday.message = 'Chocolate Rain';

var zombieKid = logger;
zombieKid.message = 'I like turtles';

logger();     // => 'hello world'
tayZonday();  // => 'Chocolate Rain'
zombieKid();  // => 'I like turtles'

