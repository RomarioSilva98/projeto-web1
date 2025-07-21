package com.projetowebI.models;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Data
@NoArgsConstructor
@Entity
public class BandaMusica {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idBandaMusica;

    @ManyToOne
    @JoinColumn(name = "id_banda")
    private Banda banda;

    @ManyToOne
    @JoinColumn(name = "id_musica")
    private Musica musica;

    private Date dataAdicao;

    public Integer getIdBandaMusica() {
        return idBandaMusica;
    }

    public void setIdBandaMusica(Integer idBandaMusica) {
        this.idBandaMusica = idBandaMusica;
    }

    public Banda getBanda() {
        return banda;
    }

    public void setBanda(Banda banda) {
        this.banda = banda;
    }

    public Musica getMusica() {
        return musica;
    }

    public void setMusica(Musica musica) {
        this.musica = musica;
    }

    public Date getDataAdicao() {
        return dataAdicao;
    }

    public void setDataAdicao(Date dataAdicao) {
        this.dataAdicao = dataAdicao;
    }
}