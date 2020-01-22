var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {

  var MongoClient = require('mongodb').MongoClient;
  var url = 'mongodb://localhost:27017/user';
  MongoClient.connect(url, function(err, db) {
    console.log("lt -msg error :" + err + "db" + db);
    if (err) {
      console.log("lt - error :" + err + "db" + db);
      throw err;
    }

    var dbase = db.db("user");

    dbase.collection('user_info').find().toArray(function(err, result) {
      if (err) {
        throw err;
      }
      result.forEach(element => {
        console.log("lt- element :" + element);
        console.log("lt- value name :" +  element["name"]);
        console.log("lt- value device_id :" +  element["device_id"]);
        
      });
      
      console.log(result);
      res.render('./user/user', { title: '用户列表', userList:result });
    });
  });

  // res.render('./user/user', { title: '用户列表' });
});

module.exports = router;
