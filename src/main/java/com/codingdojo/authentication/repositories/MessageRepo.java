package com.codingdojo.authentication.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.authentication.models.Message;

@Repository
public interface MessageRepo extends CrudRepository <Message, Long>{
	//method retrieves all the books from the database
	List<Message> findAllByOrderByIdAsc();
}