package com.projetowebI.controllers;

import com.projetowebI.dtos.UsuarioDTO;
import com.projetowebI.models.Usuario;
import com.projetowebI.services.UsuarioService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping
    public List<UsuarioDTO> getAllUsuarios() {
        // Retorna todos os usuários como DTOs
        return usuarioService.findAll();
    }

    @GetMapping("/buscar")
    public ResponseEntity<UsuarioDTO> buscarPorEmail(@RequestParam String email) {
        Optional<Usuario> usuario = usuarioService.buscarPorEmail(email);
        return usuario.map(value -> ResponseEntity.ok(new UsuarioDTO(value)))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }


    @GetMapping("/{id}")
    public ResponseEntity<UsuarioDTO> getUsuarioById(@PathVariable Integer id) {
        return usuarioService.findById(id)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }


    @PostMapping
    public ResponseEntity<?> createUsuario(@Valid @RequestBody UsuarioDTO usuarioDTO) {
        try {
            Usuario usuario = new Usuario();
            usuario.setNomeUsuario(usuarioDTO.getNomeUsuario());
            usuario.setEmail(usuarioDTO.getEmail());
            usuario.setSenha(usuarioDTO.getSenha());

            Usuario usuarioSalvo = usuarioService.cadastrarUsuario(usuario);
            return ResponseEntity.status(HttpStatus.CREATED).body(new UsuarioDTO(usuarioSalvo));

        } catch (DataIntegrityViolationException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Erro: E-mail já cadastrado.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao cadastrar usuário.");
        }
    }



    @PutMapping("/{id}")
    public ResponseEntity<UsuarioDTO> updateUsuario(@PathVariable Integer id, @RequestBody UsuarioDTO usuarioDTO) {
        try {
            Usuario usuarioAtualizado = usuarioService.atualizarUsuario(id, usuarioDTO);
            return ResponseEntity.ok(new UsuarioDTO(usuarioAtualizado));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        }
    }



    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteUsuario(@PathVariable Integer id) {
        try {
            usuarioService.deletarUsuario(id);
            return ResponseEntity.ok("Usuário apagado com sucesso.");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

}
