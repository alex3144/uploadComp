var Busboy = require('busboy');
var gridfs = require('./gridfs.js')

var busboyParser = function(req, res, callback, newfilename){
	var busboy = new Busboy({ headers: req.headers });
   
    busboy.on('file', function (fieldname, file, filename, encoding, mimetype) {
        callback(newfilename, file);
    })
    
    busboy.on('finish', function () {
        console.log("nous avons terminé de traiter la requete");
        res.statusCode = 200;
    }); 

    req.pipe(busboy)     
}

exports.busboyParser = busboyParser;
