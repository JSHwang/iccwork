{% extends "layout.swig" %}

{% set page = "example" %}

{% block page_header %}
	<link rel="stylesheet" href="/assets/js/datatables/dataTables.bootstrap.css">
	<style>
		.panel-body {
			padding-top: 0px !important;
		}
		.dataTables_paginate {
			float: left !important;
		}
		.dataTables_filter {
			float: right;
			padding-top: 10px;
		}
		.dataTable tbody tr {
			cursor: pointer;
		}
		.rotate{
		    -ms-transform:rotate(180deg);
		    -moz-transform:rotate(180deg);
		    -webkit-transform:rotate(180deg);
		    transform:rotate(180deg);
		}
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">제출양식</h1>
			<p class="description">졸업작품시스템 학생 페이지 제출양식 게시판입니다.</p>
		</div>
		<div class="breadcrumb-env">
			<ol class="breadcrumb bc-1">
				<li>
					<a href="main"><i class="fa-home"></i>메인</a>
				</li>
				<li style="color:#979898;">			
					게시판 관리
				</li>
				<li class="active">
					<strong>학생 페이지 제출양식</strong>
				</li>
			</ol>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<table id="exampleList" class="table table-hover" style="width:100% !important;">
						<thead>
							<tr>
								<th>#</th>
								<th>제목</th>
								<th>글쓴이</th>
								<th>날짜</th>
								<th>조회</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
{% endblock %}

{% block page_footer %}
	<script src="/assets/js/datatables/js/jquery.dataTables.min.js"></script>
	<script src="/assets/js/datatables/dataTables.bootstrap.js"></script>
	<script src="/assets/js/datatables/tabletools/dataTables.tableTools.min.js"></script>
	<script src="/assets/js/datatables/fnReloadAjax.js"></script>	
	<script type="text/javascript">
		var exampleList;
		jQuery(document).ready(function($) {

			exampleList=$("#exampleList").dataTable({
		        "oLanguage": {
		            "sSearch": "검색 :",
		            "sLengthMenu": "_MENU_ 개씩 보기",
		            "sEmptyTable": "레코드가 없습니다.",
		            "sInfo": "총 _TOTAL_개 중 _START_에서 _END_번째",
		            "sInfoEmpty": "총 0개",
		            "sZeroRecords": "일치하는 글이 없습니다.",
		            "sInfoFiltered": "(총 _MAX_개 중)",
		            "oPaginate": {
		                "sFirst": "처음",
		                "sLast": "마지막",
		                "sNext": "다음",
		                "sPrevious": "이전"
		            }
		        },
		        "sDom": '<"top"i>rt<"bottom"pf><"clear">',
		        aLengthMenu: [
		            [10, 25, 50, 100, -1],
		            [10, 25, 50, 100, "전체"]
		        ],
		        //"sPaginationType": "full_numbers",
		        "bSort": false,
		        "bProcessing": true,
		        "sAjaxSource": '/iccsys/ajax/board/list/work_student_example',
		        "sServerMethod": "POST",
		        "aoColumns": [
		        {
		            "mData": "index",
		            "mRender": function(data, type, full) {
		            	if(data===null) return "<i class='fa fa-reply rotate'></i>";
		            	else return data;		                
		            }
		        }, {
				    "mData": "title",
		            "mRender": function(data, type, full) {
		            	if(full.secret) return data+" <i class='fa fa-lock'></i>";
		            	else return data;		                
		            }				    
		        }, {
				    "mData": "name"
		        }, {
				    "mData": "time"
		        }, {
				    "mData": "views"
		        }, {
				    "mData": "text",
				    "visible": false,
		        }],
		        "fnRowCallback": function(nRow, aData, iDisplayIndex) {
		            $(nRow).unbind("click").click(function() {
		            	document.location='view/'+aData.id;
		            });
		        },
		        "fnDrawCallback": function(oSettings) {
		            $(window).trigger('xenon.resized');
		        }
		    });
			$("#exampleList_wrapper .bottom").prepend("<a href='write' class='btn btn-success' style='float:right;margin:10px 0px 0px 30px;'>글쓰기</a>");
		});
	</script>
{% endblock %}