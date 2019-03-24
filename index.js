// index.js
'use strict';

import {
  Elm
} from './src/Main.elm';
// var Elm = require('./src/Main.elm');
var mountNode = document.getElementById('elm-app');

// The third value on embed are the initial values for incomming ports into Elm
var app = Elm.Main.init({
  node: mountNode,
  flags: {}
});