package com.projetowebI.repositories;

import com.projetowebI.models.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RepertorioRepository extends JpaRepository<Repertorio, Integer> {

    List<Repertorio> findByBanda(Banda banda);


}
