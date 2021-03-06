{% extends "layout.swig" %}

{% set page = "prof_list" %}

{% block page_header %}
	<link rel="stylesheet" href="/assets/js/datatables/dataTables.bootstrap.css">
	<link rel="stylesheet" href="/assets/js/select2/select2.css">
	<link rel="stylesheet" href="/assets/js/select2/select2-bootstrap.css">
	<style>
		.btn {
			margin-bottom: 0px;
		}
		.form-horizontal .form-group-separator {
			height: 1px;
			background: #eee;
			margin-bottom: 15px;
		}
		#dataList tbody td {
			cursor: pointer;
		}
		/* datatable highlight */
		.dataTable tbody tr.odd {
			background-color: #f9f9f9;
		}
		.dataTable tbody tr.even:hover, .dataTable tbody tr.even td.highlighted {
			background-color: #ECFFB3;
		}

		.dataTable tbody tr.odd:hover, .dataTable tbody tr.odd td.highlighted {
			background-color: #E6FF99;
		}

		.dataTable tr.even:hover {
			background-color: #ECFFB3;
		}

		.dataTable tr.even:hover td.sorting_1 {
			background-color: #DDFF75;
		}

		.dataTable tr.even:hover td.sorting_2 {
			background-color: #E7FF9E;
		}

		.dataTable tr.even:hover td.sorting_3 {
			background-color: #E2FF89;
		}

		.dataTable tr.odd:hover {
			background-color: #E6FF99;
		}

		.dataTable tr.odd:hover td.sorting_1 {
			background-color: #D6FF5C;
		}

		.dataTable tr.odd:hover td.sorting_2 {
			background-color: #E0FF84;
		}

		.dataTable tr.odd:hover td.sorting_3 {
			background-color: #DBFF70;
		}
		.dataTable th,.dataTable td {
			text-align:center;
			text-overflow: ellipsis;
		}
		.dataTable td {
			vertical-align: middle;
		}
		._filter {
			width: 100% !important;
		}
		.dataTable tbody td:nth-child(5),
		.dataTable tbody td:nth-child(6),
		.dataTable tbody td:nth-child(7),
		.dataTable tbody td:nth-child(8),
		.dataTable tbody td:nth-child(9),
		.dataTable tbody td:nth-child(10) {
			padding-left: 0px;
			padding-right: 0px;
		}
		.progress .progress-bar.progress-bar-gray {
			background-color: #979898;
		}
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">교수 현황</h1>
			<p class="description">{{ user.ids }} 계정의 {{ user.name }} 교수 정보입니다.</p>
		</div>
		<div class="breadcrumb-env">
			<ol class="breadcrumb bc-1">
				<li>
					<a href="main"><i class="fa-home"></i>메인</a>
				</li>
				<li style="color:#979898;">			
					교수 관리
				</li>
				<li class="active">
					<strong>교수 현황</strong>
				</li>
			</ol>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12 form-horizontal">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">교수 기본 정보</h3>
				</div>
				<div class="panel-body">
					<div class="form-group">
						<label class="col-sm-2 control-label">아이디</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" value="{{ user.ids }}" disabled >
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">이름</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" value="{{ user.name }}" disabled >
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">이메일</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" value="{{ user.email }}" disabled >
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">연락처</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" value="{{ user.phone }}" disabled >
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">전공</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" value="{{ ["전자전기공학부","컴퓨터공학과","반도체시스템공학과","소프트웨어학과","정보통신대학"][user.major] }}" disabled >
						</div>
					</div>					
					<div class="form-group-separator"></div>
					<div class="form-group">
						<div class="col-sm-12">
							<button type="button" class="btn btn-success" style="float:right;" onClick="window.history.back()">뒤로가기</button>
							<a href="../prof_register/{{user.id}}" type="button" class="btn btn-info" style="float:right; margin-right:20px;">수정하기</a>
							<button type="button" class="btn btn-danger" style="float:right; margin-right:20px;" onClick="prof_login()">로그인하기</button>								
						</div>
					</div>
				</div>
				<div class="panel-heading">
					<h3 class="panel-title">교수 지도 학생 정보</h3>
				</div>
				<div class="panel-body">
					<table id="dataList" class="table table-striped table-bordered" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th rowspan="2">#</th>
								<th rowspan="2">아이디</th>
								<th rowspan="2">이름</th>
								<th rowspan="2">재학 여부</th>
								<th colspan="6">졸업 작품/논문 진행상황</th>
							</tr>
							<tr>
								<th style="width:12%;">신청서 제출</th>
								<th style="width:12%;">서약서 및 제안서 제출</th>
								<th style="width:12%;">중간보고서 제출</th>
								<th style="width:12%;">최종 자료 제출</th>
								<th style="width:12%;">작품/논문 심사</th>
								<th style="width:12%;">작품/논문 완료</th>
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
	<script src="/assets/js/jquery.form.min.js"></script>	
	<script type="text/javascript">
		function prof_login(){
			if(confirm("관리자 페이지가 로그아웃 되고 현재 {{user.name}} 교수의 {{user.ids}} 계정으로 로그인 됩니다. 로그인 하시겠습니까?")){
				document.location="../prof_login/{{user.id}}";
			}
		}
		var dataList;
		jQuery(document).ready(function($) {

			dataList=$("#dataList").DataTable({
		        "oLanguage": {
		            "sSearch": "검색 :",
		            "sLengthMenu": "_MENU_ 명씩 보기",
		            "sEmptyTable": "레코드가 없습니다.",
		            "sInfo": "총 _TOTAL_명 중 _START_에서 _END_번째",
		            "sInfoEmpty": "총 0명",
		            "sZeroRecords": "일치하는 학생이 없습니다.",
		            "sInfoFiltered": "(총 _MAX_명 중)",
		            "oPaginate": {
		                "sFirst": "처음",
		                "sLast": "마지막",
		                "sNext": "다음",
		                "sPrevious": "이전"
		            }
		        },
		        aLengthMenu: [
		            [25, 50, 100, -1],
		            [25, 50, 100, "전체"]
		        ],
		        //"sPaginationType": "full_numbers",
		        //"bSort": false,
		        "bProcessing": true,
		        "sAjaxSource": '{{user.id}}/ajax/get_students',
		        "sServerMethod": "POST",
		        "aoColumns": [{
		            "mData": "index"
		        }, {
				    "mData": "ids"
		        }, {
		            "mData": "name"
		        }, {
		            "mData": "Student.status",
		            "mRender": function(data, type, full) {
		            	if(data==0) return "재학";
		            	else if(data==1) return "휴학";
		            	else if(data==2) return "수료";
		            	else if(data==3) return "졸업";
		            	else return "(오류)";
		            }
		        }, {
		            "mData": "Student",
		            "mRender": function(data, type, full) {
		            	if(data.SystemId==13) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-info" style="width: 100%"></div></div>(단계 완료)';
		            	else if(data.StudentInfoId) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-success" style="width: 100%"></div></div>(제출 완료)';
		            	else if((data.status==0||data.status==2)&&data.SystemId==2&&data.System.isNow) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-warning" style="width: 100%"></div></div>(미제출)';
		            	else if(data.SystemId==2) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-gray" style="width: 100%"></div></div>(기간 아님)';
		           		else if(data.SystemId>2) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-danger" style="width: 100%"></div></div>(미제출 단계변경)';
		            	else return '<div class="progress progress-striped active"><div style="width: 0%"></div></div>';
		            }
		        }, {
		            "mData": "Student",
		            "mRender": function(data, type, full) {
		            	if(data.SystemId==13) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-info" style="width: 100%"></div></div>(단계 완료)';
		            	else if(data.oathId&&data.proposalId) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-success" style="width: 100%"></div></div>(제출 완료)';
		            	else if((data.oathId||data.proposalId)&&data.System.isNow) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-success" style="width: 100%"></div></div>(제출 중)';
		            	else if((data.status==0||data.status==2)&&data.SystemId==9&&data.System.isNow) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-warning" style="width: 100%"></div></div>(미제출)';
		            	else if(data.SystemId==9) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-gray" style="width: 100%"></div></div>(기간 아님)';
		            	else if(data.SystemId>9) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-danger" style="width: 100%"></div></div>(미제출 단계변경)';
		            	else return '<div class="progress progress-striped active"><div style="width: 0%"></div></div>';
		            }
		        }, {
		            "mData": "Student",
		            "mRender": function(data, type, full) {
		            	if(data.SystemId==13) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-info" style="width: 100%"></div></div>(단계 완료)';
		            	else if(data.midreportId) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-success" style="width: 100%"></div></div>(제출 완료)';
		            	else if((data.status==0||data.status==2)&&data.SystemId==10&&data.System.isNow) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-warning" style="width: 100%"></div></div>(미제출)';
		            	else if(data.SystemId==10) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-gray" style="width: 100%"></div></div>(기간 아님)';
		         		else if(data.SystemId>10) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-danger" style="width: 100%"></div></div>(미제출 단계변경)';
		            	else return '<div class="progress progress-striped active"><div style="width: 0%"></div></div>';
		            }
		        }, {
		            "mData": "Student",
		            "mRender": function(data, type, full) {
		            	if(data.SystemId==13) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-info" style="width: 100%"></div></div>(단계 완료)';
		            	else if(data.finalreportId&&data.paperworkId) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-success" style="width: 100%"></div></div>(제출 완료)';
		            	else if((data.finalreportId||data.paperworkId||data.presentationId||data.conferenceId)&&data.System.isNow) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-success" style="width: 100%"></div></div>(제출 중)';
		            	else if((data.status==0||data.status==2)&&data.SystemId==11&&data.System.isNow) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-warning" style="width: 100%"></div></div>(미제출)';
		            	else if(data.SystemId==11) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-gray" style="width: 100%"></div></div>(기간 아님)';
		            	else if(data.SystemId>11) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-danger" style="width: 100%"></div></div>(미제출 단계변경)';
		            	else return '<div class="progress progress-striped active"><div style="width: 0%"></div></div>';
		            }
		        }, {
		            "mData": "Student",
		            "mRender": function(data, type, full) {
		            	if(data.SystemId==13) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-info" style="width: 100%"></div></div>(단계 완료)';
		            	else if(data.SystemId==12&&data.result!=0) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-success" style="width: 100%"></div></div>(심사 완료)';
		            	else if((data.status==0||data.status==2)&&data.SystemId==12&&data.System.isNow) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-warning" style="width: 100%"></div></div>(심사 중)';
		            	else if(data.SystemId==12) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-gray" style="width: 100%"></div></div>(기간 아님)';
		            	else return '<div class="progress progress-striped active"><div style="width: 0%"></div></div>';
		            }
		        }, {
		            "mData": "Student",
		            "mRender": function(data, type, full) {
		            	if(data.SystemId==13) return '<div class="progress progress-striped active"><div class="progress-bar progress-bar-info" style="width: 100%"></div></div>(최종 완료)';
		            	else return '<div class="progress progress-striped active"><div style="width: 0%"></div></div>';
		            }
		        }],
		        "fnRowCallback": function(nRow, aData, iDisplayIndex) {
		        	$(nRow).unbind("click").click(function() {
		        		document.location = "../student/"+aData.id;
		            });
		        },
		        "fnDrawCallback": function(oSettings) {
		            $(window).trigger('xenon.resized');
		        }
		    });
		});
	</script>
{% endblock %}