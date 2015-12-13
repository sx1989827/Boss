var express = require('express');
var router = express.Router();
var user=require("../model/userModel");
var record=require("../model/recordModel");
var level=require("../model/levelModel");
var multiparty=require("multiparty");
var fs=require("fs");
var con=require("../define/define");
//检查用户名
router.get('/check', function(req, res) {
    user.find({username:req.query.username},function(err,result)
    {
        if(err)
        {
            res.json({
               code:1,
                msg:err.message
            });
            return;
        }
        res.json({
           code:0,
            data:result.length>0?1:0
        });
    });
});

//注册
router.post('/register', function(req, res) {
    user.find({username:req.body.username},function(err,result)
    {
        if(err)
        {
            res.json({
                code:1,
                msg:err.message
            });
            return;
        }
        else if(result.length>0)
        {
            res.json({
                code:1,
                msg:"该用户名已注册"
            });
            return;
        }
        else if(isNaN(req.body.age))
        {
            res.json({
                code:1,
                msg:"年龄必须为数字"
            });
            return;
        }
        user.create({
            username:req.body.username,
            name:req.body.name,
            pwd:req.body.pwd,
            age:req.body.age,
            sex:req.body.sex,
            question:req.body.question,
            answer:req.body.answer,
            photo:"",
            level:[],
            score:0,
            logincount:0,
            createtime:req.body.time,
            lastlogintime:""
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
            res.json({
                code:0,
                data:"添加成功"
            });
        });
    });
});

//获取用户信息
router.get('/info', function(req, res) {
    user.update({
        username:req.userInfo.username
    },{
        logincount:++req.userInfo.logincount,
        lastlogintime:req.query.time
    },{
        multi:false
    },function(err, numberAffected, raw){
        if(err)
        {
            res.json({
                code:1,
                data:err.message
            });
        }
        else
        {
            res.json({
               code:0,
                data:req.userInfo
            });
        }
    });
});

//上传头像
router.post('/photo', function(req, res) {
    var form = new multiparty.Form({uploadDir: con.imgpath+"/img"});
    form.parse(req, function (err, fields, files) {
        if (err) {
            res.json({
                code:1,
                msg:err.message
            });
            return;
        } else {
            var inputFile = files.file[0];
            var uploadedPath = inputFile.path;
            uploadedPath=uploadedPath.replace(con.imgpath,"");
            var username=fields.username[0];
            var pwd=fields.pwd[0];
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
                if(result[0].photo!=undefined && result[0].photo!="")
                {
                    fs.unlink(con.imgpath+result[0].photo);
                }
                user.update({
                    username:username
                },{
                    photo:uploadedPath
                },{
                    multi:false
                },function(err, numberAffected, raw){
                    if(err)
                    {
                        res.json({
                            code:1,
                            msg:err.message
                        });
                        return;
                    }
                    res.json({
                        code:0,
                        data:uploadedPath
                    })
                });
            });

        }

    });
});

//修改昵称
router.put("/editname",function(req,res)
{
    user.update({
        username:req.body.username
    },{
        name:req.body.name
    },{
        multi:false
    },function(err, numberAffected, raw){
        if(err)
        {
            res.json({
                code:1,
                msg:err.message
            });
            return;
        }
        res.json({
            code:0,
            msg:"修改成功"
        })
    });
});
//修改密码
router.put("/pwd",function(req,res)
{
    if(req.userInfo.pwd!=req.body.pwd)
    {
        res.json({
            code:1,
            msg:"原密码不正确"
        });
        return;
    }
    user.update({
        username:req.body.username
    },{
        pwd:req.body.newpwd
    },{
        multi:false
    },function(err, numberAffected, raw){
        if(err)
        {
            res.json({
                code:1,
                msg:err.message
            });
            return;
        }
        res.json({
            code:0,
            msg:"修改成功"
        })
    });
});
//获取提示问题
router.get("/question",function(req,res)
{
    user.find({
        username:req.query.username
    },function(err, result){
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
                msg:"该用户名不存在"
            });
            return;
        }
        res.json({
            code:0,
            data:result[0].question
        })
    });
});
//重置密码
router.put("/reset",function(req,res)
{
    user.find({
        username:req.body.username,
        answer:req.body.answer
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
                msg:"答案错误"
            });
            return;
        }
        user.update({
            username:req.body.username
        },{
            pwd:req.body.pwd
        },{
            multi:false
        },function(err, numberAffected, raw){
            if(err)
            {
                res.json({
                    code:1,
                    msg:err.message
                });
                return;
            }
            res.json({
                code:0,
                msg:"重置成功"
            })
        });
    });

});
//获取闯关记录
router.get("/history",function(req,res)
{
    var index=parseInt(req.query.page);
    if(index<0)
    {
        res.json({
            code:1,
            msg:"页数不正确"
        })
        return;
    }
    record.find({username:req.query.username,type:req.query.type},{_id:0}).sort({createtime:-1}).skip(index*10).limit(10).exec(function(err,result)
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
        })
    });

});
module.exports = router;
