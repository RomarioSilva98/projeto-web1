package com.projetowebI.models;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Data
@NoArgsConstructor
@Entity
public class Musica {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idMusica;

    private String titulo;

    @Column(nullable = false)
    private String arquivoPdf;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatusMusica status = StatusMusica.inativa; // Valor padrão

    @OneToMany(mappedBy = "musica", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<RepertorioMusicas> repertoriosMusicas; // Relacionamento com RepertorioMusicas

    @Column(name = "repertorio_id", nullable = true)
    private Integer repertorioId; // ID do repertório associado (adicionado)

    // Getters e Setters
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

    public StatusMusica getStatus() {
        return status;
    }

    public void setStatus(StatusMusica status) {
        this.status = status;
    }

    public Integer getRepertorioId() {
        return repertorioId;
    }

    public void setRepertorioId(Integer repertorioId) {
        this.repertorioId = repertorioId;
    }

    public enum StatusMusica {
        ativa,
        inativa,
        removida
    }
}
