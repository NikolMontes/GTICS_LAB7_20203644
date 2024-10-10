package com.proyect.lab7_20203644.Entity;

import jakarta.persistence.*;

@Entity(name="users")
public class Users {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int iduser;

    private String email;
    private String password;
    private String name;
    @ManyToOne
    @JoinColumn(name="roleId")
    private Roles roleId;


}
