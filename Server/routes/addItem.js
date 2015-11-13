/**
 * Created by sunxin on 15/11/13.
 */
var express = require('express');
var type=require("../model/typeModel");
var level=require("../model/levelModel");
var power=require("../model/powerModel");
var item=require("../model/itemModel");
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    power.find({}).exec(function(err,result)
    {
        var arrPower=result;
        level.find().exec(function(err,result)
        {
            var arrLevel=result;
            type.find().exec(function(err,result)
            {
                var arrType=result;
                res.render("addItem",{title:"添加题目",power:arrPower,level:arrLevel,type:arrType});
            })
        });
    });
}).post("/",function(req,res)
{
    var type=req.body.type;
    var level=req.body.level;
    var power=req.body.power;
    var content=req.body.question;
    var ansJson=req.body.answer;
    var json=[];
    for(var arr in ansJson)
    {
        var arrJson=ansJson[arr];
        var ok=arrJson[0];
        arrJson.splice(0,1);
        json.push({ok:ok,wrong:arrJson});
    }
    item.create({
        type:type,
        level:level,
        power:power,
        content:content,
        answer:json
    },function(err,result)
    {
        if(err)
        {
            console.log(err.message);
        }
        res.send("ok");
    });
});
module.exports = router;
