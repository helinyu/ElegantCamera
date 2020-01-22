var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
    res.render('./camera_sticker/sticker', { title: '贴纸首页' });
    // res.render('index', { title: 'Express' });
});

module.exports = router;
 