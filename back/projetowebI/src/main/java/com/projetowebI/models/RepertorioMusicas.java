package com.projetowebI.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "repertorio_musicas")
public class RepertorioMusicas {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idRepertorioMusica; // Chave primária

    @ManyToOne
    @JoinColumn(name = "id_musica", nullable = false)
    private Musica musica; // Relacionamento com Musica

    @ManyToOne
    @JoinColumn(name = "id_banda", nullable = false)
    private Banda banda; // Relacionamento com Banda

    @ManyToOne
    @JoinColumn(name = "id_repertorio", nullable = false)
    private Repertorio repertorio; // Relacionamento com Repertorio

    @Column(nullable = false, length = 3)
    private String ordem; // Ordem no repertório

    // Getters e Setters são gerados automaticamente pelo Lombok (@Data)

    public Integer getIdRepertorioMusica() {
        return idRepertorioMusica;
    }

    public void setIdRepertorioMusica(Integer idRepertorioMusica) {
        this.idRepertorioMusica = idRepertorioMusica;
    }

    public Musica getMusica() {
        return musica;
    }

    public void setMusica(Musica musica) {
        this.musica = musica;
    }

    public Banda getBanda() {
        return banda;
    }

    public void setBanda(Banda banda) {
        this.banda = banda;
    }

    public String getOrdem() {
        return ordem;
    }

    public void setOrdem(String ordem) {
        this.ordem = ordem;
    }

    public Repertorio getRepertorio() {
        return repertorio;
    }

    public void setRepertorio(Repertorio repertorio) {
        this.repertorio = repertorio;
    }
}
