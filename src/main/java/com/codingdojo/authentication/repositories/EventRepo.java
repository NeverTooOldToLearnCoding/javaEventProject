package com.codingdojo.authentication.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.authentication.models.Event;

@Repository
public interface EventRepo extends CrudRepository <Event, Long>{
	//method retrieves all the books from the database
	List<Event> findAllByOrderByIdAsc();
}