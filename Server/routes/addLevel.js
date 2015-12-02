/**
 * Created by sunxin on 15/11/13.
 */
var express = require('express');
var level=require("../model/levelModel");
var type=require("../model/typeModel");
var people=require("../model/peopleModel");
var router = express.Router();

router.get('/', function(req, res, next) {
    type.find().exec(function(err,result) {
        var arrType = result;

        people.find().exec(function(err,result){
            var arrPeople =result;
            level.find().exec(function (err, result) {
                var arrLevel = result;
                for(var i=0;i<arrLevel.length;i++)
                {
                    var item =arrLevel[i];
                    var arrEnemy =item["enemy"];
                    var newEnemy=[];
                    for(var j=0;j< arrEnemy.length;j++)
                    {
                        var enemy=arrEnemy[j];
                        var levels=[];
                        levels.push(enemy.name);
                        levels.push(enemy.count);
                        newEnemy.push(levels);
                    }
                    item["enemy"]=JSON.stringify(newEnemy);
                }
                res.render("addLevel", {title: "添加等级", level: arrLevel,type:arrType,people:arrPeople});
            });
        });
    });
}).post("/",function(req,res)
{
    var type=req.body.type;
    var name=req.body.name;
    var degree=parseInt(req.body.degree);
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
}).delete("/",function(req,res){
    level.remove({_id:req.body.id},function(err){
        if(!err)
        {
            res.send("ok");
        }
    });
});
router.put("/",function(req,res){
    level.update({_id:req.body.id},{"$set" : {"name" :req.body.name,"degress":req.body.degree,"type":req.body.type,"time":req.body.time,"step":req.body.step,"enemy":req.body.enemy}},function(err)
    {
        if(!err)
        {
            res.send("ok");
        }
    });
});
module.exports = router;