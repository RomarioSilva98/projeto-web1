package com.projetowebI.repositories;

import com.projetowebI.models.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    Optional<Usuario> findByEmail(String email);


    @Query("SELECT u FROM Usuario u LEFT JOIN FETCH u.participacoes p LEFT JOIN FETCH p.banda WHERE u.idUsuario = :id")
    Optional<Usuario> findByIdWithBandas(@Param("id") Integer id);

}
