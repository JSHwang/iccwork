{% extends "layout.swig" %}

{% set page = "student_list" %}

{% block page_header %}
	<style>
		.btn {
			margin-bottom: 0px;
		}
		.form-horizontal .form-group-separator {
			height: 1px;
			background: #eee;
			margin-bottom: 15px;
		}
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">학생 현황</h1>
			<p class="description">{{ user.ids }} 계정의 {{ user.name }} 학생 정보입니다.</p>
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
		<div class="col-sm-12 form-horizontal">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">학생 기본 정보</h3>
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
				</div>
				<div class="panel-heading">
					<h3 class="panel-title">학생 작품/논문 정보</h3>
				</div>
				<div class="panel-body">
					<div class="form-group">
						<label class="col-sm-2 control-label">학기</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" value="{{ student.term }} 학기" disabled >
						</div>
						<label class="col-sm-2 control-label">재학/졸업 여부</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" value="{{ ["재학","휴학","수료","졸업"][student.status] }}" disabled >
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">작품/논문 여부</label>
						<div class="col-sm-4">
							{% if student.iswork %}
								<input type="text" class="form-control" value="작품" disabled >
							{% else %}
								<input type="text" class="form-control" value="논문" disabled >
							{% endif %}
						</div>
						<label class="col-sm-2 control-label">개인/공동 여부</label>
						<div class="col-sm-4">
							{% if student.isgroup %}
								<input type="text" class="form-control" value="공동" disabled >
							{% else %}
								<input type="text" class="form-control" value="개인" disabled >
							{% endif %}
						</div>
					</div>						
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">작품/논문 제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" value="{{ student.title }}" disabled >
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">심사 단계</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" value="{{ ["미심사","심사통과","심사탈락","기합격"][student.result] }}" disabled >
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">지도교수 메세지</label>
						<div class="col-sm-10">
							<textarea rows="3" class="form-control autogrow" placeholder="학생에게 보여지는 메시지란 입니다." disabled>{{student.note|safe}}</textarea>
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">비고</label>
						<div class="col-sm-10">
							<textarea rows="3" class="form-control autogrow" placeholder="학생에 관한 내용을 입력하는 비고란입니다." disabled>{{student.comment|safe}}</textarea>
						</div>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">졸업 예정 학기</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" value="{{ student.gryearterm }}" disabled >
						</div>
					</div>					
				</div>
				<div class="panel-heading">
					<h3 class="panel-title">학생 시스템 단계</h3>
				</div>
				<div class="panel-body">
					<div class="form-group">
						<label class="col-sm-2 control-label">시스템 단계</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" value="{{ student.System.phase }}" disabled >
						</div>
						<label class="col-sm-2 control-label">시스템 락 (다음 학기 진행)</label>
						<div class="col-sm-4">
							{% if student.islock %}
								<input type="text" class="form-control" value="예" disabled >
							{% else %}
								<input type="text" class="form-control" value="아니오" disabled >
							{% endif %}
						</div>
					</div>
				</div>
				<div class="panel-heading">
					<h3 class="panel-title">학생 교수 배정 정보</h3>
				</div>
				<div class="panel-body">
					<div class="form-group">
						<label class="col-sm-2 control-label">배정 학기</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" value="{{ student.yearterm }}" disabled >
						</div>
						<label class="col-sm-2 control-label">배정 교수</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" value="{{ student.Prof.User.name }}" disabled >
						</div>
					</div>
				</div>
				<div class="panel-heading">
					<h3 class="panel-title">졸업 작품/논문 정보</h3>
				</div>
				<div class="panel-body">
					<div class="form-group">
						<label class="col-sm-2 control-label">신청서</label>
						{% if student.StudentInfo %}
							<label class="col-sm-2 control-label" style="text-align:center;">{{ student.StudentInfo.time_ }} 제출</label>
							<div class="col-sm-8">
								<a href="../paperwork/application/{{user.id}}" class="btn btn-white">바로가기</a>
							</div>								
							{% else %}
							<div class="col-sm-10">
								<button class="btn btn-primary disabled">미제출</button>
							</div>
						{% endif %}
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">서약서</label>
						<form action="" method="post" enctype="multipart/form-data">
							{% if student.oath %}
								<label class="col-sm-2 control-label" style="text-align:center;">{{ student.oath.time_ }} 제출</label>
								<div class="col-sm-6" style="padding-top:7px;">
									<a href="{{student.oath.link}}">
										<i class="fa fa-file-o"></i> &nbsp;<b>{{student.oath.name}}</b>
									</a>
								</div>
								<div class="col-sm-2">
									<input type="hidden" name="delete" value="oath">
									<button class="btn btn-danger" type="submit" style="float:right;">삭제하기</button>
								</div>
							{% else %}
								<div class="col-sm-8">
									<input type="file" class="form-control" name="oath">
									<input type="hidden" name="upload" value="oath">
								</div>
								<div class="col-sm-2">
									<button class="btn btn-info" type="submit" style="float:right;">업로드</button>
								</div>							
							{% endif %}
						</form>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">제안서</label>
						<form action="" method="post" enctype="multipart/form-data">
							{% if student.proposal %}
								<label class="col-sm-2 control-label" style="text-align:center;">{{ student.proposal.time_ }} 제출</label>
								<div class="col-sm-6" style="padding-top:7px;">
									<a href="{{student.proposal.link}}">
										<i class="fa fa-file-o"></i> &nbsp;<b>{{student.proposal.name}}</b>
									</a>
								</div>
								<div class="col-sm-2">
									<input type="hidden" name="delete" value="proposal">
									<button class="btn btn-danger" type="submit" style="float:right;">삭제하기</button>
								</div>
							{% else %}
								<div class="col-sm-8">
									<input type="file" class="form-control" name="proposal">
									<input type="hidden" name="upload" value="proposal">
								</div>
								<div class="col-sm-2">
									<button class="btn btn-info" type="submit" style="float:right;">업로드</button>
								</div>							
							{% endif %}
						</form>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">중간보고서</label>
						<form action="" method="post" enctype="multipart/form-data">
							{% if student.midreport %}
								<label class="col-sm-2 control-label" style="text-align:center;">{{ student.midreport.time_ }} 제출</label>
								<div class="col-sm-6" style="padding-top:7px;">
									<a href="{{student.midreport.link}}">
										<i class="fa fa-file-o"></i> &nbsp;<b>{{student.midreport.name}}</b>
									</a>
								</div>
								<div class="col-sm-2">
									<input type="hidden" name="delete" value="midreport">
									<button class="btn btn-danger" type="submit" style="float:right;">삭제하기</button>
								</div>
							{% else %}
								<div class="col-sm-8">
									<input type="file" class="form-control" name="midreport">
									<input type="hidden" name="upload" value="midreport">
								</div>
								<div class="col-sm-2">
									<button class="btn btn-info" type="submit" style="float:right;">업로드</button>
								</div>							
							{% endif %}
						</form>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">최종보고서</label>
						<form action="" method="post" enctype="multipart/form-data">
							{% if student.finalreport %}
								<label class="col-sm-2 control-label" style="text-align:center;">{{ student.finalreport.time_ }} 제출</label>
								<div class="col-sm-6" style="padding-top:7px;">
									<a href="{{student.finalreport.link}}">
										<i class="fa fa-file-o"></i> &nbsp;<b>{{student.finalreport.name}}</b>
									</a>
								</div>
								<div class="col-sm-2">
									<input type="hidden" name="delete" value="finalreport">
									<button class="btn btn-danger" type="submit" style="float:right;">삭제하기</button>
								</div>
							{% else %}
								<div class="col-sm-8">
									<input type="file" class="form-control" name="finalreport">
									<input type="hidden" name="upload" value="finalreport">
								</div>
								<div class="col-sm-2">
									<button class="btn btn-info" type="submit" style="float:right;">업로드</button>
								</div>							
							{% endif %}
						</form>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">작품/논문</label>
						<form action="" method="post" enctype="multipart/form-data">
							{% if student.paperwork %}
								<label class="col-sm-2 control-label" style="text-align:center;">{{ student.paperwork.time_ }} 제출</label>
								<div class="col-sm-6" style="padding-top:7px;">
									<a href="{{student.paperwork.link}}">
										<i class="fa fa-file-o"></i> &nbsp;<b>{{student.paperwork.name}}</b>
									</a>
								</div>
								<div class="col-sm-2">
									<input type="hidden" name="delete" value="paperwork">
									<button class="btn btn-danger" type="submit" style="float:right;">삭제하기</button>
								</div>
							{% else %}
								<div class="col-sm-8">
									<input type="file" class="form-control" name="paperwork">
									<input type="hidden" name="upload" value="paperwork">
								</div>
								<div class="col-sm-2">
									<button class="btn btn-info" type="submit" style="float:right;">업로드</button>
								</div>							
							{% endif %}
						</form>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">교내발표자료</label>
						<form action="" method="post" enctype="multipart/form-data">
							{% if student.presentation %}
								<label class="col-sm-2 control-label" style="text-align:center;">{{ student.presentation.time_ }} 제출</label>
								<div class="col-sm-6" style="padding-top:7px;">
									<a href="{{student.presentation.link}}">
										<i class="fa fa-file-o"></i> &nbsp;<b>{{student.presentation.name}}</b>
									</a>
								</div>
								<div class="col-sm-2">
									<input type="hidden" name="delete" value="presentation">
									<button class="btn btn-danger" type="submit" style="float:right;">삭제하기</button>
								</div>
							{% else %}
								<div class="col-sm-8">
									<input type="file" class="form-control" name="presentation">
									<input type="hidden" name="upload" value="presentation">
								</div>
								<div class="col-sm-2">
									<button class="btn btn-info" type="submit" style="float:right;">업로드</button>
								</div>							
							{% endif %}
						</form>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">학회증빙자료</label>
						<form action="" method="post" enctype="multipart/form-data">
							{% if student.conference %}
								<label class="col-sm-2 control-label" style="text-align:center;">{{ student.conference.time_ }} 제출</label>
								<div class="col-sm-6" style="padding-top:7px;">
									<a href="{{student.conference.link}}">
										<i class="fa fa-file-o"></i> &nbsp;<b>{{student.conference.name}}</b>
									</a>
								</div>
								<div class="col-sm-2">
									<input type="hidden" name="delete" value="conference">
									<button class="btn btn-danger" type="submit" style="float:right;">삭제하기</button>
								</div>
							{% else %}
								<div class="col-sm-8">
									<input type="file" class="form-control" name="conference">
									<input type="hidden" name="upload" value="conference">
								</div>
								<div class="col-sm-2">
									<button class="btn btn-info" type="submit" style="float:right;">업로드</button>
								</div>							
							{% endif %}
						</form>
					</div>
					<div class="form-group-separator"></div>
					<div class="form-group">
						<div class="col-sm-12">
							<button type="button" class="btn btn-success" style="float:right;" onClick="window.history.back()">뒤로가기</button>
							<a href="../student_register/{{user.id}}" type="button" class="btn btn-info" style="float:right; margin-right:20px;">수정하기</a>
							<button type="button" class="btn btn-danger" style="float:right; margin-right:20px;" onClick="student_login()">로그인하기</button>								
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
{% endblock %}

{% block page_footer %}
	<script src="/assets/js/jquery.form.min.js"></script>	
	<script type="text/javascript">
		function student_login(){
			if(confirm("관리자 페이지가 로그아웃 되고 현재 {{user.name}} 학생의 {{user.ids}} 계정으로 로그인 됩니다. 로그인 하시겠습니까?")){
				document.location="../student_login/{{user.id}}";
			}
		}
		$("form").submit(function(event){
			event.preventDefault();
			var tmp=false;
			if($(this).find("input[name='delete']").val()){
				if(confirm("정말 삭제하시겠습니까?")) tmp=true;
			}
			else if($(this).find("input[type='file']").val()) tmp=true;
			if(tmp){
				$(this).ajaxSubmit({
	                beforeSubmit: function(arr, $form, options) {
	                	$(this).find('button[type="submit"]').attr("disabled", "disabled");
			            show_loading_bar(70);
	                },
	                success: function(data) {
                        show_loading_bar({
	                        delay: 1,
	                        pct: 100,
	                        finish: function() {
	                        	if(!data.result){
	                        		alert(data.text);
	                        		$('button[type="submit"]').removeAttr("disabled");
	                        	}
	                       		else{
	                       			window.location.reload();	
	                       		}
	                        }
	                    });
	                },
	                error: function(data) {
						show_loading_bar({
	                        delay: 1,
	                        pct: 100,
	                        finish: function() {
	                        	alert("에러가 발생하였습니다. 시스템 관리자에게 문의해주세요.");
	                        }
	                    });
	                }
	            });
			}
		});
	</script>
{% endblock %}