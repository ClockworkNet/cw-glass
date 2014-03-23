module.exports = function(server) {

	server.namespace('/api', function() {


    server.get('/cors', function(req, res){
      // var request = require('request');

      // request(req.query.url)
      //   .pipe(res);
        
      // res
      //   .writeHead(200, {
      //     'Access-Control-Allow-Origin' : '*',
      //     'Content-Type'                : 'application/json'
      // });
 
    });
		// Return fixture data for '/api/posts/:id'
		server.get('/posts/:id', function(req, res) {
			var post = {
              "post": {
              "id": 1,
              "title": "Rails is omakase",
              "comments": ["1", "2"],
              "user" : "dhh"
          },

          "comments": [{
            "id": "1",
            "body": "Rails is unagi"
          }, {
            "id": "2",
            "body": "Omakase O_o"
          }]
					};

			res.send(post);
		});

	});

};