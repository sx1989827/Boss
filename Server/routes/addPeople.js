/**
 * Created by sunxin on 15/11/13.
 */
var express = require('express');
var people=require("../model/peopleModel");
var router = express.Router();

router.get('/', function(req, res, next) {
    people.find().exec(function(err,result) {
        var arrPeople = result;
        res.render("addPeople", {title: "添加人员", people:arrPeople});
    });
}).post("/",function(req,res)
{
    var talk=req.body.talk;
    var name=req.body.name;
    var money=req.body.money;
    var speed=req.body.speed;
    var des =req.body.des;
    people.create({
        name:name,
        talk:talk,
        money:money,
        speed:speed,
        des:des
    },function(err,result)
    {
        if(err)
        {
            console.log(err.message);
        }
        res.send("ok");
    });
}).delete("/",function(req,res) {
    people.remove({_id:req.body.id},function(err){
        if(!err)
        {
            res.send("ok");
        }
    });
});
router.put("/",function(req,res){
    people.update({_id:req.body.id},{$set:{"name":req.body.name,"money":req.body.money,"talk":req.body.talk,"speed":req.body.speed,"des":req.body.des}},function(err){
        if(!err)
        {
            res.send("ok");
        }
    });
});
module.exports = router;