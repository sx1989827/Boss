/**
 * Created by sunxin on 15/11/15.
 */
var express=require("express");
var router = express.Router();
var user=require("../model/userModel");
var con=require("../define/define");
var arrExcept=[
    {
        method:"POST",
        url:"/user/register"
    },
    {
        method:"GET",
        url:"/user/check"
    },
]

router.use(function(req,res,next)
{
    var bFind=false;
    var index;
    for(var key in con.service)
    {
        if(con.service[key].method==req.method && con.service[key].path==req.baseUrl+req._parsedUrl.pathname)
        {
            bFind=true;
            index=key;
            break;
        }
    }
    if(!bFind)
    {
        next();
        return;
    }
    var clientParam;
    var username,pwd;
    if(req.method=="POST")
    {
        if(/^multipart\/form-data/i.test(req.headers["content-type"]))
        {
            next();
            return;
        }
        username=req.body.username;
        pwd=req.body.pwd;
        clientParam=req.body;
    }
    else
    {
        username=req.query.username;
        pwd=req.query.pwd;
        clientParam=req.query;
    }
    var param=con.service[index].param;
    for(var key in param)
    {
        if (clientParam[key] == undefined || clientParam[key] == "") {
            res.json({
                code: 1,
                msg: "缺少" + key + "参数"
            });
            return;
        }
        else if (param[key]=="number" && isNaN(clientParam[key])) {
            res.json({
                code: 1,
                msg: "参数" + key + "必须为number"
            });
            return;
        }
    }
    for(var key in arrExcept)
    {
        if(arrExcept[key].method==req.method && arrExcept[key].url==req.baseUrl+req._parsedUrl.pathname)
        {
            next();
            return;
        }
    }
    user.find({
        username:username,
        pwd:pwd
    },function(err,result)
    {
        if(err)
        {
            res.json({
                code:1,
                msg:err.message
            });
            return;
        }
        else if(result.length==0)
        {
            res.json({
                code:1,
                msg:"用户名或者密码错误"
            });
            return;
        }
        req.userInfo=result;
        next();
    });
});

module.exports=router;