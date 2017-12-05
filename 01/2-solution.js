"use strict";
const fs = require("fs");

fs.readFile("input", "utf8", function(error, num) {
  num = num.split("").map(Number).filter(Boolean);
  const ln = num.length;

  let cmp, sum = 0;
  for(let i = 0; i < ln; i++) {
    cmp = i + (ln / 2);
    if(cmp >= ln) cmp -= ln;
    if(num[i] === num[cmp]) sum +=num[i];
  }
  console.log(sum);
})
