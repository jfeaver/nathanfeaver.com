function Apprentice() {
  this.master = "Nathan";
  this.years_remaining = 5;
}

// Use the function as a constructor
var student = new Apprentice();
student.master;         // => "Nathan"

// Using the function in the global context
// will set properties on the window object
// (window is the currently assigned to `this`)
Apprentice();
window.years_remaining; // => 5

// Functions are still objects:
// You can add properties to them but this is rarely done in practice
Apprentice.levels = ['noob', 'intermediate', 'advanced'];
Apprentice.constructor = function() {
  this.level = Apprentice.levels[0];
}

var student2 = new Apprentice();
student2.level;         // => 'noob'

// The old constructor was overwritten
student2.master;        // => undefined

