package com.proyect.lab7_20203644.Entity;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Entity(name="movieprojections")
public class MovieProyections {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer idproyeccion;

    @ManyToOne
    @JoinColumn(name="movieId", nullable = true)
    private Movies movie;

    @ManyToOne
    @JoinColumn(name="roomId", nullable= true)
    private Rooms room;

    @Column(name = "proyectionDate", nullable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate dia_proyeccion;

    private Integer availableSeats;

}
