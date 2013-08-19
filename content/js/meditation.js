(function(){
  var d = new Date();
  var monthNames = [ "january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december" ];
  var month = monthNames[d.getMonth()];
  var time = ((d.getHours() < 12) ? "Morning" : "Evening");

  function zero_padded(i) {
    var str = String(i);
    return ((str.length < 2) ? '0' + str : str);
  }

  function datetime_string(d) {
    var time_string = ((d.getHours() < 12) ? "06:00:00Z" : "18:00:00Z");
    //1990-12-31T23:59:60Z
    return d.getFullYear() + '-' + zero_padded(d.getMonth()) + '-' + zero_padded(d.getDate()) + 'T' + time_string;
  };

  function capitalize(string)
  {
    return string.charAt(0).toUpperCase() + string.slice(1);
  }

  //replace date stuff
  $('time').html(
    time + ', ' + capitalize(month) + ' ' + d.getDate()
  ).attr(
    'datetime',
    datetime_string(d)
  );

  function passage_partial(passage, book, chapter, verse) {
    return '<blockquote class="passage"><p>' + passage + '</p><p class="scripCitation">—' + book + ' ' + chapter + ':' + verse + '</p></blockquote>';
  };

  function paragraph_partial(content) {
    return '<p>' + content + '</p>';
  };

  var readings_url = 'assets/readings/' + month + '_' + zero_padded(d.getDate()) + '.json';
  $.getJSON(
    // json endpoint
    readings_url,
    // The success callback
    function(today) {
      // Get the entry object and use the morning or evening reading depending on time
      var reading = today.entry[time];
      var passages = [];
      $.each(reading.verses, function(i) {
        var verse = reading.verses[i];
        var reference = verse.reference;
        passages.push(passage_partial(verse.passage, reference.book, reference.chapter, reference.verse));
      });
      var all_passages = passages.join('');
      $('.scripRef').html(all_passages);
      var paragraphs = [];
      $.each(reading.reading, function(i) {
        var paragraph = reading.reading[i];
        paragraphs.push(paragraph_partial(paragraph));
      });
      $('.reading').html(paragraphs.join(''));

    // \callback
    }
  // \getJSON
  );

}).call(this);

