"use strict";
const fs = require("fs");

fs.readFile("input", "utf8", function(error, num) {
  num = num.split("").map(Number).filter(Boolean);

  let cmp, sum1 = 0, sum2 = 0;
  for(let i = 0, ln = num.length; i < ln; i++, cmp = i + (ln / 2)) {
    if((i + 1) === ln && num[i] === num[0]) sum1 += num[i];
    else if(num[i] === num[i + 1]) sum1 += num[i];

    if(cmp >= ln) cmp -= ln;
    if(num[i] === num[cmp]) sum2 +=num[i];
  }
  console.log("Part 1: " + sum1 + "\nPart 2: " + sum2);
})
