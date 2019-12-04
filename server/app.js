const express = require('express');
const app = express();
const morgan = require('morgan');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
mongoose.Promise = global.Promise;


const userRoute = require('./routes/user');
const booksroute = require('./routes/books');
const ordersroute = require('./routes/orders');

mongoose.connect('mongodb+srv://book-exchange:'+ process.env.Mongo_Atlas_pass +'@book-exchange-ggjqo.mongodb.net/test?retryWrites=true&w=majority',
{ useNewUrlParser: true,
    useUnifiedTopology: true }
);
app.use(morgan('dev'));
app.use('/uploads', express.static('uploads'));
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

app.use((req, res, next) =>{
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow_headers", "*");
    if (req === 'OPTIONS'){
        res.header('Access-Control-Allow-Methods', 'PUT, POST, PATCH, DELETE, GET');
        return res.status(200).json({});
    }
    next();
});

//routes handling incoming requests
app.use('/user', userRoute);
app.use('/books', booksroute);
app.use('/orders', ordersroute);

//handling errors

app.use((req, res, next) =>{
    const error = new Error('not found');
    error.status = 404;
    next(error);
});

app.use((error, req, res, next) =>{
    res.status(error.status || 500);
    res.json({
        error:{
        message: error.message
        }
    });
});
module.exports = app;
