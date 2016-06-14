{% extends "layout.swig" %}

{% set page = "main" %}

{% block page_header %}
	<style>
	@media only screen and (min-width: 1440px) {
		.cbp_tmtime {
			padding-right: 150px !important;
		}
	}
	</style>
{% endblock %}

{% block page_body %}
	<div class="page-title">
		<div class="title-env">
			<h1 class="title">졸업 작품/논문 시스템에 접속하신걸 환영합니다!</h1>
			<p class="description">아래의 타임라인은 졸업 작품/논문 시스템의 단계와 일정입니다.</p>
		</div>
		<div class="breadcrumb-env">
			<ol class="breadcrumb bc-1">
				<li class="active">
					<a href="main"><i class="fa-home"></i>메인</a>
				</li>
			</ol>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-4">
			<div class="xe-widget xe-todo-list">
				<div class="xe-header">
					<div class="xe-icon">
						<i class="fa-file-text-o"></i>
					</div>
					<div class="xe-label">
						<strong>최근 사용자 로그인 기록</strong>
						<span>최근 로그인 기록 5개</span>
					</div>
				</div>
				<div class="xe-body" style="padding-bottom:0px;">						
					<ul class="list-unstyled" style="margin-bottom:0px;">
						{% for log in loginLog %}
							<li {% if !log.success %}class="false_log"{% endif %}>
								<label>
									<div class="cbr-replaced {% if log.success %}cbr-checked{% endif %}">
										<div class="cbr-input">
											<input type="checkbox" class="cbr cbr-done" checked="">
										</div>
										<div class="cbr-state"><span></span></div>
									</div>
									<span>{{log.time_}} - {{log.ip}} {% if !log.success %}( 로그인 실패 ){% endif %}</span>
								</label>
							</li>
						{% endfor %}
					</ul>						
				</div>
			</div>
		</div>
		<div class="col-sm-8">			
			<div class="xe-widget xe-conversations" style="margin-bottom:0px;">
				<div class="xe-bg-icon">
					<i class="linecons-comment"></i>
				</div>
				<div class="xe-header">
					<div class="xe-icon">						
						<i class="linecons-comment"></i>
					</div>
					<div class="xe-label">
						<h3>
							졸업작품시스템 메모
							<small>교수님 또는 관리자가 작성한 메시지 입니다.</small>
						</h3>
					</div>
				</div>
				<div class="xe-body" style="border-bottom:0px;">					
					<ul class="list-unstyled" style="margin-bottom:0px;">
						<li style="margin-bottom:0px;">
							<div class="xe-comment-entry">
								<div class="xe-comment" style="padding:10px 0px 0px 0px;">
									{% if student.note %}
										<pre style="margin-bottom:0px;">{{student.note|safe}}</pre>
									{% else %}
										<pre style="margin-bottom:0px; color:#aaa;">작성된 메시지가 없습니다.</pre>
									{% endif %}									
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>			
		</div>
	</div>


	<ul class="cbp_tmtimeline">
		{# 신청서 제출 #}
		{% if system.id < 2 %}
			{# 신청서 제출 단계 이전 #}
			<li>
				<time class="cbp_tmtime">
					<span>신청서 제출 단계</span>
					<span>(일정 미확정)</span>
				</time>				
				<div class="cbp_tmicon timeline-bg-red">
					<i class="el-edit"></i>
				</div>				
				<div class="cbp_tmlabel">
					<h2>
						<a href="#">신청서 제출은 6학기에 시작합니다.</a>
					</h2>
					<blockquote>
						<p>학생은 현재 [{{system.phase}}] 단계 입니다.</p>
						<p>6학기에 다시 확인해주시기 바랍니다.</p>
					</blockquote>					
				</div>
			</li>
		{% elseif system.id == 2 %}
			{# 신청서 제출 단계 일치 #}
			{% if systems[1].isUnder %}
				{# 기간 이전 #}
				<li>
					<time class="cbp_tmtime">
						<span>신청서 제출 단계</span>
						<span>{{systems[1].start_}} ~ {{systems[1].end_}}</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-red">
						<i class="el-edit"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">신청서 제출기간 이전입니다.</a>
						</h2>
						<blockquote>
							<p>신청서 제출은 {{systems[1].start__}} 부터 가능합니다.</p>
							<p>이후 다시 확인해주시기 바랍니다.</p>
						</blockquote>
					</div>
				</li>
			{% elseif systems[1].isNow %}
				{# 기간 중 #}
				<li>
					<time class="cbp_tmtime">
						<span>신청서 제출 단계</span>
						<span>{{systems[1].start_}} ~ {{systems[1].end_}}</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-red">
						<i class="el-edit"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">신청서 제출기간 입니다.</a>
						</h2>
						<blockquote>
							<p>신청서 제출은 {{systems[1].end__}} 까지 가능합니다.</p>
							<p>아래의 버튼을 통해 바로 진행할 수 있습니다.</p>
						</blockquote>
						<a href="system" class="btn btn-secondary">바로가기</a>
					</div>
				</li>
			{% else %}
				{# 기간 이후 #}
				<li>
					<time class="cbp_tmtime">
						<span>신청서 제출 단계</span>
						<span>(일정 미확정)</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-red">
						<i class="el-edit"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">신청서 제출기간 이전입니다.</a>
						</h2>
						<blockquote>
							<p>신청서 제출기간이 아직 확정되지 않았습니다.</p>
							<p>이후 다시 확인해주시기 바랍니다.</p>
						</blockquote>						
					</div>
				</li>
			{% endif %}
		{% else %}
			{# 신청서 제출 단계 이후 #}
			{% if student.StudentInfo %}
				{# 제출 완료 #}
				<li>
					<time class="cbp_tmtime">
						<span>신청서 제출 단계</span>
						<span>제출 완료</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-red">
						<i class="el-edit"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">신청서가 제출되었습니다.</a>
						</h2>
						{% if student.StudentInfoId != 1 %}
							<blockquote>
								<p>신청서 제출이 완료되었습니다.</p>
								<p>제출일 : <b>{{ student.StudentInfo.time_ }}</b></p>
							</blockquote>						
							<a href="system/application" class="btn btn-info">바로가기</a>
						{% else %}
							<blockquote>
								<p>신청서 제출이 완료되었습니다.</p>
							</blockquote>						
						{% endif %}
					</div>
				</li>
			{% else %}
				{# 미제출 #}
				<li>
					<time class="cbp_tmtime">
						<span>신청서 제출 단계</span>
						<span>미제출</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-red">
						<i class="el-edit"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">신청서가 제출되지 안았습니다.</a>
						</h2>
						<blockquote>
							<p>신청서가 제출되지 않았습니다. 시스템 단계가 불일치 합니다.</p>
							<p>행정실 또는 질문 및 답변 게시판에 문의해주세요.</b></p>
						</blockquote>
					</div>
				</li>
			{% endif %}
		{% endif %}



		{# 희망 교수 선택 #}
		{% if system.id < 3 %}
			{# 희망 교수 선택 단계 이전 #}
			<li>
				<time class="cbp_tmtime">
					<span>희망 교수 선택 단계</span>
					<span>(일정 미확정)</span>
				</time>				
				<div class="cbp_tmicon timeline-bg-warning">
					<i class="el-user"></i>
				</div>				
				<div class="cbp_tmlabel">
					<h2>
						<a href="#">희망 교수 선택은 [신청서 제출] 단계 이후에 시작합니다.</a>
					</h2>
					<blockquote>
						<p>학생은 현재 [{{system.phase}}] 단계 입니다.</p>
						<p>[신청서 제출] 단계 이후에 다시 확인해주시기 바랍니다.</p>
					</blockquote>					
				</div>
			</li>
		{% elseif system.id < 9 && !student.Prof %}
			{# 단계 일치 #}
			{% if systems[2].isUnder %}
				{# 기간 이전 #}
				<li>
					<time class="cbp_tmtime">
						<span>희망 교수 선택 단계</span>
						<span>{{systems[2].start_}} ~ {{systems[7].end_}}</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-warning">
						<i class="el-user"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">희망 교수 선택기간 이전입니다.</a>
						</h2>
						<blockquote>
							<p>희망 교수 선택은 {{systems[2].start__}} 부터 가능합니다.</p>
							<p>이후 다시 확인해주시기 바랍니다.</p>
						</blockquote>
					</div>
				</li>
			{% elseif systems[2].isOver %}
				{# 기간 이후 #}
				<li>
					<time class="cbp_tmtime">
						<span>희망 교수 선택 단계</span>
						<span>(일정 미확정)</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-warning">
						<i class="el-user"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">희망 교수 선택기간 이전입니다.</a>
						</h2>
						<blockquote>
							<p>희망 교수 선택기간이 아직 확정되지 않았습니다.</p>
							<p>이후 다시 확인해주시기 바랍니다.</p>
						</blockquote>						
					</div>
				</li>
			{% else %}			
				{# 기간 중 #}
				<li>
					<time class="cbp_tmtime">
						<span>희망 교수 선택 단계</span>
						<span>{{systems[2].start_}} ~ {{systems[6].end_}}</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-warning">
						<i class="el-user"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">희망 교수 선택기간 입니다.</a>
						</h2>
						<blockquote>
							<p>희망 교수 선택은 총 3차까지 진행됩니다.</p>
							<p>1차 선택 : {{systems[2].start_}} ~ {{systems[2].end_}} ( {{systems[2].end_}} 확정 )</p>
							<p>2차 선택 : {{systems[4].start_}} ~ {{systems[4].end_}} ( {{systems[4].end_}} 확정 )</p>
							<p>3차 선택 : {{systems[6].start_}} ~ {{systems[6].end_}} ( {{systems[6].end_}} 확정 )</p>
							<p>미배정시 다음 차수로 진행됩니다.</p>
							<p>아래의 버튼을 통해 바로 진행할 수 있습니다.</p>
						</blockquote>
						<a href="system" class="btn btn-secondary">바로가기</a>
					</div>
				</li>
			{% endif %}
		{% else %}
			{# 6학기 이후 또는 단계 미일치 #}
			{% if student.Prof %}
				{# 배정 완료 #}
				<li>
					<time class="cbp_tmtime">
						<span>희망 교수 선택 단계</span>
						<span>배정 완료</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-warning">
						<i class="el-user"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">교수 배정이 완료되었습니다.</a>
						</h2>
						<blockquote>
							<p>선택하신 교수님의 배정이 완료되었습니다.</p>
							<p>성함 : <b>{{prof.User.name}}</b></p>
							<p>이메일 : <b>{{prof.User.email}}</b></p>
							<p>연락처 : <b>{{prof.User.phone}}</b></p>
						</blockquote>
					</div>
				</li>
			{% else %}
				{# 미배정 #}
				<li>
					<time class="cbp_tmtime">
						<span>희망 교수 선택 단계</span>
						<span>미배정</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-warning">
						<i class="el-user"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">교수 배정이 완료되지 않았습니다.</a>
						</h2>
						<blockquote>
							<p>교수 배정이 완료되지 않았습니다. 시스템 단계가 불일치 합니다.</p>
							<p>행정실 또는 질문 및 답변 게시판에 문의해주세요.</b></p>
						</blockquote>
					</div>
				</li>
			{% endif %}
		{% endif %}



		{# 서약서 및 제안서 제출 #}
		{% if system.id < 9 %}
			{# 서약서 및 제안서 제출 단계 이전 #}
			<li>
				<time class="cbp_tmtime">
					<span>서약서 및 제안서 제출 단계</span>
					<span>(일정 미확정)</span>
				</time>				
				<div class="cbp_tmicon timeline-bg-secondary">
					<i class="el-doc"></i>
				</div>				
				<div class="cbp_tmlabel">
					<h2>
						<a href="#">서약서 및 제안서 제출은 [희망 교수 선택] 단계 이후에 시작합니다.</a>
					</h2>
					<blockquote>
						<p>학생은 현재 [{{system.phase}}] 단계 입니다.</p>
						<p>[희망 교수 선택] 단계 이후에 다시 확인해주시기 바랍니다.</p>
					</blockquote>					
				</div>
			</li>
		{% elseif system.id == 9 %}
			{# 서약서 및 제안서 제출 단계 일치 #}
			{% if student.islock %}
				{# 기간 이전 (시스템 락) #}
				<li>
					<time class="cbp_tmtime">
						<span>서약서 및 제안서 제출 단계</span>
						<span>(일정 미확정)</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-secondary">
						<i class="el-doc"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">서약서 및 제안서 제출기간 이전입니다.</a>
						</h2>
						<blockquote>
							<p>서약서 및 제안서 제출은 다음 학기에 진행됩니다.</p>
							<p>이후 다시 확인해주시기 바랍니다.</p>
						</blockquote>
					</div>
				</li>
			{% elseif systems[8].isUnder %}
				{# 기간 이전 #}
				<li>
					<time class="cbp_tmtime">
						<span>서약서 및 제안서 제출 단계</span>
						<span>{{systems[8].start_}} ~ {{systems[8].end_}}</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-secondary">
						<i class="el-doc"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">서약서 및 제안서 제출기간 이전입니다.</a>
						</h2>
						<blockquote>
							<p>서약서 및 제안서 제출은 {{systems[8].start__}} 부터 가능합니다.</p>
							<p>이후 다시 확인해주시기 바랍니다.</p>
						</blockquote>
					</div>
				</li>
			{% elseif systems[8].isNow %}
				{# 기간 중 #}
				<li>
					<time class="cbp_tmtime">
						<span>서약서 및 제안서 제출 단계</span>
						<span>{{systems[8].start_}} ~ {{systems[8].end_}}</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-secondary">
						<i class="el-doc"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">서약서 및 제안서 제출기간 입니다.</a>
						</h2>
						<blockquote>
							<p>서약서 및 제안서 제출은 {{systems[8].end__}} 까지 가능합니다.</p>
							<p>아래의 버튼을 통해 바로 진행할 수 있습니다.</p>
						</blockquote>
						<a href="system" class="btn btn-secondary">바로가기</a>
					</div>
				</li>
			{% else %}
				{# 기간 이후 #}
				<li>
					<time class="cbp_tmtime">
						<span>서약서 및 제안서 제출 단계</span>
						<span>(일정 미확정)</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-secondary">
						<i class="el-doc"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">서약서 및 제안서 제출기간 이전입니다.</a>
						</h2>
						<blockquote>
							<p>서약서 및 제안서 제출기간이 아직 확정되지 않았습니다.</p>
							<p>이후 다시 확인해주시기 바랍니다.</p>
						</blockquote>						
					</div>
				</li>
			{% endif %}
		{% else %}
			{# 6학기 이후 또는 단계 미일치 #}
			{% if student.oath || student.proposal %}
				{# 제출 완료 #}
				<li>
					<time class="cbp_tmtime">
						<span>서약서 및 제안서 제출 단계</span>
						<span>제출 완료</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-secondary">
						<i class="el-doc"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">서약서 및 제안서가 제출되었습니다.</a>
						</h2>
						{% if student.oathId == 1 && student.proposalId == 1 %}
							<blockquote>
								<p>서약서 및 제안서 제출이 완료되었습니다.</p>
							</blockquote>
						{% else %}
							<blockquote>
								<p>서약서 및 제안서 제출이 완료되었습니다.</p>
								<p>서약서 파일명 : <b>{{student.oath.name}}</b></p>
								<p>제안서 파일명 : <b>{{student.proposal.name}}</b></p>
							</blockquote>						
							<a href="{{student.oath.link}}" class="btn btn-info">서약서 다운로드</a>
							<a href="{{student.proposal.link}}" class="btn btn-info">제안서 다운로드</a>
						{% endif %}
					</div>
				</li>
			{% else %}
				{# 미제출 #}
				<li>
					<time class="cbp_tmtime">
						<span>서약서 및 제안서 제출 단계</span>
						<span>미제출</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-secondary">
						<i class="el-doc"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">서약서 및 제안서가 제출되지 안았습니다.</a>
						</h2>
						<blockquote>
							<p>서약서 및 제안서가 제출되지 않았습니다. 시스템 단계가 불일치 합니다.</p>
							<p>행정실 또는 질문 및 답변 게시판에 문의해주세요.</b></p>
						</blockquote>
					</div>
				</li>
			{% endif %}
		{% endif %}



		{# 중간보고서 제출 #}
		{% if system.id < 10 %}
			{# 8학기 이전 #}
			<li>
				<time class="cbp_tmtime">
					<span>중간보고서 제출 단계</span>
					<span>(일정 미확정)</span>
				</time>				
				<div class="cbp_tmicon timeline-bg-info">
					<i class="el-doc"></i>
				</div>				
				<div class="cbp_tmlabel">
					<h2>
						<a href="#">중간보고서 제출은 [서약서 및 제안서 제출] 단계 이후에 시작합니다.</a>
					</h2>
					<blockquote>
						<p>학생은 현재 [{{system.phase}}] 단계 입니다.</p>
						<p>[서약서 및 제안서 제출] 단계 이후에 다시 확인해주시기 바랍니다.</p>
					</blockquote>					
				</div>
			</li>
		{% elseif system.id == 10 %}
			{# 단계 일치 #}
			{% if student.islock %}
				{# 기간 이전 (시스템 락) #}
				<li>
					<time class="cbp_tmtime">
						<span>중간보고서 제출 단계</span>
					<span>(일정 미확정)</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-secondary">
						<i class="el-doc"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">중간보고서 제출기간 이전입니다.</a>
						</h2>
						<blockquote>
							<p>중간보고서 제출은 다음 학기에 진행됩니다.</p>
							<p>이후 다시 확인해주시기 바랍니다.</p>
						</blockquote>
					</div>
				</li>
			{% elseif systems[9].isUnder %}
				{# 기간 이전 #}
				<li>
					<time class="cbp_tmtime">
						<span>중간보고서 제출 단계</span>
						<span>{{systems[9].start_}} ~ {{systems[9].end_}}</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-info">
						<i class="el-doc"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">중간보고서 제출기간 이전입니다.</a>
						</h2>
						<blockquote>
							<p>중간보고서 제출은 {{systems[9].start__}} 부터 가능합니다.</p>
							<p>이후 다시 확인해주시기 바랍니다.</p>
						</blockquote>
					</div>
				</li>
			{% elseif systems[9].isNow %}
				{# 기간 중 #}
				<li>
					<time class="cbp_tmtime">
						<span>중간보고서 제출 단계</span>
						<span>{{systems[9].start_}} ~ {{systems[9].end_}}</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-info">
						<i class="el-doc"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">중간보고서 제출기간 입니다.</a>
						</h2>
						<blockquote>
							<p>중간보고서 제출은 {{systems[9].end__}} 까지 가능합니다.</p>
							<p>아래의 버튼을 통해 바로 진행할 수 있습니다.</p>
						</blockquote>
						<a href="system" class="btn btn-secondary">바로가기</a>
					</div>
				</li>
			{% else %}
				{# 기간 이후 #}
				<li>
					<time class="cbp_tmtime">
						<span>중간보고서 제출 단계</span>
						<span>(일정 미확정)</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-info">
						<i class="el-doc"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">중간보고서 제출기간 이전입니다.</a>
						</h2>
						<blockquote>
							<p>중간보고서 제출기간이 아직 확정되지 않았습니다.</p>
							<p>이후 다시 확인해주시기 바랍니다.</p>
						</blockquote>						
					</div>
				</li>
			{% endif %}
		{% else %}
			{# 6학기 이후 또는 단계 미일치 #}
			{% if student.midreport %}
				{# 제출 완료 #}
				<li>
					<time class="cbp_tmtime">
						<span>중간보고서 제출 단계</span>
						<span>제출 완료</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-info">
						<i class="el-doc"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">중간보고서가 제출되었습니다.</a>
						</h2>
						<blockquote>
							<p>중간보고서 제출이 완료되었습니다.</p>
							<p>파일명 : <b>{{student.midreport.name}}</b></p>
						</blockquote>						
						<a href="{{student.midreport.link}}" class="btn btn-info">다운로드</a>
					</div>
				</li>
			{% else %}
				{# 미제출 #}
				<li>
					<time class="cbp_tmtime">
						<span>중간보고서 제출 단계</span>
						<span>미제출</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-info">
						<i class="el-doc"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">중간보고서가 제출되지 안았습니다.</a>
						</h2>
						<blockquote>
							<p>중간보고서가 제출되지 않았습니다. 시스템 단계가 불일치 합니다.</p>
							<p>행정실 또는 질문 및 답변 게시판에 문의해주세요.</b></p>
						</blockquote>
					</div>
				</li>
			{% endif %}
		{% endif %}



		{# 최종보고서 및 작품/논문, 발표자료 제출 #}
		{% if system.id < 11 %}
			{# 8학기 이전 #}
			<li>
				<time class="cbp_tmtime">
					<span>최종보고서 및 작품/논문, 교내 발표자료 제출 단계</span>
					<span>(일정 미확정)</span>
				</time>				
				<div class="cbp_tmicon timeline-bg-blue">
					<i class="fa-copy"></i>
				</div>				
				<div class="cbp_tmlabel">
					<h2>
						<a href="#">최종보고서 및 작품/논문, 교내 발표자료 제출은 [중간보고서 제출] 단계 이후에 시작합니다.</a>
					</h2>
					<blockquote>
						<p>학생은 현재 [{{system.phase}}] 단계 입니다.</p>
						<p>[중간보고서 제출] 단계 이후에 다시 확인해주시기 바랍니다.</p>
					</blockquote>					
				</div>
			</li>
		{% elseif system.id == 11 %}
			{# 단계 일치 #}
			{% if systems[10].isUnder %}
				{# 기간 이전 #}
				<li>
					<time class="cbp_tmtime">
						<span>최종보고서 및 작품/논문, 교내 발표자료 제출 단계</span>
						<span>{{systems[10].start_}} ~ {{systems[10].end_}}</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-blue">
						<i class="fa-copy"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">최종보고서 및 작품/논문, 교내 발표자료 제출기간 이전입니다.</a>
						</h2>
						<blockquote>
							<p>최종보고서 및 작품/논문, 교내 발표자료 제출은 {{systems[10].start__}} 부터 가능합니다.</p>
							<p>이후 다시 확인해주시기 바랍니다.</p>
						</blockquote>
					</div>
				</li>
			{% elseif systems[10].isNow %}
				{# 기간 중 #}
				<li>
					<time class="cbp_tmtime">
						<span>최종보고서 및 작품/논문, 교내 발표자료 제출 단계</span>
						<span>{{systems[10].start_}} ~ {{systems[10].end_}}</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-blue">
						<i class="fa-copy"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">최종보고서 및 작품/논문, 교내 발표자료 제출기간 입니다.</a>
						</h2>
						<blockquote>
							<p>최종보고서 및 작품/논문, 교내 발표자료 제출은 {{systems[10].end__}} 까지 가능합니다.</p>
							<p>아래의 버튼을 통해 바로 진행할 수 있습니다.</p>
						</blockquote>
						<a href="system" class="btn btn-secondary">바로가기</a>
					</div>
				</li>
			{% else %}
				{# 기간 이후 #}
				<li>
					<time class="cbp_tmtime">
						<span>최종보고서 및 작품/논문, 교내 발표자료 제출 단계</span>
						<span>(일정 미확정)</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-blue">
						<i class="fa-copy"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">최종보고서 및 작품/논문, 교내 발표자료 제출기간 이전입니다.</a>
						</h2>
						<blockquote>
							<p>최종보고서 및 작품/논문, 교내 발표자료 제출기간이 아직 확정되지 않았습니다.</p>
							<p>이후 다시 확인해주시기 바랍니다.</p>
						</blockquote>						
					</div>
				</li>
			{% endif %}
		{% else %}
			{# 8학기 이후 또는 단계 미일치 #}
			{% if student.finalreport || student.paperwork || student.presentation || student.conference %}
				{# 제출 완료 #}
				<li>
					<time class="cbp_tmtime">
						<span>최종보고서 및 작품/논문, 교내 발표자료 제출 단계</span>
						<span>제출 완료</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-blue">
						<i class="fa-copy"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">최종보고서 및 작품/논문, 발표자료가 제출되었습니다.</a>
						</h2>
						<blockquote>
							<p>최종보고서 및 작품/논문, 교내 발표자료 제출이 완료되었습니다.</p>
							<p>최종보고서 파일명 : <b>{{student.finalreport.name}}</b></p>
							<p>작품/논문 파일명 : <b>{{student.paperwork.name}}</b></p>
							<p>교내 발표자료 파일명 : <b>{{student.presentation.name}}</b></p>
							<p>학회 발표증빙자료 파일명 : <b>{{student.conference.name}}</b></p>
						</blockquote>						
						<a href="{{student.finalreport.link}}" class="btn btn-info">최종보고서 다운로드</a>
						<a href="{{student.paperwork.link}}" class="btn btn-info">작품/논문 다운로드</a>
						<a href="{{student.presentation.link}}" class="btn btn-info">교내 발표자료 다운로드</a>
						<a href="{{student.conference.link}}" class="btn btn-info">학회 발표증빙자료 다운로드</a>
					</div>
				</li>
			{% else %}
				{# 미제출 #}
				<li>
					<time class="cbp_tmtime">
						<span>최종보고서 및 작품/논문, 교내 발표자료 제출 단계</span>
						<span>미제출</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-blue">
						<i class="fa-copy"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">최종보고서 및 작품/논문, 교내 발표자료가 제출되지 안았습니다.</a>
						</h2>
						<blockquote>
							<p>최종보고서 및 작품/논문, 교내 발표자료가 제출되지 않았습니다.</p>
							<p>시스템 단계가 불일치 합니다.</p>
							<p>행정실 또는 질문 및 답변 게시판에 문의해주세요.</b></p>
						</blockquote>
					</div>
				</li>
			{% endif %}
		{% endif %}



		{# 논문 심사 #}
		{% if system.id < 12 %}
			{# 8학기 이전 #}
			<li>
				<time class="cbp_tmtime">
					<span>작품/논문 심사 단계</span>
					<span>(일정 미확정)</span>
				</time>				
				<div class="cbp_tmicon timeline-bg-purple">
					<i class="fa-graduation-cap"></i>
				</div>				
				<div class="cbp_tmlabel">
					<h2>
						<a href="#">작품/논문 심사는 [최종보고서 및 작품/논문, 교내 발표자료 제출] 단계 이후에 시작합니다.</a>
					</h2>
					<blockquote>
						<p>학생은 현재 [{{system.phase}}] 단계 입니다.</p>
						<p>[최종보고서 및 작품/논문, 교내 발표자료 제출] 단계 이후에 다시 확인해주시기 바랍니다.</p>
					</blockquote>					
				</div>
			</li>
		{% elseif system.id == 12 %}
			{# 단계 일치 #}
			{% if systems[11].isUnder %}
				{# 기간 이전 #}
				<li>
					<time class="cbp_tmtime">
						<span>작품/논문 심사 단계</span>
						<span>{{systems[11].start_}} ~ {{systems[11].end_}}</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-purple">
						<i class="fa-graduation-cap"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">작품/논문 심사기간 이전입니다.</a>
						</h2>
						<blockquote>
							<p>작품/논문 심사는 {{systems[11].start__}} 부터 진행합니다.</p>
							<p>이후 다시 확인해주시기 바랍니다.</p>
						</blockquote>
					</div>
				</li>
			{% elseif systems[11].isNow %}
				{# 기간 중 #}
				<li>
					<time class="cbp_tmtime">
						<span>작품/논문 심사 단계</span>
						<span>{{systems[11].start_}} ~ {{systems[11].end_}}</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-purple">
						<i class="fa-graduation-cap"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">작품/논문 심사기간 입니다.</a>
						</h2>
						<blockquote>
							<p>작품/논문 심사는 {{systems[11].end__}} 까지 진행됩니다.</p>
							<p>이후 현재 페이지에서 결과를 확인 할 수 있습니다.</p>
						</blockquote>
					</div>
				</li>
			{% else %}
				{# 기간 이후 #}
				<li>
					<time class="cbp_tmtime">
						<span>작품/논문 심사 단계</span>
						<span>(일정 미확정)</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-purple">
						<i class="fa-graduation-cap"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">작품/논문 심사기간 이전입니다.</a>
						</h2>
						<blockquote>
							<p>작품/논문 심사기간이 아직 확정되지 않았습니다.</p>
							<p>이후 다시 확인해주시기 바랍니다.</p>
						</blockquote>						
					</div>
				</li>
			{% endif %}
		{% else %}
			{# 8학기 이후 또는 단계 미일치 #}
			{% if system.id == 13 || student.isdisplay && student.result > 0 %}
				{# 심사 완료 #}
				<li>
					<time class="cbp_tmtime">
						<span>작품/논문 심사 단계</span>
						<span>심사 완료</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-purple">
						<i class="fa-graduation-cap"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">작품/논문 심사가 완료되었습니다.</a>
						</h2>
						<blockquote>
							<p>작품/논문 제목 : {{student.title}}</p>
							{% if student.result==1 %}
								<p>심사 결과  : <b>심사 통과</b></p>
							{% elseif student.result==2 %}
								<p>심사 결과  : <b>심사 탈락</b></p>
							{% elseif student.result==3 %}
								<p>심사 결과  : <b>기합격</b></p>
							{% endif %}
						</blockquote>
					</div>
				</li>
			{% else %}
				{# 미완료 #}
				<li>
					<time class="cbp_tmtime">
						<span>작품/논문 심사 단계</span>
						<span>심사 미완료</span>
					</time>				
					<div class="cbp_tmicon timeline-bg-purple">
						<i class="fa-graduation-cap"></i>
					</div>				
					<div class="cbp_tmlabel">
						<h2>
							<a href="#">작품/논문 심사가 완료되지 안았습니다.</a>
						</h2>
						<blockquote>
							<p>작품/논문 심사가 완료되지 안았습니다. 시스템 단계가 불일치 합니다.</p>
							<p>행정실 또는 질문 및 답변 게시판에 문의해주세요.</b></p>
						</blockquote>
					</div>
				</li>
			{% endif %}
		{% endif %}


	</ul>
{% endblock %}

{% block page_footer %}
	<script type="text/javascript">
		jQuery(document).ready(function($) {
		});
	</script>
{% endblock %}
