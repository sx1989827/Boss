/**
 * Created by sunxin on 15/11/13.
 */
var mongoose = require('mongoose');
var data=require("../define/define.js");
var db=mongoose.createConnection(data.dbpath);
module.exports=db;