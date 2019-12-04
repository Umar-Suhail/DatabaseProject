const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId, 
    email: {
        type: String,
        required: true,
    },

    password: {
        type: String,
        required: true
    },

    fullName: {
        type: String,
        required: true
    },
    address:{
        type: String,
        required: true
    },
    mobNo:{
        type: String,
        required: true
    }

});

module.exports= mongoose.model('User', UserSchema);