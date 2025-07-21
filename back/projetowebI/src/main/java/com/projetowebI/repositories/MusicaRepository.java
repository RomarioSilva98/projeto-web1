package com.projetowebI.repositories;

import com.projetowebI.models.Musica;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MusicaRepository extends  JpaRepository<Musica, Integer> {

    @Modifying
    @Query("UPDATE Musica m SET m.repertorioId = NULL WHERE m.repertorioId IN :repertorioIds")
    void setRepertorioIdToNull(@Param("repertorioIds") List<Integer> repertorioIds);


    @Query("SELECT m FROM Musica m JOIN BandaMusica bm ON m.idMusica = bm.musica.idMusica WHERE bm.banda.idBanda = :idBanda AND LOWER(m.titulo) LIKE LOWER(CONCAT('%', :titulo, '%'))")
    List<Musica> buscarMusicasPorTituloEBanda(@Param("titulo") String titulo, @Param("idBanda") Integer idBanda);

    @Modifying
    @Transactional
    @Query("UPDATE Musica m SET m.repertorioId = NULL WHERE m.repertorioId = :repertorioId")
    void updateRepertorioIdToNull(Integer repertorioId);

    List<Musica> findByRepertorioId(Integer idRepertorio);
}


