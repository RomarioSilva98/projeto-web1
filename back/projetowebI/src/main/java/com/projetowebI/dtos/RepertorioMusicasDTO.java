package com.projetowebI.dtos;

import com.projetowebI.models.RepertorioMusicas;
import lombok.*;

@Data
public class RepertorioMusicasDTO {
    private Integer idRepertorioMusica;
    private Integer idMusica;
    private String tituloMusica; // 🔹 Adicionado para armazenar o nome da música
    private String ordem;
    private String arquivoPdf;
    private Integer idRepertorio;
    private Integer idBanda;

    public RepertorioMusicasDTO(Integer idRepertorioMusica, Integer idMusica, String tituloMusica, String ordem, Integer idRepertorio, Integer idBanda) {
        this.idRepertorioMusica = idRepertorioMusica;
        this.idMusica = idMusica;
        this.tituloMusica = tituloMusica;
        this.ordem = ordem;
        this.idRepertorio = idRepertorio;
        this.idBanda = idBanda;
    }

    public RepertorioMusicasDTO(Integer idRepertorioMusica, Integer idMusica, String tituloMusica, String ordem, String arquivoPdf, Integer idRepertorio, Integer idBanda) {
        this.idRepertorioMusica = idRepertorioMusica;
        this.idMusica = idMusica;
        this.tituloMusica = tituloMusica;
        this.ordem = ordem;
        this.arquivoPdf = arquivoPdf;
        this.idRepertorio = idRepertorio;
        this.idBanda = idBanda;
    }

    public RepertorioMusicasDTO(RepertorioMusicas repertorioMusicas) {
    }

    // Getters e Setters
    public Integer getIdRepertorioMusica() { return idRepertorioMusica; }
    public void setIdRepertorioMusica(Integer idRepertorioMusica) { this.idRepertorioMusica = idRepertorioMusica; }

    public Integer getIdMusica() { return idMusica; }
    public void setIdMusica(Integer idMusica) { this.idMusica = idMusica; }

    public String getTituloMusica() { return tituloMusica; } // 🔹 Getter para o nome da música
    public void setTituloMusica(String tituloMusica) { this.tituloMusica = tituloMusica; } // 🔹 Setter

    public String getOrdem() { return ordem; }
    public void setOrdem(String ordem) { this.ordem = ordem; }

    public String getArquivoPdf() {
        return arquivoPdf;
    }

    public void setArquivoPdf(String arquivoPdf) {
        this.arquivoPdf = arquivoPdf;
    }

    public Integer getIdRepertorio() { return idRepertorio; }
    public void setIdRepertorio(Integer idRepertorio) { this.idRepertorio = idRepertorio; }

    public Integer getIdBanda() { return idBanda; }
    public void setIdBanda(Integer idBanda) { this.idBanda = idBanda; }
}
