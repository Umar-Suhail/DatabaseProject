const jwt = require('jsonwebtoken');

module.exports=  (req,res,next)=> {
    const token = req.header('auth-token');
    if(!token) return res.status(401).send('access denied');
    try{
         const verified = jwt.verify(token, process.env.JWT_KEY);
        req.user = verified;
    next();
    }catch(err){
        return res.status(401).json({
            message: 'access debied'
        });
    }
    
};