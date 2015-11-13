/**
 * Created by sunxin on 15/11/13.
 */
var mongoose = require('mongoose');
var db=require("../db/db");
var model=new mongoose.Schema({
    name:String,
    des:String
});
var dbManage=db.model("Type",model);
module.exports=dbManage;