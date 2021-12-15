(function(){
    var x = 0;
    setInterval(function(){
        x-=1;
        ('App-header').css('background-position', x + 'px 0');
    }, 300);
  })

  