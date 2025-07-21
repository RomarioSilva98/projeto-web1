package com.projetowebI.repositories;

import com.projetowebI.models.Banda;
import com.projetowebI.models.BandaMusica;
import com.projetowebI.models.Musica;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface BandaMusicaRepository extends  JpaRepository<BandaMusica, Integer> {
    Optional<BandaMusica> findByBandaAndMusica(Banda banda, Musica musica);

    boolean existsByBandaAndMusica(Banda banda, Musica musica);
}
