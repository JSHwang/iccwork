{% extends "layout.swig" %}

{% set page = "student_list" %}

{% block page_header %}
	<link rel="stylesheet" href="/assets/js/datatables/dataTables.bootstrap.css">
	<link rel="stylesheet" href="/assets/js/select2/select2.css">
	<link rel="stylesheet" href="/assets/js/select2/select2-bootstrap.css">
	<style>
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
		}
		.dataTable td {
			vertical-align: middle;
		}
		._filter {
			width: 100% !important;
		}
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">학생 현황</h1>
			<p class="description">학생을 클릭하면 자세한 사항을 확인하실 수 있습니다.</p>
		</div>
		<div class="breadcrumb-env">
			<ol class="breadcrumb bc-1">
				<li>
					<a href="main"><i class="fa-home"></i>메인</a>
				</li>
				<li style="color:#979898;">			
					학생 관리
				</li>
				<li class="active">
					<strong>학생 현황</strong>
				</li>
			</ol>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<a href="student_excel_save" class="btn btn-success" style="margin-right:10px;">전체 학생 엑셀 저장</a>
					<button class="btn btn-success" onClick="filter_excel_save()">필터 학생 엑셀 저장</button>
					<hr>
					<table id="dataList" class="table table-striped table-bordered" cellspacing="0" width="100%">
						<thead>
							<tr>
								<td>#</td>
								<th>아이디</th>
								<th>이름</th>
								<th>이메일</th>
								<th>연락처</th>
								<th>학과</th>
								<th>학기</th>
								<th>상태</th>
								<th>시스템단계</th>
								<th><span data-toggle="tooltip" data-placement="top" title="" data-original-title="시스템락">락</span></th>
							</tr>
						</thead>
						<thead>
							<tr>
								<td style="vertical-align: middle;">필터</td>
								<th><input type="text" class="form-control _filter"></th>
								<th><input type="text" class="form-control _filter"></th>
								<th><input type="text" class="form-control _filter"></th>
								<th><input type="text" class="form-control _filter"></th>
								<th>
									<select class="form-control _filter">
										<option value="">(미선택)</option>
										<option value="전자전기공학부">전자전기공학부</option>
										<option value="컴퓨터공학과">컴퓨터공학과</option>
										<option value="반도체시스템공학과">반도체시스템공학과</option>
										<option value="소프트웨어학과">소프트웨어학과</option>
										<option value="정보통신대학">정보통신대학</option>
									</select>
								</th>
								<th><input type="text" class="form-control _filter"></th>
								<th>
									<select class="form-control _filter">
										<option value="">(미선택)</option>
										<option value="재학">재학</option>
										<option value="휴학">휴학</option>
										<option value="수료">수료</option>
										<option value="졸업">졸업</option>
									</select>
								</th>
								<th>
									<select class="form-control _filter">
										<option value="">(미선택)</option>
										{% for system in systems %}
											<option value="{{system.phase}}">{{system.phase}}</option>
										{% endfor %}
									</select>
								</th>
								<th>
									-
								</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- 급해서 이렇게 만듬 -->
	<form id="excel_save_frm" action="student_excel_save" method="post"> 
	    <input type="hidden" name="arr" /> 
	</form>
{% endblock %}

{% block page_footer %}
	<script src="/assets/js/datatables/js/jquery.dataTables.min.js"></script>
	<script src="/assets/js/datatables/dataTables.bootstrap.js"></script>
	<script src="/assets/js/datatables/tabletools/dataTables.tableTools.min.js"></script>
	<script src="/assets/js/select2/select2.min.js"></script>
	<script src="/assets/js/datatables/fnReloadAjax.js"></script>	
	<script src="/assets/js/jquery.form.min.js"></script>		
	<script type="text/javascript">
		var dataList;
		jQuery(document).ready(function($) {
			$("#dataList select").select2({
				minimumResultsForSearch: -1
			});			
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
		            [10, 25, 50, 100, -1],
		            [10, 25, 50, 100, "전체"]
		        ],
		        //"sPaginationType": "full_numbers",
		        //"bSort": false,
		        "bProcessing": true,
		        "sAjaxSource": 'student_list/ajax/get_students',
		        "sServerMethod": "POST",
		        "aoColumns": [{
		            "mData": "index"
		        }, {
				    "mData": "ids"
		        }, {
		            "mData": "name"
		        }, {
		            "mData": "email"
		        }, {
		            "mData": "phone"
		        }, {
					"mData": "major",
		            "mRender": function(data, type, full) {
		            	if(data>=0 && data<5) return ['전자전기공학부', '컴퓨터공학과', '반도체시스템공학과', '소프트웨어학과', '정보통신대학'][data];
		                else return "(미지정)";
		            }
		        }, {
		            "mData": "Student.term",
  		            "mRender": function(data, type, full) {
		                return data+"학기";
		            }
		        }, {
		            "mData": "Student.status",
		            "mRender": function(data, type, full) {
		            	if(data==0) return "재학";
		            	else if(data==1) return "휴학";
		            	else if(data==2) return "수료";
		            	else if(data==3) return "졸업";
		                return "";
		            }
		        }, {
		            "mData": "Student.System",
		            "mRender": function(data, type, full) {
		            	if(data) return data.phase;
		            	return "(미지정)";
		            }
		        }, {
		            "mData": "Student.islock",
		            "mRender": function(data, type, full) {
		            	if(data) return "락";
		            	return "";
		            }
		        }],
		        "fnRowCallback": function(nRow, aData, iDisplayIndex) {
		        	$(nRow).unbind("click").click(function() {
		        		document.location = "student/"+aData.id;
		            });
		        },
		        "fnDrawCallback": function(oSettings) {
		            $(window).trigger('xenon.resized');
		        }
		    });

			$('._filter').change(function(){
				$('input._filter,select._filter').each(function(index){
					dataList.column(index+1).search($(this).val()).draw();
				});
			});
		});
		function filter_excel_save(){
			var userArr=[];
			dataList.rows( { search:'applied' } ).data().each(function(value, index) {
				userArr.push(value.id);
			});
			$("#excel_save_frm input[name='arr']").val(JSON.stringify(userArr));
			$("#excel_save_frm").submit();
		}
	</script>
{% endblock %}