/**
 * Created by sunxin on 15/11/19.
 */
var express = require('express');
var router = express.Router();
var power=require("../model/powerModel");
//获取子弹信息
router.get("/info",function(req,res)
{
    power.find({},{_id:0}).exec(function(err,result){
        if (err) {
            res.json({
                code: 1,
                msg: err.message
            })
            return;
        }
        res.json({
            code:0,
            data:result
        })
    });
});

module.exports=router;