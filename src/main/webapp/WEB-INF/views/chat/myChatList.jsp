<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 채팅방</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<style>
	*{box-sizing: border-box;}
	.empty{height:50px;}
	.box_title {
	/* background-color: rgb(255, 203, 72, 0.3); */
	background-color: #FDFAF6;
	border-radius:30px;
	 /* min-width:500px;*/
	 text-align :center;
	 margin-bottom: 50px;
	}
	#title{display:inline-block;color:#064420;}
	.list {
	height: 500px;
	overflow-y :auto;
	}
	#no_list {
	height: 100%;
	font-size: 30px;
	font-weight: bold;
	line-height: 500px;
	text-align: center;
	}
	.list_box {height: 100%;}
	#container div>a {text-decoration:none;}
	.img_box {
	max-width: 80px;
	min-width: 80px;
	height: 80px;
	border-radius: 50%;
	text-align: center;
	}
	.img_profile {
	max-width: 80px;
	min-width: 80px;
	height: 80px;
	border-radius: 50%;
	}
	.contents {
	text-align: center;
	line-height: 80px;
	overflow-y :auto;
	max-height:80px;
	}
	.chat_link{color:#064420; font-size:18px; font-weight:bold;}
	.to_chat {text-align: center; min-width: 198px;}
	.chat_list{
	border-bottom: 3px solid #E4EFE7;
    padding-bottom: 10px;
    padding-top: 10px;
}
	}
</style>
</head>
<body>
	<jsp:include page="../layout/header.jsp" />
	<div class="empty"></div>
	<div class="container p-3" id="container">
		<div class="row m-0 header">
			<div class="col-12 p-4 box_title">
					<c:if test="${login.sysName != null}">
						<img class="img_profile" src="/mem/display?fileName=${login.sysName}">
					</c:if>
					<c:if test="${login.sysName == null}">
						<img class="img_profile" src="/img/profile.png">
					</c:if>
				<h4 class="p-3" id="title">${login.name }님의 채팅방 목록&nbsp;<i class="far fa-comment-dots"></i></h4>
			</div>
		</div>
		<div class="list m-0 p-3">
			<c:choose>
				<c:when test="${fn:length(infoList) == 0}">
					<div class="row list_box m-0">
						<div class="col-12" id="no_list">
							<a href="/chat/findFriend" style="color:#A9CCB3">채팅할 친구 찾으러 가기</a>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach var="infoList" items="${infoList}">
						<c:choose>
							<c:when test="${infoList.user1 == login.email}">
								<div class="row chat_list pl-5 m-0">
									<div class="col-2 p-4 ${infoList.room_number}"></div>
									<script>
        				 			 $.ajax({
        				 		    	  url:"/chat/lastChatProc",
        				 		    	  data:{roomN:"${infoList.room_number}"},
        				 		    	  dataType:"json",
        				 		    	  type:"POST"
        				 		      }).done(function(resp){
        				 		    		let div = $("<div class='d-none d-sm-block col-sm-5 contents'>");
        				 		    		if(resp != null){
        				 		    	  		div.append(resp.contents);
        				 		    	  		let sub = $("<sub class='p-1'>");
        				 		    	  		sub.append(resp.time);
        				 		    	  		div.append(sub);
        				 		    	  		$("."+${infoList.room_number}).after(div);
        				 		    	  	}else{
        				 		    	  		div.append("메세지 내역이 없습니다.")
        				 		    			$("."+${infoList.room_number}).after(div);
        				 		    	  	}
        				 		      });
        				 			 $.ajax({
        				 				 url:"/chat/findNameProc",
        				 				 data:{findEmail:"${infoList.user2}"},
        				 				 dataType:"json",
      				 		    	  	 type:"POST"
        				 			 }).done(function(resp){
        				 				 if(resp.email == "${infoList.user2}" ){
        				 					$("."+${infoList.room_number}).text(resp.name);
        				 					
        				 					let div = $("<div class='col-6 col-sm-2 p-0 img_box'>");
        				 					let img = $("<img class='img_profile'>")
        				 					
        				 					if(resp.sysName != null){
        				 						img.attr("src","/mem/display?fileName="+resp.sysName);
        				 					}else{
        				 						img.attr("src","/img/profile.png");
        				 					}
        				 					div.append(img);
        				 					$("."+${infoList.room_number}).before(div);
        				 				 }
        				 			 });
        				 			</script>
									<div class="col-3 p-4 to_chat">
										<a class="chat_link" href="/chat/chatListToChat?room_number=${infoList.room_number}">채팅하기</a>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="row chat_list pl-5 m-0">
									<div class="col-2 p-4 ${infoList.room_number}">${infoList.user1}</div>
									<script>
        				 			 $.ajax({
        				 		    	  url:"/chat/lastChatProc",
        				 		    	  data:{roomN:"${infoList.room_number}"},
        				 		    	  dataType:"json",
        				 		    	  type:"POST"
        				 		      }).done(function(resp){
        				 		    		let div = $("<div class='d-none d-sm-block col-sm-5 contents'>");
        				 		    		
        				 		    		if(resp != null){
        				 		    			div.append(resp.contents);
        				 		    	  		let sub = $("<sub class='p-1'>");
        				 		    	  		sub.append(resp.time);
        				 		    	  		div.append(sub);
        				 		    	  		$("."+${infoList.room_number}).after(div);
        				 		    		}else{
        				 		    			div.append("메세지 내역이 없습니다.")
        				 		    			$("."+${infoList.room_number}).after(div);
        				 		    		}	
        				 		      });
        				 			 $.ajax({
        				 				 url:"/chat/findNameProc",
        				 				 data:{findEmail:"${infoList.user1}"},
        				 				 dataType:"json",
      				 		    	  	 type:"POST"
        				 			 }).done(function(resp){
        				 				 if(resp.email == "${infoList.user1}" ){
         				 					$("."+${infoList.room_number}).text(resp.name);
         				 					
         				 					let div = $("<div class='col-2 p-0 img_box'>");
        				 					let img = $("<img class='img_profile'>")
        				 					
        				 					if(resp.sysName != null){
        				 						img.attr("src","/mem/display?fileName="+resp.sysName);
        				 					}else{
        				 						img.attr("src","/img/profile.png");
        				 					}
        				 					div.append(img);
        				 					$("."+${infoList.room_number}).before(div);
        				 				 }
        				 			 })
        				 			</script>
									<div class="col-3 p-4 to_chat">
										<a class="chat_link" href="/chat/chatListToChat?room_number=${infoList.room_number}">채팅하기</a>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="empty"></div>
	<jsp:include page="../layout/footer.jsp" />
</body>
</html>