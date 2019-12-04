const mongoose = require('mongoose');
const orderSchema = mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    quantity: {type: Number, default: 1},
    book: {type: mongoose.Schema.Types.ObjectId, ref: 'Book', required: true},
});
module.exports = mongoose.model('Order', orderSchema);