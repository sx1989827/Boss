var express = require('express');
var router = express.Router();
var user=require("../model/userModel");
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
            history:[]
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
                msg:"添加成功"
            });
        });
    });
});

//获取用户信息
router.get('/info', function(req, res) {
    delete req.userInfo._doc.history;
    res.json({
       code:0,
        data:req.userInfo
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
                        msg:uploadedPath
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
        username:req.query.username
    },{
        name:req.query.name
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
    user.update({
        username:req.query.username
    },{
        pwd:req.query.newpwd
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
        res.json({
            code:0,
            msg:result[0].question
        })
    });
});
//重置密码
router.put("/reset",function(req,res)
{
    user.find({
        username:req.query.username,
        answer:req.query.answer
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
            username:req.query.username
        },{
            pwd:req.query.pwd
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
module.exports = router;
