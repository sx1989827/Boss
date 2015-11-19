/**
 * Created by sunxin on 15/11/13.
 */
var mongoose = require('mongoose');
var db=require("../db/db.js");
var model=new mongoose.Schema({
    username:String,
    name:String,
    pwd:String,
    age:Number,
    sex:String,
    question:String,
    answer:String,
    photo:String,
    level:Array,
    score:Number
});
var dbManage=db.model("User",model);
module.exports=dbManage;