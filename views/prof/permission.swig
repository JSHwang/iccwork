{% extends "layout.swig" %}

{% set page = "permission" %}

{% block page_header %}
	<style>
		.table th, .table td{
			text-align: center;
		}
		.tab {
			padding: 0px 15px 0px 15px;
		}
		.tab > div {
			background-color: rgb(247, 247, 247);
			padding: 10px 0px 10px 0px;
			text-align: center;
		}
		.tab > div + div {
			border-left: #EEE 1px solid;
		}
		.progress {
			margin-bottom: 0px;
			border-right: #EEE 1px solid;
		}
		._exp {
			color: #bbb;
		}
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">지도 학생 선택</h1>
			<p class="description">지도 희망 학생을 선택하는 페이지 입니다.</p>
		</div>
		<div class="breadcrumb-env">
			<ol class="breadcrumb bc-1">
				<li>
					<a href="main"><i class="fa-home"></i>메인</a>
				</li>
				<li class="active">
					<strong>지도 학생 선택</strong>
				</li>
			</ol>
		</div>
	</div>
	<div class="row tab">
		<div class="col-sm-4">
			1 차 지도 학생 선택 기간<br>
			<small class="text-small">{{systems[0].start__}} ~ {{systems[0].end__}}</small>
		</div>
		<div class="col-sm-4">
			2 차 지도 학생 선택 기간<br>
			<small class="text-small">{{systems[1].start__}} ~ {{systems[1].end__}}</small>
		</div>
		<div class="col-sm-4">
			3 차 지도 학생 선택 기간<br>
			<small class="text-small">{{systems[2].start__}} ~ {{systems[2].end__}}</small>
		</div>
	</div>
	<div class="row progress">
		<div class="col-sm-12">
			<div class="progress progress-striped active">
				<div class="progress-bar progress-bar-success" style="width:{{100/3*(order)}}%;"></div>
			</div>
		</div>
	</div>


	<div class="row">
		<div class="col-sm-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">{{order}} 차 지도 학생 선택</h3>
					<small class="text-small pull-right" style="padding-top:5px;">
						지도 학생 선택 기간 : {{systems[order-1].start_}} ~ {{systems[order-1].end_}}
					</small>
				</div>
				<div class="panel-body">
					<div class="table-responsive" data-pattern="priority-columns" data-focus-btn-icon="fa-asterisk" data-sticky-table-header="true" data-add-display-all-btn="true" data-add-focus-btn="true">
						<table cellspacing="0" class="table table-small-font table-bordered table-striped">
							<thead>
								<tr>
									<th>#</th>
									<th>아이디</th>
									<th>이름</th>
									<th>전공</th>
									<th>신청서</th>
									<th>1지망</th>
									<th>2지망</th>
									<th>3지망</th>
									<th>선택</th>
									<th>비고</th>
								</tr>
							</thead>
							<tbody>
								{% if permissions.length %}
									{% for permission in permissions %}
										<tr>
											<th>{{loop.index}}</th>
											<td>{{permission.Student.User.ids}}</td>
											<td>{{permission.Student.User.name}}</td>
											<td>{{["전자전기공학부","컴퓨터공학과","반도체시스템공학과","소프트웨어학과","정보통신대학"][permission.Student.User.major]}}</td>
											<td>
												{% if permission.Student.StudentInfoId %}
													<a href="permission/application/{{permission.Student.User.id}}" class="btn btn-white btn-xs">보기</a>
												{% else %}
													<button class="btn btn-white btn-xs" disabled>미제출</button>
												{% endif %}
											</td>											
											{% if permission.firstProf.User.id != user.id %}
												<td class="_exp" >비공개</td>
											{% else %}
												<td>{{permission.firstProf.User.name}}</td>
											{% endif %}
											{% if permission.secondProf.User.id != user.id %}
												<td class="_exp" >비공개</td>
											{% else %}
												<td>{{permission.secondProf.User.name}}</td>
											{% endif %}
											{% if permission.thirdProf.User.id != user.id %}
												<td class="_exp" >비공개</td>
											{% else %}
												<td>{{permission.thirdProf.User.name}}</td>
											{% endif %}
											<td>
												{% if permission.firstProf.User.id == user.id && permission.firstSelected || permission.secondProf.User.id == user.id && permission.secondSelected || permission.thirdProf.User.id == user.id && permission.thirdSelected %}
													<button class="btn btn-blue btn-xs">선택됨</button>
												{% elseif permission.firstProf.User.id != user.id && permission.firstSelected %}
													<button class="btn btn-success btn-xs" disabled>선택</button>
												{% elseif permission.firstProf.User.id != user.id && permission.secondProf.User.id != user.id && permission.secondSelected %}
													<button class="btn btn-success btn-xs" disabled>선택</button>
												{% else %}
													{% if permission.firstProf.User.id == user.id %} 
														<button class="btn btn-success btn-xs" onclick="submit_proc({{permission.id}},1)">선택</button>
													{% else %}
														<button class="btn btn-success btn-xs" onclick="submit_proc({{permission.id}},2)">선택</button>
													{% endif %}
												{% endif %}
											</td>
											<td>
												{% if permission.firstProf.User.id != user.id && permission.firstSelected %}
													<div class="label label-danger">1지망 선택됨</div>
												{% elseif permission.firstProf.User.id != user.id && permission.secondProf.User.id != user.id && permission.secondSelected %}
													<div class="label label-danger">2지망 선택됨</div>
												{% endif %}												
											</td>
										</tr>
									{% endfor %}
								{% else %}
									<tr>
										<td colspan="10">배정 희망 학생이 없습니다.</td>
									</tr>
								{% endif %}
							</tbody>
						</table>
					</div>
					<h5 class="text-muted">
						※ 한 학기당 최대 지도 학생 선택 수는 {{permitcount}}명 입니다. (<b> 남은 선택 가능 학생 수 {{selectable}} 명</b> )
					</h5>					
				</div>
			</div>
		</div>
	</div>
{% endblock %}

{% block page_footer %}
	<script type="text/javascript">
		function submit_proc(id,type){
			if({{selectable}}>0){
				var flag=false;
				if(type==1){
					if(confirm("현재 남은 선택 가능 학생 수는 {{selectable}}명 입니다. 이 학생을 선택 하시겠습니까?")){
						flag=true;	
					} 
				}
				else if(type=2){
					if(confirm("2,3 지망 학생 선택의 경우 1,2지망 교수님이 선택시 취소 될 수 있습니다. 현재 남은 선택 가능 학생 수는 {{selectable}}명 입니다. 이 학생을 선택 하시겠습니까?")){
						flag=true;	
					} 	
				}
				if(flag){
					$.post("permission/ajax/set_student",{id:id}, function( data ) {
						if(!data.result){
                    		alert(data.text);
                    	}
                   		else{
                   			location.reload();
                   		}
					});
				}
			}
			else alert("지도 학생 선택 가능 학생수를 초과 하셨습니다. 더이상 선택 할 수 없습니다.");
		}
		jQuery(document).ready(function($) {
		});
	</script>
{% endblock %}