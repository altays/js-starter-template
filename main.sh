#! /bin/bash

echo "Enter the name of the project"
read name
echo "Enter a description for the project"
read description

mkdir $name

cd $name
mkdir data scripts data/raw data/processed
touch scripts/helper.js scripts/specific.js main.js test.js README.md .gitignore main.sh

# put template text for helper file -> file system, async functions, exports
cat <<EOT >> ./scripts/helper.js
const fs = require('node:fs/promises');

async function readwrite (filePath, outputFileName) {
 
    try {
        const data = await fs.readFile(filePath, { encoding: 'utf8' });
        await fs.writeFile(outputFileName,data);
    } 
    catch (error){
        console.error(error)
    }
}

module.exports = { readwrite }
EOT

# set up similar template -> module.exports at bottom
cat <<EOT >> ./scripts/specific.js

EOT

# routing template, modules
cat <<EOT >> main.js
const process = require('process');
const utility = require('./scripts/helper')

const processRoute = process.argv[2]
const inputName = process.argv[3]

if (processRoute=="a"){
    console.log('route a...')

} else if (processRoute=="b") {
    console.log('route b...')
} else {
    console.log('please indicate a route')
}
EOT

cat <<EOT >> README.md
# $name
$description
EOT

cat <<EOT >> .gitignore
node_modules
data
test.js
EOT

# routing
cat <<EOT >> main.sh
#! /bin/bash

# variable examples
rawHTML="poemaday.html"
scrapedText="AsKar.txt"
url="https://poets.org/poem-a-day"

if [ "\$1" = "a" ] 
then
    echo "route a"
    node main.js a
elif [ "\$1" = "ct" ]
then
    echo "route b"
    node main.js b
else
    echo "Please indicate a valid route."
fi
EOT

npm init -y
rm package.json
touch package.json

cat <<EOT >> package.json
{
  "name": "$name",
  "version": "1.0.0",
  "description": "$description",
  "main": "main.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "Alex Taylor",
  "license": "ISC"
}
EOT