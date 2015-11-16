/**
 * Created by sunxin on 15/11/13.
 */
var express = require('express');
var level=require("../model/levelModel");
var type=require("../model/typeModel");
var router = express.Router();

router.get('/', function(req, res, next) {
    type.find().exec(function(err,result) {
        var arrType = result;
        level.find().exec(function (err, result) {
            var arrLevel = result;
            res.render("addLevel", {title: "添加等级", level: arrLevel,type:arrType});
        });
    });
}).post("/",function(req,res)
{
    var type=req.body.type;
    var name=req.body.name;
    var degree=req.body.degree;
    var time=req.body.time;
    var step=req.body.step;
    var enemy=req.body.enemy;
    level.create({
        name:name,
        type:type,
        degree:degree,
        time:time,
        step:step,
        enemy:enemy
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