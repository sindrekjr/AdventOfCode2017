fs = require("fs");

fs.readFile('input', 'utf8', function(error, num) {
  if(error) {
    console.log(error);
    return;
  }

  num = num.replace(/\s/g,'').split('');

  var sum = 0;
  for(let i = 0; i < num.length; i++) {
    if((i + 1) === num.length) {
      if(num[i] === num[0]) {
        sum += parseInt(num[i]);
      }
    } else {
      if(num[i] == num[i + 1]) sum += parseInt(num[i]);
    }

  }

  console.log(sum);
})
