<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>친구 찾기</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
</head>
<style>
	*{box-sizing: border-box;}
	.header{text-align:center;}
	.box_title{
	height:80px; 
	background-color:#FDFAF6; 
    color:black;
    border-radius:20px;
	}
    #title{line-height:80px;}
    #category{width:100%;}
    #keyword{width:100%; text-align:left;}
    #search_btn{width:100%;}
    #result{
    height:500px; 
    overflow-y:auto;
    }
    .list>div{line-height:70px;}
    input[type]:focus, button.form-control:focus, select.form-control:focus{ 
    border-color: rgba(211, 248, 150, 0.075);
    box-shadow: 0px 0px 1px rgba(211, 248, 150, 0.075) inset, 0px 0px 8px rgba(151, 248, 24, 0.6);
    }
    #friend{line-height:450px; text-align:center;}
    #noFriend{line-height:450px; text-align:center;}
    #imgbox {
    max-width:70px;
    min-width:70px;
    height:70px;
    border-radius:50%;
    text-align:center;
    overflow:hidden;
    }
    .profile_img{
	max-width:70px;
    min-width:70px;
    height:70px;
    border-radius:50%;
    text-align:center;
    }
    .toChat{min-width:87px;}
</style>
<script>
	$(function(){
		$("#container").on("click",".toChat",function(){
			let user2 = $(this).parents(".list").children(".email").text();
			console.log(user2);
			location.href="/chat/toChat?user2="+user2;
		})
	})
</script>
<body>
<!-- header -->
<jsp:include page="../layout/header.jsp"/>

<!-- body 부분 -->
	<form action="/chat/search" method="post">
		<div class="container p-5" id="container">
			<div class="row m-0 header">
				<div class="col-12 box_title">
					<h4 id="title">채팅 친구 찾기</h4>
				</div>
			</div>
			<div class="row m-0 pt-4 search">
				<div class="col-md-3 col-12">
					<select name="category" id="category" class="form-control">
						<option value="name" selected>이름</option>
						<option value="school">학교</option>
					</select>
				</div>
				<div class="col-md-6 col-12">
					<input type="text" name="keyword" id="keyword"
						placeholder="검색어를 입력하세요" class="form-control" value="${keyword}">
				</div>
				<div class="col-md-3 col-12">
					<button id="search_btn" class="form-control">검색</button>
				</div>
			</div>
			<div class="p-2 mt-3 result" id="result">
				<c:choose>
					<c:when test="${fn:length(list) != 0 }">
						<c:forEach var="i" items="${list}">
							<c:choose>
								<c:when test="${login.email != i.email }">
									<div class="row m-0 list">
										<div class="col-3 col-lg-2 m-4 p-0" id="imgbox">
											<c:choose>
											<c:when test="${i.sysName != null }">
												<img class="profile_img" src="/mem/display?fileName=${i.sysName}">
											</c:when>
											<c:otherwise>
												<img class="profile_img" src="/img/profile.png">
											</c:otherwise>
											</c:choose>
										</div>
										<div class="d-none d-md-block col-lg-2 m-4 p-2 email">${i.email}</div>
										<div class="col-3 col-lg-2 m-4 p-2">${i.school}</div>
										<div class="col-3 col-lg-1 m-4 p-2">${i.name}</div>
										<div class="col-3 col-lg-3 m-4 p-2">
											<input type="button" value="채팅하기" class="form-control mt-3 toChat">
										</div>
									</div>
									<hr>
								</c:when>
							</c:choose>
						</c:forEach>
					</c:when>
					<c:when test="${keyword != null and fn:length(list) == 0 }">
						<div class="row m-0">
							<div class=col-12>
								<h4 id="noFriend">검색 대상이 없습니다.</h4>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="row m-0">
							<div class="col-12">
								<h4 id="friend">친구를 찾아보세요</h4>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</form>
	
<!-- footer -->
<jsp:include page="../layout/footer.jsp"/>
</body>
</html>