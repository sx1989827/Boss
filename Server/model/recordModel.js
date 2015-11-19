/**
 * Created by sunxin on 15/11/17.
 */
var mongoose = require('mongoose');
var db=require("../db/db.js");
var model=new mongoose.Schema({
    username:String,
    type:String,
    level:String,
    createtime:String,
    usetime:Number,
    success:Number,
    percent:Number,
    score:Number,
    item:Array
});
var dbManage=db.model("Record",model);
module.exports=dbManage;