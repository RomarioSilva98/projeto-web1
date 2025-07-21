package com.projetowebI.repositories;

import com.projetowebI.models.Banda;
import com.projetowebI.models.Musica;
import com.projetowebI.models.Repertorio;
import com.projetowebI.models.RepertorioMusicas;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


import java.util.List;
import java.util.Optional;

@Repository
public interface RepertorioMusicasRepository extends JpaRepository<RepertorioMusicas, Integer> {

    boolean existsByBandaAndMusicaAndOrdem(Banda banda, Musica musica, String ordem);

    boolean existsByRepertorioAndMusica(Repertorio repertorio, Musica musica);

    Optional<RepertorioMusicas> findByRepertorioAndMusica(Repertorio repertorio, Musica musica);

    List<RepertorioMusicas> findByBanda(Banda banda);


    void deleteByRepertorio(Repertorio repertorio);

    List<RepertorioMusicas> findByRepertorio(Repertorio repertorio);

    Optional<RepertorioMusicas> findByRepertorioAndMusica_IdMusica(Repertorio repertorio, Integer idMusica);



}
