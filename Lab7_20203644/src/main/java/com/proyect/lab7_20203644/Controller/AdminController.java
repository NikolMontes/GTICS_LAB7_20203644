package com.proyect.lab7_20203644.Controller;

import com.proyect.lab7_20203644.Entity.MovieProyections;
import com.proyect.lab7_20203644.Repository.MovieProyecionRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;

import java.util.List;

@Controller
@RequestMapping("/gestion")
public class AdminController {

    final MovieProyecionRepository movieProyecionRepository;
    public AdminController(MovieProyecionRepository movieProyecionRepository) {
        this.movieProyecionRepository = movieProyecionRepository;
    }


    @GetMapping("/proyecciones")
    public String listaProyecciones(Model model){
        List<MovieProyections> listaproyection = movieProyecionRepository.findAll();
        model.addAttribute("proyecciones",listaproyection);
        return "Admin/gestionproyecciones";
    }




}
