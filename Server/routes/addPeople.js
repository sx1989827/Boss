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
    people.create({
        name:name,
        talk:talk,
        money:money,
        speed:speed
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