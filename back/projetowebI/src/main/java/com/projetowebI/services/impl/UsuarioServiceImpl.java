package com.projetowebI.services.impl;

import com.projetowebI.dtos.UsuarioDTO;
import com.projetowebI.models.Usuario;
import com.projetowebI.repositories.UsuarioRepository;
import com.projetowebI.services.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UsuarioServiceImpl implements UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public List<UsuarioDTO> findAll() {
        return usuarioRepository.findAll()
                .stream()
                .map(UsuarioDTO::new)
                .collect(Collectors.toList());
    }

    @Override
    public Optional<UsuarioDTO> findById(Integer id) {
        return usuarioRepository.findById(id).map(UsuarioDTO::new);
    }

    @Override
    public Usuario cadastrarUsuario(Usuario usuario) {
        usuario.setSenha(passwordEncoder.encode(usuario.getSenha()));
        return usuarioRepository.save(usuario);
    }

    @Override
    public Usuario atualizarUsuario(Integer id, UsuarioDTO usuarioDTO) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Usuário não encontrado."));

        usuario.setNomeUsuario(usuarioDTO.getNomeUsuario());
        usuario.setEmail(usuarioDTO.getEmail());

        if (usuarioDTO.getSenha() != null && !usuarioDTO.getSenha().isEmpty()) {
            usuario.setSenha(passwordEncoder.encode(usuarioDTO.getSenha()));
        }

        return usuarioRepository.save(usuario);
    }

    @Override
    public void deletarUsuario(Integer id) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Usuário não encontrado."));

        usuarioRepository.delete(usuario);
    }

    @Override
    public Optional<Usuario> buscarPorEmail(String email) {
        return usuarioRepository.findByEmail(email);
    }



}
