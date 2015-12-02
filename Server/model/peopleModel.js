/**
 * Created by sunxin on 15/11/13.
 */
var mongoose = require('mongoose');
var db=require("../db/db.js");
var model=new mongoose.Schema({
    name:String,
    talk:String,
    money:Number,
    speed:Number,
    des:String
});
var dbManage=db.model("Person",model);
module.exports=dbManage;