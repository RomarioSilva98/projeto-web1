package com.projetowebI.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class MusicaDTO {
    private Integer idMusica;
    private String titulo;
    private String arquivoPdf;
    private String status;
    private List<RepertorioMusicasDTO> repertoriosMusicas;

    public Integer getIdMusica() {
        return idMusica;
    }

    public void setIdMusica(Integer idMusica) {
        this.idMusica = idMusica;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getArquivoPdf() {
        return arquivoPdf;
    }

    public void setArquivoPdf(String arquivoPdf) {
        this.arquivoPdf = arquivoPdf;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<RepertorioMusicasDTO> getRepertoriosMusicas() {
        return repertoriosMusicas;
    }

    public void setRepertoriosMusicas(List<RepertorioMusicasDTO> repertoriosMusicas) {
        this.repertoriosMusicas = repertoriosMusicas;
    }

    public MusicaDTO(Integer idMusica, String titulo, String arquivoPdf, String status, List<RepertorioMusicasDTO> repertoriosMusicas) {
        this.idMusica = idMusica;
        this.titulo = titulo;
        this.arquivoPdf = arquivoPdf;
        this.status = status;
        this.repertoriosMusicas = repertoriosMusicas;
    }

    public MusicaDTO(Integer idMusica, String titulo, String arquivoPdf) {
        this.idMusica = idMusica;
        this.titulo = titulo;
        this.arquivoPdf = arquivoPdf;

    }

}

