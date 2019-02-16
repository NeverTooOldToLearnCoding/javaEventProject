<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<title>Events Home Page</title>
</head>
<style>

.top{
	margin:7%;

}

.top a{
	margin-left:100%;

}

.middle{
	margin:7%;
	outline: 2px solid black;
}
.error{
	color:red;
}

.bottom{
	margin:7%;
	outline: 2px solid black;
}

.bottom2{
	margin:7%;
	padding:5%;
	width: 400px;
	outline: 2px solid black;
	
}

.single{
	margin: 7%;
}



</style>



<body>

<div class = "top">
	<h1>Welcome, <c:out value="${user.firstName}" /></h1> <a href="/logout">Logout</a>
</div>


<div class = "middle">
<p class = "single">Here are some of the events in your state:</p>
	<table class = "table table-striped">
		<tr>
			<th>Name</th>
			<th>Date</th>
			<th>Location</th>
			<th>Host</th>
			<th>Action / Status</th>
		</tr>
		 		
		<c:forEach items="${events}" var="event">
		
		<c:if test="${event.state.equals(user.state)}">
		<tr>
			<td><a href = "/events/${event.id}" ><c:out value = "${event.eventName}"></a></c:out></td>
			<td><c:out value = "${event.eventDate}"></c:out></td>
			<td><c:out value = "${event.location}"></c:out></td>
 			<td><c:out value = "${event.host.firstName}"></c:out></td>
			<td>
			
			<c:choose>
			<c:when test="${user.id == event.host.id}">
			<a href="/events/${event.id}/edit">Edit</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="/events/${event.id}/delete">Delete</a>
			</c:when>
			
			<c:when test="${event.users.contains(user) == true}">
			<p>Joining&nbsp;
			<a href="/events/${event.id}/cancel">Cancel</a></p>
			</c:when>
			
			<c:otherwise>
			<a href="/events/${event.id}/join">Join</a>
			</c:otherwise>
			</c:choose>
			
			</td>
		</tr>
		
		</c:if>
	
		
		</c:forEach>
		
	</table>
</div>	


<div class = "bottom">
<p class = "single">Here are some events in other states:</p>
	<table class = "table table-striped">
		<tr>
			<th>Name</th>
			<th>Date</th>
			<th>Location</th>
			<th>State</th>
			<th>Host</th>
			<th>Action</th>
		</tr>
		
 		<c:forEach items="${events}" var="event">

 		<c:if test = "${event.state.equals(user.state) == false}">
		<tr>
			<td><a href = "/events/${event.id}" ><c:out value = "${event.eventName}"></c:out></a></td>
			<td><c:out value = "${event.eventDate}"></c:out></td>
			<td><c:out value = "${event.location}"></c:out></td>
			<td><c:out value = "${event.state}"></c:out></td>
			<td><c:out value = "${event.host.firstName}"></c:out></td>
		
			<td>
			
			<c:choose>
			<c:when test="${user.id == event.host.id}">
			<a href="/events/${event.id}/edit">Edit</a>
			<a href="/events/${event.id}/delete">Delete</a>
			</c:when>
			
			<c:when test="${event.users.contains(user) == true}">
			<p>Joining</p>
			<a href="/events/${event.id}/cancel">Cancel</a>
			</c:when>
			
			<c:otherwise>
			<a href="/events/${event.id}/join">Join</a>
			</c:otherwise>
			</c:choose>
			
			</td>

		</tr>
		</c:if>
		</c:forEach>
		
	</table>
</div>
	
<div class = "bottom2">

<h1>Create an Event</h1>

<p class = "error"><form:errors path="event.*"/></p>
<form:form action="/createEvent" method="post" modelAttribute="event">

     	<p>
            <form:label path="eventName">Name:</form:label>
            <form:errors path="eventName"/>
            <form:input type="text" path="eventName"/>
        </p>  
        <p>
            <form:label path="eventDate">Date:</form:label>
            <form:errors path="eventDate"/>
            <form:input type="date" path="eventDate"/>
        </p>
        <p>
            <form:label path="location">Location:</form:label>
            <form:errors path="location"/>
            <form:input type="text" path="location"/>
        </p>
        
        <form:select path="state">
					  <form:option value="CA" label = "CA" />
					  <form:option value="WA" label = "WA" />
					  <form:option value="AZ" label = "AZ" />
		</form:select>

    <input type="submit" value="Create"/>
    
</form:form>

</div>
	
</body>
</html>