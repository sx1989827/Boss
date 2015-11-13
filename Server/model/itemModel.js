/**
 * Created by sunxin on 15/11/13.
 */
var mongoose = require('mongoose');
var db=require("../db/db.js");
var model=new mongoose.Schema({
    type:String,
    level:String,
    power:String,
    content:String,
    answer:Array
});
var dbManage=db.model("Item",model);
module.exports=dbManage;