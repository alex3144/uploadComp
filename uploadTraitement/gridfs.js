var fs = require('fs');
var mongoose = require("mongoose");
mongoose.connect('mongodb://127.0.0.1/local');
var Grid = require('gridfs-stream');
var GridFS = Grid(mongoose.connection.db, mongoose.mongo);

var write = function(filename, writefile ){
    //On prepare un flux d'ecriture sur mongo
    var writestream = GridFS.createWriteStream({
        filename: filename,
    });

   ///on  pipe le readstream avec l'ecriture en mongoo
   writefile.pipe(writestream);

	writestream.on('close', function (file) {
		console.log("vous venez d'upload : " + file.filename)
	})
}

var read = function(filename, writefile){
	//On stock dans une variable le ficher en ecriture
	var fs_write_stream = fs.createWriteStream(writefile);
	
	//On prepare mongo a la lecture d'un file via le le filename
	var readstream = GridFS.createReadStream({
	    filename: filename,
	});

	//On pipe les deux pour ecrire le fichier de mongo dans un fichier dans notre container 
	readstream.pipe(fs_write_stream);
	fs_write_stream.on('close', function () {
	    console.log('traitement terminé');
	})
}	

exports.read = read;
exports.write = write
