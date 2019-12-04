const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const Order = require('../models/order');
const Book = require('../models/book');
const checkAuth = require('../middleware/authorization');
router.get('/',checkAuth,(req, res, next) =>{
    Order.find()
    .select('_id book quantity')
    .populate('book', 'name price')
    .exec()
    .then(result =>{
        console.log(result);
        res.status(200).json({
            count: result.length,
            orders: result
        });
    })
    .catch(err =>{
        console.log(err);
        res.status(500).json({
            error: err
        });
    });
});
router.post('/',checkAuth,(req, res, next) =>{
    Book.findById(req.body.bookID)
    .then(book =>{
        if(!book){
            return res.status(404).json({
                message: "book not found"
            });
        }
        const order = new Order({
            _id: new mongoose.Types.ObjectId(),
            book: req.body.bookID,
            quantity: req.body.quantity
        });
       return order
    .save()
    .then(result => {
            console.log(result);
            res.status(201).json({
                message: "order added successfully",
                orderkAdded: {
                    quantity: result.quantity,
                    book: result.book,
                    _id: result._id
                } 
            });
        })

    })
    .catch(err =>{
        
        res.status(500).json({
            error: err
        });
    });  
    }); 

router.get('/:orderID',checkAuth, (req, res, next) =>{
    Order.findById(req.params.orderID)
    .populate('book', 'name price')
    .exec()
    .then(result =>{
        if(!result){
            return res.status(404).json({
                message: "orderID not found"
            });
        }
        console.log(result);
        res.status(200).json(result);
    })
    .catch(err =>{
        console.log(err);np
        res.status(500).json({
            error: err
        });
    });
});

router.delete('/:orderID',checkAuth, (req, res, next) =>{
    Order.remove({_id: req.params.orderID})
    .exec()
    .then(result =>{
        console.log(result);
        res.status(200).json({
            message: "order deleted"
        });
    })
    .catch(err =>{
        console.log(err);
        res.status(500).json({
            error: err
        });
    });
});
module.exports = router; 