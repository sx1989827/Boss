/**
 * Created by sunxin on 15/11/16.
 */
var express = require('express');
var router = express.Router();
var user=require("../model/userModel");
var level=require("../model/levelModel");
var type=require("../model/typeModel");
var item=require("../model/itemModel");
var record=require("../model/recordModel");
var con=require("../define/define");
var async=require("async");
//获取等级和积分
router.get("/info", function (req, res)
{
    var value;
    for (var key in req.userInfo.level) {
        if (req.userInfo.level[key].name == req.query.type) {
            value = req.userInfo.level[key].level;
            break;
        }
    }
    level.find({type: req.query.type},{_id:0}).sort({degree: 1}).select("name").exec(function (err, result) {
        if (err) {
            res.json({
                code: 1,
                msg: err.message
            })
            return;
        }
        else if (result.length == 0) {
            res.json({
                code: 1,
                msg: "未查询到等级"
            })
            return;
        }
        var arr=[];
        for(var i=0;i<result.length;i++)
        {
            arr.push(result[i].name);
        }
        if(value==undefined)
        {
            res.json({
                code: 0,
                data: {
                    level: result[0].name,
                    score: req.userInfo.score,
                    totleLevel:arr
                }
            });
        }
        else
        {
            res.json({
                code: 0,
                data: {
                    level: value,
                    score: req.userInfo.score,
                    totleLevel:arr
                }
            });
        }

    });
});
//获取类别
router.get("/type", function (req, res)
{
    type.find({},function(err,result)
    {
        if (err) {
            res.json({
                code: 1,
                msg: err.message
            });
            return;
        }
        res.json({
            code: 0,
            data: result
        });
    });

});
//进入关卡
router.get("/enter", function (req, res)
{
    level.find({type:req.query.type,name:req.query.level}).select("name time step enemy").exec(function(err,result)
    {
        if (err) {
            res.json({
                code: 1,
                msg: err.message
            })
            return;
        }
        else if (result.length == 0) {
            res.json({
                code: 1,
                msg: "未查询到关卡"
            })
            return;
        }
        res.json({
            code:0,
            data:result[0]
        })
    });

});

//开始闯关，获取题目
router.get("/start", function (req, res)
{

    var power=JSON.parse(req.query.power);
    async.mapSeries(power,function(obj,callback){
        item.find({type:req.query.type,level:req.query.level,power:obj.name}).limit(parseInt(obj.count)).select("power content answer").exec(function(err,result)
        {
            var ret={
                name:obj.name,
                data:result
            }
            callback(err,ret);
        });
    },function(err,result)
    {
        if(err)
        {
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

router.post("/leave", function (req, res)
{
    var arrItem=req.body.item.split(",");
    record.create({
        type:req.body.type,
        level:req.body.level,
        success:parseInt(req.body.success),
        createtime:req.body.createtime,
        usetime:req.body.usetime,
        percent:parseFloat(req.body.percent),
        score:parseInt(req.body.score),
        item:arrItem
    },function(err,result)
    {
        var score=parseInt(req.body.score);
        var success=parseInt(req.body.success);
        async.waterfall([
            (function func1(callback)
            {
                    level.find({type:req.body.type}).sort({degree:1}).exec(function(err,result)
                    {
                        if(err)
                        {
                            res.json({
                                code: 1,
                                msg: err.message
                            })
                            return;
                        }
                        var index;
                        for(var key in result)
                        {
                            if(result[key].name==req.body.level)
                            {
                                index=key;
                                break;
                            }
                        }
                        if(success)
                        {
                            callback(null,result[index]);
                        }
                        else
                        {
                            callback(null,result[index-1]);
                        }

                    });
            }),
            (function func2(obj,callback)
            {
                var arrLevel=req.userInfo.level;
                var challenge=parseInt(req.body.challenge);
                if(challenge)
                {
                    var objLevel;
                    for (var key in arrLevel) {
                        if (arrLevel[key].name == req.body.type) {
                            objLevel=arrLevel[key];
                            break;
                        }
                    }
                    if (objLevel) {
                        objLevel.level = obj.name;
                    }
                    else {
                        arrLevel.push({
                            name: obj.type,
                            level: obj.name
                        });

                    }
                }
                user.update({
                    username:req.body.username
                },{
                    score:req.userInfo.score+score,
                    level:arrLevel
                },{
                    multi:false
                },function(err, numberAffected, raw)
                {
                    callback(err,obj.name);
                });
            })
        ],function(err,level)
        {
            if(err)
            {
                res.json({
                    code: 1,
                    msg: err.message
                })
                return;
            }
            res.json({
                code:0,
                data:{
                    score:req.userInfo.score+score,
                    level:level
                }
            });
        });

    });
});
module.exports = router;
