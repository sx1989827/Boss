/**
 * Created by sunxin on 15/12/10.
 */
var express = require('express');
var router = express.Router();
var user=require("../model/userModel");
var level=require("../model/levelModel");
var type=require("../model/typeModel");
var item=require("../model/itemModel");
var record=require("../model/recordModel");
var con=require("../define/define");

router.get("/",function(req,res)
{
    var arrItem=req.query.item.split(",");
    item.find({_id:{$in:arrItem}}).select("_id power content answer").exec(function(err,result)
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
        });
    });
});

module.exports = router;