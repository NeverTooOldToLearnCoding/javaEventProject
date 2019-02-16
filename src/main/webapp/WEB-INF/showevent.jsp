<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

<title>Show Event</title>
</head>
<style>

.container{
	width: 460px;
	vertical-align: top;
	display: inline-block;
	height:500%;
	padding: 3%;
	margin-left:2%;
	margin-top: 2%;
	
}

.container h1{
	width: 400px;

}

.container table{
	outline:2px solid black;
}
.container a{
	margin-left:100%;

}
.comments{
	outline: 2px solid black;
	overflow-y:auto;
	height: 300px;
	width: 425px;

}

.box{
	width:400px;
	height:60px;
}



.error{
	color:red;
}


</style>
<body>


<div class = "container">
	<h1><c:out value="${event.eventName}"/></h1>
	
	
	<ul>Host: <c:out value="${event.host.firstName}"/> <c:out value="${event.host.lastName}"/></ul>
	<ul>Date: <c:out value="${event.eventDate}"/></ul>
	<ul>Location: <c:out value="${event.location}"/></ul>
	<ul>People who are attending this event: <c:out value="${event.getUsers().size()}"/></ul>

	<table class = "table table-striped">
		<tr>
			<th>Name</th>
			<th>Location</th>
		</tr>
	
	<c:forEach items="${event.getUsers()}" var="users">
		<tr>
			<td><c:out value="${users.firstName}"/> <c:out value="${users.lastName}"/></td>
			<td><c:out value="${users.location}"/></td>
		</tr>
		</c:forEach>
	</table>
</div>

<div class = "container">
	<a href="/events">Dashboard</a>
	<h1>Message Wall</h1>

	<div class = "comments">
	
		<c:forEach items="${event.getMessages()}" var="message">
			<ul><c:out value="${message.author.firstName}"/> <c:out value="${message.author.lastName}"/>:
			<c:out value="${message.comment}"/></p></ul>
			<ul><p>---------------------------------</p></ul>
		</c:forEach>
	</div>
	
		<p class = "error"><form:errors path="message.*"/></p>
		
		<form:form action="/events/${event.id}" method="post" modelAttribute="message">
        <p>
            <form:label path="comment">Add Comment: </form:label>
            
            <form:errors path="comment"/>
            <form:input class="box" type="text" path="comment"/>
        </p>
    	<input type="submit" value="Submit"/>
		</form:form>

</div>


</body>
</html>