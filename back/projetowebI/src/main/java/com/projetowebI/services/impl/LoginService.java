package com.projetowebI.services.impl;

import com.projetowebI.models.Usuario;
import com.projetowebI.repositories.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class LoginService {

    private final UsuarioRepository usuarioRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public LoginService(UsuarioRepository usuarioRepository, PasswordEncoder passwordEncoder) {
        this.usuarioRepository = usuarioRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public Optional<Usuario> autenticarUsuario(String email, String senhaDigitada) {
        return usuarioRepository.findByEmail(email)
                .filter(usuario -> passwordEncoder.matches(senhaDigitada, usuario.getSenha()));
    }
}
