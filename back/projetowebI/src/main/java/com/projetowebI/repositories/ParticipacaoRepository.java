package com.projetowebI.repositories;

import com.projetowebI.models.Banda;
import com.projetowebI.models.Participacao;
import com.projetowebI.models.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ParticipacaoRepository extends  JpaRepository<Participacao, Integer> {
    boolean existsByBandaAndUsuario(Banda banda, Usuario usuario);
    List<Participacao> findByBandaAndUsuario(Banda banda, Usuario usuario);
}
