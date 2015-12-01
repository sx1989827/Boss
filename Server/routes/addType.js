/**
 * Created by sunxin on 15/11/13.
 */
var express = require('express');
var type=require("../model/typeModel");
var router = express.Router();

router.get('/', function(req, res, next) {
    type.find().exec(function (err, result) {
        //var arrType=[];
        //for(var arr in result)
        //{
        //    arrType.push(result[arr].name);
        //}
        var arrType =result;
        res.render("addType", {title: "添加语言类型",  type: arrType});
    })
}).post("/",function(req,res)
{
    var name=req.body.type;
    var des=req.body.des;
    type.create({
        name:name,
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
    type.remove({_id:req.body.id},function(err){
        if(!err)
        {
            res.send("ok");
        }
    });
});
router.put("/",function(req,res){
    type.update({_id:req.body.id},{$set:{"name":req.body.name,"des":req.body.des}},function(err){
        if(!err)
        {
            res.send("ok");
        }
    });
});
module.exports = router;