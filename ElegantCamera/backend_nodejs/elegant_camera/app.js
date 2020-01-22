var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');


//  router of path
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/user/users');
var cameraStickerRouter = require('./routes/camera_source/sticker');
var article = require('./routes/article/article')

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views')); // views的目录
app.set('view engine', 'pug'); // 设置了渲染迎请， 还偶像灭幼其他的地方设置了

app.use(logger('dev'));
app.use(express.json()); // 使用json数据
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public'))); // 设置静态的目录

// mark down
const md = require('markdown-it')()
var result = md.render('# markdown')

//  router need to do 
app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/camera_sticker', cameraStickerRouter);
app.use('/article', article);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
