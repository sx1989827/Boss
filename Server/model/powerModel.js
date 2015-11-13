/**
 * Created by sunxin on 15/11/13.
 */
var mongoose = require('mongoose');
var db=require("../db/db.js");
var model=new mongoose.Schema({
    name:String,
    value:String
});
var dbManage=db.model("Power",model);
module.exports=dbManage;