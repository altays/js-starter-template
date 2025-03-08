#! /bin/bash

echo "Enter the name of the project"
read name
echo "Enter a description for the project"
read description
echo "Enter the year"
read year

cd ..
mkdir $name

cd $name
mkdir data scripts data/raw data/processed
touch scripts/helper.js scripts/specific.js main.js test.js README.md .gitignore main.sh LICENSE

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

# routing template, modules
cat <<EOT >> main.js
const process = require('process');
const utility = require('./scripts/helper')
const specific = require('./scripts/specific')

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

cat <<EOT >> LICENSE
MIT License

Copyright (c) $year Alex Taylor

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOT
