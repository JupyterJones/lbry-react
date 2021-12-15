const lbry = require('lbry-nodejs')

lbry.get('Disaster')
.then((data) => console.log(data))
.catch((error) => console.error(error))
