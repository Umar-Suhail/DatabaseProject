const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const multer = require('multer');
const User = require('../models/user');
const checkAuth = require('../middleware/authorization');

const storage = multer.diskStorage({
    destination: function(req, file, cb) {
      cb(null, './uploads/');
    },
    filename: function(req, file, cb) {
        cb(null, Date.now() + file.originalname); 
    }
  });
  const fileFilter = (req, file, cb) => {
    // reject a file
    if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/png') {
      cb(null, true);
    } else {
      cb(null, false);
    }
  };
  
  const upload = multer({
    storage: storage,
    limits: {
      fileSize: 1024 * 1024 * 5
    },
    fileFilter: fileFilter
  });
      
  const Book = require('../models/book');

router.get('/',(req, res, next) =>{
    Book.find()
    .select('_id name price bookImage user')
    .populate('user', 'fullName address mobNo')
    .exec()
    .then(result=>{
        console.log(result);
        res.status(200).json({
            count: result.length,
            books: result
        });
    })
    .catch(err =>{
        console.log(err);
        res.status(500).json({error: err});
    });
   
});


router.post('/',checkAuth, upload.single('bookImage'),(req, res, next) =>{
    console.log(req.file);
    const book = new Book({
        _id:  new mongoose.Types.ObjectId(),
        name: req.body.name,
        price: req.body.price,
        bookImage: req.file.path,
        user: req.body.userID
    });
    book.save()
    .then(result =>{
        console.log(result);
        res.status(201).json({
            message: "book added successfully",
            bookAdded: {
                name: result.name,
                price: result.price,
                _id: result._id,
                bookImage: result.bookImage,
                user: result.userID
            } 
        });
    })
    .catch(err =>{
        console.log(err);
        res.status(500).json({
            error: err
        });
    });

});

router.get('/:bookID',checkAuth, (req, res, next) =>{
    const id = req.params.bookID;
    Book.findById(id)
    .select('_id name price bookImage user')
    .populate('user, name address mobNo')
    .exec()
    .then(result =>{
        console.log("from Db", result);
        if (result){
        res.status(200).json({
            book: result
        });
        } else {
            res.status(404).json({message: "invalid object id passed"});
        }
    })
    .catch(err =>{
        console.log(err);
        res.status(500).json({error: err});
    });
});

router.patch('/:bookID',checkAuth, (req, res, next) =>{
    const id = req.params.bookID;
    const updateOperation ={};
    for(const ope of req.body){
        updateOperation[ope.propertyName]= ope.value;
    }

    Book.update({_id: id}, { $set: updateOperation})
    .exec()
    .then(result =>{
        res.status(200).json({
            message: 'Product updated',
        });
      })
    .catch(err =>{
        console.log(err);
        res.status(500).json({
            error: err
        });
    });
});

router.delete('/:bookID',checkAuth, (req, res, next) =>{
    const id = req.params.bookID;
    Book.remove({_id: id})
    .exec()
    .then(result => {
        res.status(200).json({
            message: "Book deleted"
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