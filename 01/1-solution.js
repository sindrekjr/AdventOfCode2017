"use strict";
const fs = require("fs");

fs.readFile("input", "utf8", function(error, num) {
  num = num.split("").map(Number).filter(Boolean);

  let sum = 0;
  for(let i = 0, ln = num.length; i < ln; i++) {
    if((i + 1) === ln) {
      if(num[i] === num[0]) {
        sum += num[i];
      }
    } else {
      if(num[i] === num[i + 1]) sum += num[i];
    }
  }
  console.log(sum);
})
