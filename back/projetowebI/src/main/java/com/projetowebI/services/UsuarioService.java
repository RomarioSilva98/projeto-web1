package com.projetowebI.services;

import com.projetowebI.dtos.UsuarioDTO;
import com.projetowebI.models.Usuario;

import java.util.List;
import java.util.Optional;

public interface UsuarioService {
    List<UsuarioDTO> findAll(); // Lista todos os usuários como DTOs.
    Optional<UsuarioDTO> findById(Integer id); // Busca usuário pelo ID.
    Usuario cadastrarUsuario(Usuario usuario); // Cadastra um novo usuário.
    Usuario atualizarUsuario(Integer id, UsuarioDTO usuarioDTO); // Atualiza os dados do usuário.
    void deletarUsuario(Integer id); // Deleta um usuário.
    Optional<Usuario> buscarPorEmail(String email); // Busca usuário por e-mail.
}
