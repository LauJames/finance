<%--
  Created by IntelliJ IDEA.
  User: uestc
  Date: 2017/8/18
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8";>
    <title>金融事件智能分类</title>
    <link rel="stylesheet" href="..\css\bootstrap.min.css">
    <link rel="stylesheet" href="..\css\bootstrap-table.min.css">
    <script src="..\js\jquery.min.js"></script>
    <script src="..\js\bootstrap.min.js"></script>
    <script src="..\js\bootstrap-table.min.js"></script>
    <script src="..\js\bootstrap-table-zh-CN.min.js"></script>
    <script src="..\js\main.js"></script>
    <style>
        html, body {
            position: relative;
            height: 100%;
        }
        body {
            background: #fff;
            font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
            font-size: 14px;
            color:#000;
            margin: 0;
            padding: 0;
        }
    </style>
</head>
<body>
<div style="filter:alpha(opacity=20)">
    <!-- 导航栏 -->
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#top-navbar-collapse">
                    <span class="sr-only">切换导航</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <img class="navbar-brand" src="..\pics\陆门实验室logo_副本.png" href="#maim.html"style="padding:0;height:50px;">
            </div>
            <div class="collapse navbar-collapse  navbar-right" id="top-navbar-collapse">
                <ul class="nav navbar-nav">
                    <li><a href="main.html">&nbsp&nbsp首页&nbsp&nbsp</a></li>
                    <li class="active"><a href="search.html">&nbsp高级搜索&nbsp</a></li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown">&nbsp事件汇总&nbsp<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="#" >&nbsp新闻&nbsp</a></li>
                            <li><a href="#" >&nbsp公告&nbsp</a></li>
                            <li class="divider"></li>
                            <li><a href="#" >&nbsp季报/年报&nbsp</a></li>
                        </ul>
                    </li>
                </ul>
                <form class="navbar-form navbar-right" role="search">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Search">
                    </div>
                    <button type="button" id="search" class="btn btn-default"><span class="glyphicon glyphicon-search"></span>搜索</button>
                </form>
            </div>
        </div>
    </nav>
    <!-- end of 导航栏 -->
</div>
<div class="container" style="padding:100px 50px;">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h4 id="companyName" class="panel-tittle"></h4>
        </div>
        <div class="panel-body">
            <h4 id="comDescribe"></h4>
            <ul class="nav nav-pills nav-left" >
                <li class="active"><a data-toggle="pill" href="#tab1">&nbsp企业概况&nbsp</a></li>
                <li><a data-toggle="pill" href="#tab2">&nbsp公司公告&nbsp</a></li>
                <li><a data-toggle="pill" href="#tab3">&nbsp公司新闻&nbsp</a></li>
            </ul>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="tab-content" style="margin: 10px">
            <div id="tab1" class="tab-pane fade in active">
                <h4 style="margin: 10px">概况</h4>
                <ul style="margin: 10px" class="list-group">
                    <li id="address" class="list-group-item">企业地址：</li>
                    <li id="ceo" class="list-group-item">现任董秘：</li>
                    <li id="createDate" class="list-group-item">创建时间：</li>
                    <li id="code" class="list-group-item">发行代码：</li>
                    <li id="legalRepresent" class="list-group-item">法人代表：</li>
                    <li id="listingDate" class="list-group-item">发行日期：</li>
                    <li id="tell" class="list-group-item">联系电话：</li>
                </ul>
            </div>
            <div id="tab2" class="tab-pane fade">
                <h4 style="margin: 10px">近期公告</h4>
                <table id="tb_Notice">
                </table>
            </div>
            <div id="tab3" class="tab-pane fade">
                <h4 style="margin: 10px">近期新闻</h4>
                <table id="tb_News">
                </table>
            </div>
        </div>
    </div>
</div>

</body>
<script>
    var showCompanyID=decodeURI(GetQueryString("CompanyID"));
    $(function(){
        searchCompanyInfo();
        initNoticeTb();
        initNewsTb();
    });
    function initInfo(companyInfo) {
        company_code=companyInfo.company.information.i_id;
        $('#companyName').html("<strong>"+companyInfo.company.c_name+"</strong>("+companyInfo.company.information.i_id+")");
        $('#comDescribe').html("<small>"+companyInfo.company.c_fullname+"</small>");
        $('#address').append(companyInfo.company.information.i_address);
        $('#ceo').append(companyInfo.company.information.i_ceo);
        $('#createDate').append(companyInfo.company.information.i_createDate);
        $('#code').append(companyInfo.company.information.i_id);
        $('#legalRepresent').append(companyInfo.company.information.i_legalRepresentative);
        $('#listingDate').append(companyInfo.company.information.i_listing);
        $('#tell').append(companyInfo.company.information.i_tell);
    }
    function searchCompanyInfo() {
        $.ajax({
            type:'post',
            url:'${pageContext.request.contextPath}/notice/selectDetail.do',
            data:showCompanyID,
            success:function (rtn) {
                if(rtn!=null){
                    initInfo(rtn);
                }
                else{
                    alert('暂未获取到相关数据');
                }
            }
        });
    }

    function initNoticeTb() {
        $('#tb_Notice').bootstrapTable({
            method:'post',
            contentType: 'application/x-www-form-urlencoded',
            fit:true,
            fitColumns:true,
            striped: true,
            rownumbers: true,
            pagination: true,
            //dataType:"json",
            queryParams: function (params) {
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    rows: params.limit,   //页面大小
                    page: (params.offset/params.limit)+1,  //页码
                    searchObj:showCompanyID
                };
                return temp;
            },
            sidePagination: "server", //服务端处理分页
            pageNumber:1,      //初始化加载第一页，默认第一页
            pageSize: 10,      //每页的记录行数（*）
            pageList: [10, 25, 50, 100],  //可供选择的每页的行数（*）
            queryParamsType:'limit', //默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort
            // 设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber
            url:'${pageContext.request.contextPath}/notice/select.do',
            showToggle:true,
            columns:[
                {
                    title:"公司名称",
                    field:"n_name",
                    //sortable:true,
                    order:"desc"
                },
                {
                    title:"股票代码",
                    field:"n_code",
                    //sortable:true,
                    order:"desc"
                },
                {
                    title:"公告摘要",
                    field:"n_title",
                },
                {
                    title:"公告详情",
                    field:"n_url",
                    formatter:function(value,row,index){
                        var operation='<a href="javascript:;" class="detail label label-success">查看详情</a>';
                        return operation;
                    },
                    events:{
                        'click .detail':function(e,value,row,index){
                            urlLink=row.n_url;
                            window.open(urlLink);
                        }
                    }
                }
            ],
            locale:"zh-CN"
        });//表格参数初始化
    }
    function initNewsTb() {
        $('#tb_News').bootstrapTable({
            method:'post',
            contentType: 'application/x-www-form-urlencoded',
            fit:true,
            fitColumns:true,
            striped: true,
            rownumbers: true,
            pagination: true,
            //dataType:"json",
            queryParams: function (params) {
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    rows: params.limit,   //页面大小
                    page: params.offset+1,  //页码
                    searchObj:showCompanyID
                };
                return temp;
            },
            sidePagination: "server", //服务端处理分页
            pageNumber:1,      //初始化加载第一页，默认第一页
            pageSize: 10,      //每页的记录行数（*）
            pageList: [10, 25, 50, 100],  //可供选择的每页的行数（*）
            queryParamsType:'limit', //默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort
            // 设置为 ''  在这种情况下传给服务器的参数为：pageSize,pageNumber
            url:'${pageContext.request.contextPath}/journalism/select.do',
            showToggle:true,
            columns:[
                {
                    title:"公司名称",
                    field:"n_name",
                    order:"desc"
                },
                {
                    title:"股票代码",
                    field:"n_code",
                    //sortable:true,
                    order:"desc"
                },
                {
                    title:"新闻摘要",
                    field:"n_title",
                },
                {
                    title:"公告详情",
                    field:"n_url",
                    formatter:function(value,row,index){
                        var operation='<a href="javascript:;" class="detail label label-success">查看详情</a>';
                        return operation;
                    },
                    events:{
                        'click .detail':function(e,value,row,index){
                            urlLink=row.n_url;
                            window.open(urlLink);
                        }
                    }
                }
            ],
            locale:"zh-CN"
        });//表格参数初始化
    }
</script>
