package com.codingdojo.authentication.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.codingdojo.authentication.models.Event;
import com.codingdojo.authentication.repositories.EventRepo;

@Service
public class EventService{
	//creating your attributes to Event Service
	//adding the Event repo as a dependency
	public final EventRepo eventRepo;
	
	//creating a Event Service constructor using the Event repo
	public EventService (EventRepo eventRepo) {
		this.eventRepo = eventRepo;
	}
	
	//creating method for querying all Events in Event Repo (database)
	
	//returns all the Events
	public List<Event> allEvents(){
		return eventRepo.findAllByOrderByIdAsc();
	}
	
	//creating a Event
	public Event createEvent(Event event) {
		return eventRepo.save(event);
	}
	
	//retrieving a Event from the database
	public Event findEvent(Long id) {
		Optional<Event> optionalEvent = eventRepo.findById(id);
		if(optionalEvent.isPresent()) {
			return optionalEvent.get();
		}else {
			return null;
		}
	}
	
	//update the Event info
	public Event updateEvent(Event event) {
		eventRepo.save(event);
		return event;
		
	}
	
    //update a Event
//  public Book updateBook(Long id, String title, String desc,String lang,int numOfPages) {
//  	Book book = findBook(id);
//  	book.setTitle(title);
//  	book.setDescription(desc);
//  	book.setLanguage(lang);
//  	book.setNumberOfPages(numOfPages);
//  	bookRepository.save(book);
//  	return book;
//  }
	
	//delete a Event
	public void deleteEvent(Long id) {
		eventRepo.deleteById(id);
	}
	
	
	
}