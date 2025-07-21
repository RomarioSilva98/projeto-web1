package com.projetowebI.repositories;

import com.projetowebI.models.Banda;
import com.projetowebI.models.Participacao;
import com.projetowebI.models.Usuario;
import org.springframework.beans.PropertyValues;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BandaRepository extends JpaRepository<Banda, Long> {

    List<Banda> findByNomeBandaContainingIgnoreCase(String nome);


    List<Banda> findByParticipacoes_Usuario(Usuario usuario);


}