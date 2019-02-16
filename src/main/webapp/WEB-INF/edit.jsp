<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit an Event</title>
</head>
<style>


.error{
	color:red;
}



.top a{
	margin-left:30%;
}

.top{
	margin:4%;
	padding:4%;
	
}

</style>



<body>

<div class = "top">

<h1><c:out value = "${event.eventName}"/></h1>

<a class = "dashboard" href="/events">Dashboard</a>




<h2>Edit Event</h2>


<p class = "error"><form:errors path="event.*"/></p>
<form:form action="/events/${event.id}/edit" method="post" modelAttribute="event">
<input type = 'hidden' name='_method' value='put'>
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

    <input type="submit" value="Edit"/>
    
</form:form>
</div>

</body>
</html>