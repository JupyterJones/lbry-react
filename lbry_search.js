#!/home/jack/.nvm/versions/node/v10.19.0/bin/node
if (process.argv.length <= 2) {
    console.log("Usage: " + __filename + "Please give a starting page: number ");
    process.exit(-1);
}

var param = process.argv[2];
console.log('Start Page: ' + param);

const shell = require('shelljs')
const readline = require('readline').createInterface({
   input: process.stdin,
   output: process.stdout
});

readline.question('Search for what ? ', topic => {
   console.log(`Search for: ${topic}!`);
   shell.exec(`lbrynet claim search --text=${topic} --page=${param} >>${topic}.txt`);
   console.log(`\n`,`The search results are in: ${topic}.txt`);

setTimeout(function() {
   const readLastLines = require('read-last-lines');
   readLastLines.read(`${topic}.txt`, 5)
   .then((lines) => console.log('\n',lines));
   }, 3000);

readline.close();
});



