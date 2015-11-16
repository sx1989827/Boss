/**
 * Created by sunxin on 15/11/13.
 */
var express = require('express');
var type=require("../model/typeModel");
var router = express.Router();

router.get('/', function(req, res, next) {
    type.find().exec(function (err, result) {
        var arrType=[];
        for(var arr in result)
        {
            arrType.push(result[arr].name);
        }
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
});
module.exports = router;