package com.projetowebI.dtos;

import com.projetowebI.models.Repertorio;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RepertorioDTO {
    private Integer idRepertorio;
    private String nome;
    private Integer idBanda;
    private List<RepertorioMusicasDTO> musicas;




    public RepertorioDTO(Repertorio repertorio) {
        this.idRepertorio = repertorio.getIdRepertorio();
        this.nome = repertorio.getNome();
        this.idBanda = repertorio.getBanda().getIdBanda(); // Certifique-se de que banda não seja null
        this.musicas = (repertorio.getMusicas() != null) ?
                repertorio.getMusicas().stream()
                        .map(RepertorioMusicasDTO::new)
                        .collect(Collectors.toList())
                : Collections.emptyList();
    }

    public Integer getIdRepertorio() {
        return idRepertorio;
    }

    public void setIdRepertorio(Integer idRepertorio) {
        this.idRepertorio = idRepertorio;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Integer getIdBanda() {
        return idBanda;
    }

    public void setIdBanda(Integer idBanda) {
        this.idBanda = idBanda;
    }

    public List<RepertorioMusicasDTO> getMusicas() {
        return musicas;
    }

    public void setMusicas(List<RepertorioMusicasDTO> musicas) {
        this.musicas = musicas;
    }
}