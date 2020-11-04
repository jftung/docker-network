#!/bin/bash

./node_modules/.bin/prettier -w * .github/ .eslintrc.json
./node_modules/.bin/eslint --fix beale/html/
