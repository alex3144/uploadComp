<upload>
  <div class="container">
    <div class="row">
      <div class="col-xs-12">
        <div class="panel panel-default">
          <div class="panel-body">
            <span class="glyphicon glyphicon-cloud-upload"></span>
            <h2>Uploader votre fichier</h2>
            <h4>Sementic-bus</h4>
            <div class="progress">
              <div class="progress-bar" role="progressbar"></div>
            </div>
            <button class="btn btn-lg upload-btn" type="button">Telecharger</button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <input id="upload-input" type="file" name="uploads[]"></br>
<style>
  upload {
    height: 100%;
    background-color: #4791D2;
  }

  upload {
    text-align: center;
    font-family: 'Raleway', sans-serif;
  }
 </style>
<style scope>
  .btn:focus, .upload-btn:focus{
    outline: 0 !important;
  }



  .row {
    margin-top: 80px;
  }

  .upload-btn {
    color: #ffffff;
    background-color: #F89406;
    border: none;
  }

  .upload-btn:hover,
  .upload-btn:focus,
  .upload-btn:active,
  .upload-btn.active {
    color: #ffffff;
    background-color: #FA8900;
    border: none;
  }

  h4 {
    padding-bottom: 30px;
    color: #B8BDC1;
  }

  .glyphicon {
    font-size: 5em;
    color: #9CA3A9;
  }

  h2 {
    margin-top: 15px;
    color: #68757E;
  }

  .panel {
    padding-top: 20px;
    padding-bottom: 20px;
  }

  #upload-input {
    display: none;
  }

  @media (min-width: 768px) {
    .main-container {
      width: 100%;
    }
  }

  @media (min-width: 992px) {
    .container {
      width: 450px;
    }
  }
</style>

  <script>
    $('.upload-btn').on('click', function (){
        $('#upload-input').click();
        $('.progress-bar').text('0%');
        $('.progress-bar').width('0%');
    });

    $('#upload-input').on('change', function(){

      var files = $(this).get(0).files;
      if (files.length > 0){
        // create a FormData object which will be sent as the data payload in the
        // AJAX request
        var formData = new FormData();

        // loop through all the selected files and add them to the formData object
        for (var i = 0; i < files.length; i++) {
          var file = files[i];

          // add the files to formData object for the data payload
          formData.append('uploads[]', file, file.name);
        }

        $.ajax({
          url: '/upload',
          type: 'POST',
          data: formData,
          processData: false,
          contentType: false,
          success: function(data){
              console.log('upload finis');
          },
          xhr: function() {

            var xhr = new XMLHttpRequest();

            xhr.upload.addEventListener('progress', function(evt) {

              if (evt.lengthComputable) {
                // calcule du pourcentage de l'upload
                var percentComplete = evt.loaded / evt.total;
                percentComplete = parseInt(percentComplete * 100);

                // changement design bar telechargement
                $('.progress-bar').text(percentComplete + '%');
                $('.progress-bar').width(percentComplete + '%');

                // affichage resultat
                if (percentComplete === 100) {
                  $('.progress-bar').html('Téléchargement terminé');
                }

              }

            }, false);
            return xhr;
          }
        });
      }
    });
  </script>
  </uplaod>
