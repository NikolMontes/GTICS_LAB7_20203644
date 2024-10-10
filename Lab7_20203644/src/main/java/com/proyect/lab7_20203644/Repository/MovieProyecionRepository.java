package com.proyect.lab7_20203644.Repository;

import com.proyect.lab7_20203644.Entity.MovieProyections;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MovieProyecionRepository extends JpaRepository<MovieProyections, Integer> {

}
