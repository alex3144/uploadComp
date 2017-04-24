http = require('http'),
util = require('util'),
path = require("path");
var busboy = require('../uploadTraitement/busboy.js')
var gridfs = require('../uploadTraitement/gridfs.js')
var express = require('express');
var router = require('router');
var app = express();


app.get('/', function (req, res) {
    console.log(__dirname);
    res.sendFile(path.join(__dirname + '/index.html'));
});


app.post('/upload', function (req, res) {
    if (req.method === 'POST') {
        busboy.busboyParser(req, res, gridfs.write, 'test.txt');
        res.sendFile(path.join(__dirname + '/index.html'));
    }
});

app.listen(8080, function () {
});
