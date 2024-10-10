package com.proyect.lab7_20203644.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import org.springframework.format.annotation.DateTimeFormat;

@Getter
@Setter
@Entity(name="roles")
public class Roles {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int idroles;

    private String name;
}

