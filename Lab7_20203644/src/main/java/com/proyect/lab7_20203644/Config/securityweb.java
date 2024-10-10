package com.proyect.lab7_20203644.Config;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.context.annotation.*;

import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetailsService;
//import org.springframework.security.authorization.AuthenticatedAuthorizationManager.authenticated;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;


import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.web.savedrequest.DefaultSavedRequest;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collection;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
public class securityweb {

    final DataSource dataSource;
    public SecurityWeb(DataSource dataSource){
        this.dataSource = dataSource;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
        //http.formLogin();     no funciona de esta forma, ask?
        http.formLogin(form -> form
                .loginPage("/login") // para no usar el formulario de login por defecto de Spring Security
                .loginProcessingUrl("/procesologueo")
                .usernameParameter("email")
                .successHandler(authenticationSuccessHandler()) // Llama a un método separado
                .permitAll()
    };



    // Implementación de AuthenticationSuccessHandler dentro del mismo archivo
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
    public AuthenticationSuccessHandler authenticationSuccessHandler() {
        return new AuthenticationSuccessHandler() {
            @Override
            public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
                    throws IOException, ServletException {
                // Verificar si existe una URL guardada en la sesión (DefaultSavedRequest)
                DefaultSavedRequest savedRequest = (DefaultSavedRequest) request.getSession().getAttribute("SPRING_SECURITY_SAVED_REQUEST");
                if (savedRequest != null) {
                    String targetURL = savedRequest.getRedirectUrl();
                    redirectStrategy.sendRedirect(request,response,targetURL);
                } else {
                    // Obtener los roles del usuario autenticado
                    Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>) authentication.getAuthorities();

                    // Redirigir de acuerdo al rol
                    if (authorities.stream().anyMatch(role -> role.getAuthority().equals("ADMIN"))) {
                        response.sendRedirect("/");
                    } else if (authorities.stream().anyMatch(role -> role.getAuthority().equals("GERENTE"))) {
                        response.sendRedirect("/agente/inicio");
                    } else {
                        // Si no tiene ningún rol específico, redirige a una página por defecto
                        response.sendRedirect("/usuario/resenia");
                    }
                }
            }
        };
    }

    }
