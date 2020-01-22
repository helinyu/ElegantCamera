
var UserModel = require('UserModel');

export default class DB {
    connectDb() {
        var MongoClient = require('mongodb').MongoClient;
        var url = 'mongodb://localhost:27017/user';
        MongoClient.connect(url, function(err, db) {
          console.log("lt - error :" + err + "db" + db);
          if (err) {
            console.log("lt - error :" + err + "db" + db);
            throw err;
            return null;
          }
          else {
              console.log("it - is succeed");
              return db;
          }
        })
    }
}