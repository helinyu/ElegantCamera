var express = require('express');
var router = express.Router();

router.get('/article', function(req, res, next) {
    const title = 'article'
    res.render('./articles/article', { title:"article" });
})

module.exports = router;
 