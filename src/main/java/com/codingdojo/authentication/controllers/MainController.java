package com.codingdojo.authentication.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.authentication.models.Event;
import com.codingdojo.authentication.models.Message;
import com.codingdojo.authentication.models.User;
import com.codingdojo.authentication.services.EventService;
import com.codingdojo.authentication.services.MessageService;
import com.codingdojo.authentication.services.UserService;
import com.codingdojo.authentication.validator.UserValidator;



@Controller
public class MainController{
	
	//make a eventService and messageService dependency
	public final EventService eventService;
	public final MessageService messageService;
    private final UserService userService;
    private final UserValidator userValidator;
	
	
	//create a Main Controller object passing categoryService and productService through
	public MainController(EventService eventService, MessageService messageService,UserService userService, UserValidator userValidator) {
		this.eventService = eventService;
		this.messageService = messageService;
        this.userService = userService;
        this.userValidator = userValidator;
	}

    @RequestMapping("")
    public String registerForm(@Valid @ModelAttribute("user") User user) {
        return "index.jsp";
    }

    @RequestMapping(value="/registration", method=RequestMethod.POST)
    public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
        userValidator.validate(user, result);
        if(result.hasErrors()) {
            return "index.jsp";
        }
        User u = userService.registerUser(user);
        session.setAttribute("userId", u.getId());
        return "redirect:/events";
    }
    
    @RequestMapping(value="/login", method=RequestMethod.POST)
    public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session) {

    	boolean isAuthenticated = userService.authenticateUser(email, password);
    	
    	if(isAuthenticated) {
    		User u = userService.findByEmail(email);
    		session.setAttribute("userId", u.getId());
    		return "redirect:/events";
    	}else {
    	model.addAttribute("error", "Invalid Credentials. Please try again.");
    	return "index.jsp";
    	}
    }

    @RequestMapping("/events")
    public String home(@Valid @ModelAttribute("event") Event event,HttpSession session, Model model) {
        
    	// get user from session, save them in the model and return the home page
    	Long userId = (Long) session.getAttribute("userId");
    	User u = userService.findUserById(userId);
    	model.addAttribute("user",u);    
    	List<Event> allEvents = eventService.allEvents();
    	model.addAttribute("events",allEvents);
    	return "events.jsp";
    }
       
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        // invalidate session
        // redirect to login page
    	session.invalidate();
    	return "redirect:";
    }
    
    //renders new event page
    @RequestMapping("/events/{id}")
    public String showEvent(@Valid @ModelAttribute("message") Message message,@PathVariable("id") Long id, Model model,HttpSession session) {
    	
//    	Long userId = (Long) session.getAttribute("userId");
    	if(session.getAttribute("userId") == null) {
    		return "redirect:";
    	}else {
    	Event event = eventService.findEvent(id);
    	model.addAttribute("event",event);
    	}
    	return "showevent.jsp";
    }
    
	//creates an event
	@RequestMapping(value="/createEvent", method=RequestMethod.POST)
	public String create(@Valid @ModelAttribute("event") Event event,BindingResult result,HttpSession session, Model model) {
		if(result.hasErrors()) {
			
			//prevents page from being wiped out on the re-render when you create a blank
			//event
	    	Long userId = (Long) session.getAttribute("userId");
	    	User u = userService.findUserById(userId);
	    	model.addAttribute("user",u);    
	    	List<Event> allEvents = eventService.allEvents();
	    	model.addAttribute("events",allEvents);			
			return "events.jsp";
		}else{
			Long userId = (Long) session.getAttribute("userId");
			User user = userService.findUserById(userId);
			event.setHost(user);
			eventService.createEvent(event);
			return "redirect:/events";
		}
	}
	
	//deletes an event
    @RequestMapping("/events/{id}/delete")
    public String deleteEvent(@PathVariable("id") Long id, HttpSession session) {
    	if(session.getAttribute("userId") == null) {
    		return "redirect:";
    	}else {
    	eventService.deleteEvent(id);    	
    	return "redirect:/events";
    	}
    }
    
	//renders an event edit page
    @RequestMapping("/events/{id}/edit")
    public String editEvent(@Valid @PathVariable("id") Long id,Model model,HttpSession session) {
    	
    	if(session.getAttribute("userId") == null) {
    		return "redirect:";
    	}else {
    	Event event = eventService.findEvent(id);
    	model.addAttribute("event",event);
    	return "edit.jsp";
    	}
    }
    
    //update event
    @RequestMapping(value="/events/{id}/edit", method=RequestMethod.PUT)
    public String update(@Valid @ModelAttribute("event") Event event, BindingResult result,@PathVariable("id") Long id) {
        
    	if (result.hasErrors()) {
        	return "redirect:/events/"+id+"/edit";
        } else {
//			another way of saving the event        	
//        	eventService.findEvent(id);
//        	Long userId = (Long) session.getAttribute("userId");
//    		User user = userService.findUserById(userId);
//        	event.setHost(user);
        	Event event2 = eventService.findEvent(id);
        	event2.setEventName(event.getEventName());
        	event2.setEventDate(event.getEventDate());
        	event2.setLocation(event.getLocation());
        	event2.setState(event.getState());
        	eventService.updateEvent(event2);
        	return "redirect:/events";
        }
    }
        
    //joins an event
    @RequestMapping("/events/{id}/join")
    public String joinEvent(@PathVariable("id") Long id,HttpSession session) {
    	Event event = eventService.findEvent(id);
		Long userId = (Long) session.getAttribute("userId");
		User user = userService.findUserById(userId);
		event.getUsers().add(user);
		eventService.updateEvent(event);
		
    	return "redirect:/events";
    }
    
	//cancels an event
    @RequestMapping("/events/{id}/cancel")
    public String cancelEvent(@PathVariable("id") Long id, HttpSession session) {
    	Event event = eventService.findEvent(id);
		Long userId = (Long) session.getAttribute("userId");
		User user = userService.findUserById(userId);
		event.getUsers().remove(user);
		eventService.updateEvent(event);
    	return "redirect:/events";
    }
    
	//creates a message
	@RequestMapping(value="/events/{id}", method=RequestMethod.POST)
	public String createMessage(@Valid @ModelAttribute("message") Message message,BindingResult result,HttpSession session,@PathVariable("id") Long id, Model model) {
		if(result.hasErrors()) {
			
			//prevents event from being wiped out on the re-render on the page if
			//a user tries to submit a blank message
	    	Event event = eventService.findEvent(id);
	    	model.addAttribute("event",event);
			return "showevent.jsp";
		}else {
			
			Event event = eventService.findEvent(id);
			Long userId = (Long) session.getAttribute("userId");
			User user = userService.findUserById(userId);
			
			Message newMessage = new Message();
			newMessage.setAuthor(user);
			newMessage.setEvent(event);
			newMessage.setComment(message.getComment());

			messageService.createMessage(newMessage);
			event.getMessages().add(newMessage);
			eventService.updateEvent(event);			

//			message.setEvent(event);
			//ask Pete why this didn't take care of the message id for you

//			messageService.updateMessage(newMessage);

//			Long userId = (Long) session.getAttribute("userId");
//			User user = userService.findUserById(userId);
//			message.setHost(user);
//			messageService.createMessage(message);
			
			
			
			return "redirect:/events/"+id;
		}
	}
    

    
    
    


}