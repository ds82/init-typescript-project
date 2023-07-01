#!/bin/bash

NAME=$1
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mkdir $NAME
echo $(node --version | grep -o -E '[0-9\.]*') > $NAME/.nvmrc 
cd $NAME
DIR=$(pwd)

git init
npm init -y

mkdir src
touch src/index.ts

npm install -D typescript @types/node nodemon rimraf npm-run-all ts-node \
  supertest @types/supertest jest @types/jest ts-jest \
  @typescript-eslint/parser @typescript-eslint/eslint-plugin eslint prettier eslint-config-prettier

npx tsc --init

cp $SCRIPT_DIR/tsconfig.json .
cp $SCRIPT_DIR/jest.config.js .
cp $SCRIPT_DIR/eslintrc.js ./.eslintrc.js

cp $SCRIPT_DIR/gitignore-dist ./.gitignore

jq -s '.[0] * .[1]' $DIR/package.json $SCRIPT_DIR/package-json.overlay.json
