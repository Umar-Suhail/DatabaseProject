const mongoose = require('mongoose');
const bookSchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    name: { type: String, required: true },
    price: { type: Number, required: true },
    bookImage: { type: String, required: true },
    user: {type: mongoose.Schema.Types.ObjectId, ref:'User', required:true}
});
module.exports = mongoose.model('Book', bookSchema);