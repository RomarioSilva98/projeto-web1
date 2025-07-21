package com.projetowebI.controllers;

import com.projetowebI.dtos.LoginDTO;
import com.projetowebI.dtos.UsuarioDTO;
import com.projetowebI.models.Usuario;
import com.projetowebI.services.impl.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/login")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class LoginController {

    @Autowired
    private LoginService loginService;

    @RequestMapping(method = RequestMethod.OPTIONS)
    public ResponseEntity<?> handleOptions() {
        return ResponseEntity.ok().build();
    }


    @PostMapping
    public ResponseEntity<?> autenticar(@RequestBody LoginDTO loginDTO) {
        System.out.println("Tentativa de login: " + loginDTO.getEmail());

        System.out.println("Tentativa de login: " + loginDTO.getEmail());
        System.out.println("Senha recebida: " + loginDTO.getSenha());

        Optional<Usuario> usuarioOpt = loginService.autenticarUsuario(loginDTO.getEmail(), loginDTO.getSenha());


        if (usuarioOpt.isPresent()) {
            UsuarioDTO usuarioDTO = new UsuarioDTO(usuarioOpt.get()); // Converte para DTO seguro
            return ResponseEntity.ok(usuarioDTO);
        } else {
            return ResponseEntity.status(401).body("Credenciais inválidas!");
        }

    }

//    @PostMapping
//    public ResponseEntity<String> login(@RequestBody LoginDTO loginDTO) {
//        System.out.println("Tentativa de login: " + loginDTO.getEmail());
//        return ResponseEntity.ok("Login realizado com sucesso!");
//    }
}
