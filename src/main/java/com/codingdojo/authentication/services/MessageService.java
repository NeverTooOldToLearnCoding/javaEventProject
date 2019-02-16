package com.codingdojo.authentication.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.codingdojo.authentication.models.Message;
import com.codingdojo.authentication.repositories.MessageRepo;



@Service
public class MessageService{
	//creating your attributes to Product Service
	//adding the product repo as a dependency
	public final MessageRepo messageRepo;
	
	//creating a Product Service constructor using the product repo
	public MessageService (MessageRepo messageRepo) {
		this.messageRepo = messageRepo;
	}
	
	//creating method for querying all products in Product Repo (database)
	
	//returns all the products
	public List<Message> allMessages(){
		return messageRepo.findAllByOrderByIdAsc();
	}
	
	//creating a product
	public Message createMessage(Message message) {
		return messageRepo.save(message);
	}
	
	//retrieving a product from the database
	public Message findMessage(Long id) {
		Optional<Message> optionalMessage = messageRepo.findById(id);
		if(optionalMessage.isPresent()) {
			return optionalMessage.get();
		}else {
			return null;
		}
	}
	
	//update the message 
	public Message updateMessage(Message message) {
		messageRepo.save(message);
		return message;
		
	}
	
    //update a product
//  public Book updateBook(Long id, String title, String desc,String lang,int numOfPages) {
//  	Book book = findBook(id);
//  	book.setTitle(title);
//  	book.setDescription(desc);
//  	book.setLanguage(lang);
//  	book.setNumberOfPages(numOfPages);
//  	bookRepository.save(book);
//  	return book;
//  }
	
	//delete a product
	public void deleteProduct(Long id) {
		messageRepo.deleteById(id);
	}
	
	
	
}