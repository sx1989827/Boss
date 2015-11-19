/**
 * Created by sunxin on 15/11/16.
 */
var express = require('express');
var router = express.Router();
var user=require("../model/userModel");
var con=require("../define/define");
//获取排名
router.get("/top",function(req,res)
{
    var index=parseInt(req.query.page);
    if(index<0)
    {
        res.json({
            code:1,
            msg:"页数不正确"
        })
        return;
    }
    user.find({},{_id:0}).sort({score:-1}).skip(index*10).limit(10).select("name photo score").exec(function(err,result)
    {
        if(err)
        {
            res.json({
                code:1,
                msg:err.message
            })
            return;
        }
        res.json({
            code:0,
            data:result
        })
    });
});

module.exports = router;






