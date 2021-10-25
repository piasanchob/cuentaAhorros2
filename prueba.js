//Declare global variable
var http = require('http');
var events = require('events');
var nodemailer = require('nodemailer');
var sql = require('mssql');<br/>
var Request = require('tedious').Request;  
var TYPES = require('tedious').TYPES; 
//Create an http server
http.createServer(function(req,res)
{
res.writeHead(200, {'Content-Type': 'text/html'});
 var Connection = require('tedious').Connection; 
//Configure the connection 
    var config = {  
        userName: '<user id>',  
        password: '<password>',  
        server: '<system ip>',  
        options: {database: '<database name>'}  
    };  
    var connection = new Connection(config);  
    connection.on('connect', function(err) {  
        console.log("Connected"); 
        executeStatement();     
    }); 

function executeStatement() {  
        request = new Request("select getdate();", function(err) {  
        if (err) {  
            console.log(err);}  
        });
     var result = "";  
        request.on('row', function(columns) {  
            columns.forEach(function(column) {  
              if (column.value === null) {  
                console.log('NULL');  
              } else {  
                result+= column.value + " ";  
              }  
            });  
            console.log(result);  
            result ="";  
        });  

        connection.execSql(request);  
};
  return res.end();
}).listen(8080);