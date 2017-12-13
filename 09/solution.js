"use strict";
const fs = require("fs");

fs.readFile("input", "utf8", function(error, input) {
  let score = 0, start = 1;
  let garbage = false;
  input = input.trim().split("");

  for(let i = 0; i < input.length; i++) {
    switch (input[i]) {
      case "!":
        i++;
        break;
      case ">":
        garbage = false;
        break;
      case "<":
        garbage = true;
        break;
      case "{":
        if(!garbage) score += start++;
        break;
      case "}":
        if(!garbage) start--;
        break;
      default:
        break;
    }
  }
  console.log(score);
});
