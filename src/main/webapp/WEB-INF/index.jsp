<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome</title>

</head>
<style>

.container{
	width: 460px;
	vertical-align: top;
	display: inline-block;
	outline: 2px solid black;
	height:500%;
	padding: 3%;
	margin-left:2%;
	margin-top: 2%;
	
}

</style>
<body>

<div class = "container">
    <h1>Register!</h1>
    
    <p><form:errors path="user.*"/></p>
    
    <form:form method="POST" action="/registration" modelAttribute="user">
    
    	<p>
            <form:label path="firstName">First Name:</form:label>
            <form:input type="text" path="firstName"/>
        </p>
        
        <p>
            <form:label path="lastName">Last Name:</form:label>
            <form:input type="text" path="lastName"/>
        </p>
        
        <p>
            <form:label path="email">Email:</form:label>
            <form:input type="email" path="email"/>
        </p>
        <p>
            <form:label path="location">Location:</form:label>
            <form:input type="text" path="location"/>
        </p>
        
        <form:select path="state">
					  <form:option value="CA" label = "CA" />
					  <form:option value="WA" label = "WA" />
					  <form:option value="AZ" label = "AZ" />					  
		</form:select>
        
        
        <p>
            <form:label path="password">Password:</form:label>
            <form:password path="password"/>
        </p>
        <p>
            <form:label path="passwordConfirmation">Password Confirmation:</form:label>
            <form:password path="passwordConfirmation"/>
        </p>
        <input type="submit" value="Register!"/>
    </form:form>
    
</div>

<div class = "container">
    <h1>Login</h1>

    
    <p><form:errors path="user.*"/></p>
    
    <form method="post" action="/login">
        <p>
            <label type="text" for="email">Email</label>
            <input type="text" id="email" name="email"/>
        </p>
        <p>
            <label for="password">Password</label>
            <input type="password" id="password" name="password"/>
        </p>
        <input type="submit" value="Login!"/>
    </form>
    
    
    
</div>


</body>
</html>