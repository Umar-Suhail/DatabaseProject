const express = require('express');
const router = express.Router();
const User = require('../models/user');
const bcrypt = require('bcryptjs');
const Joi = require('@hapi/joi');
const jwt = require('jsonwebtoken');
const mongoose = require('mongoose');
const checkAuth = require('../middleware/authorization');

//validation
const schema = {
    email: Joi.string().min(10).email().required(),
    password: Joi.string().min(4).required(),
    fullName: Joi.string().required(),
    address: Joi.required(),
    mobNo: Joi.required()
};

router.post('/register', async (req,res) => {

     //validate the input
     const {error} = Joi.validate(req.body, schema);
     if(error) return res.status(400).send(error.details[0].message);

    //duplicate email
    const emailExist = await User.findOne({email: req.body.email});
        if (emailExist) return res.status(400).send('email already exists');
       

    //Hashig
    const salt = await bcrypt.genSalt(10);
    const hashed = await bcrypt.hash(req.body.password, salt);
    
    const user = new User({
        _id: mongoose.Types.ObjectId(),
        email: req.body.email,
        password: hashed,
        fullName: req.body.fullName,
        mobNo: req.body.mobNo,
        address: req.body.address
        
    });
    user.save()
    .then(result =>{
        console.log(result);
        res.status(201).json({
            message: 'user created'
        });
    })
    .catch(err =>{
        res.status(500).json({
            error: err
        });
    });
});

router.post("/login", (req, res, next) => {
    User.find({email: req.body.email })
      .exec()
      .then(user => {
        if (user.length < 1) {
          return res.status(401).json({
            message: "Auth failed"
          });
        }
        bcrypt.compare(req.body.password, user[0].password, (err, result) => {
          if (err) {
            return res.status(401).json({
              message: "Auth failed"
            });
          }
          if (result) {
            const token = jwt.sign(
              {
                email: user[0].email,
                userId: user[0]._id
              },
              process.env.JWT_KEY,
              {
                  expiresIn: "1h"
              }
            );
            return res.status(200).json({
              message: "Auth successful",
              token: token
            });
          }
          res.status(401).json({
            message: "Auth failed"
          });
        });
      })
      .catch(err => {
        console.log(err);
        res.status(500).json({
          error: err
        });
      });
  });
  

router.delete("/:userId",checkAuth, (req, res, next) => {
    User.remove({ _id: req.params.userId })
      .exec()
      .then(result => {
        res.status(200).json({
          message: "User deleted"
        });
      })
      .catch(err => {
        console.log(err);
        res.status(500).json({
          error: err
        });
      });
  });
  
module.exports = router;