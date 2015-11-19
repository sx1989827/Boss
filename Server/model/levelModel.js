/**
 * Created by sunxin on 15/11/13.
 */
var mongoose = require('mongoose');
var db=require("../db/db.js");
var model=new mongoose.Schema({
    degree:Number,
    name:String,
    type:String,
    time:Number,
    step:Number,
    enemy:Array
});
var dbManage=db.model("Level",model);
module.exports=dbManage;