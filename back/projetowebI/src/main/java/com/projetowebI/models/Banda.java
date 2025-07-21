package com.projetowebI.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@Entity
public class Banda {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idBanda;

    @Column(nullable = false)
    private String nomeBanda;

    @Column(nullable = true)
    private String genero;

    @Column(nullable = true)
    private String imagemUrl;

    @OneToOne
    @JoinColumn(name = "id_responsavel", referencedColumnName = "idUsuario")
    private Usuario responsavel;

    @OneToMany(mappedBy = "banda", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Participacao> participacoes = new ArrayList<>();

    @OneToMany(mappedBy = "banda", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Repertorio> repertorios = new ArrayList<>();


    public void setResponsavel(Usuario usuario) {
        this.responsavel = usuario;
    }

    public Integer getIdBanda() {
        return idBanda;
    }

    public void setIdBanda(Integer idBanda) {
        this.idBanda = idBanda;
    }

    public String getNomeBanda() {
        return nomeBanda;
    }

    public void setNomeBanda(String nomeBanda) {
        this.nomeBanda = nomeBanda;
    }

    public List<Participacao> getParticipacoes() {
        return participacoes;
    }

    public void setParticipacoes(List<Participacao> participacoes) {
        this.participacoes = participacoes;
    }

    public List<Repertorio> getRepertorios() {
        return repertorios;
    }

    public void setRepertorios(List<Repertorio> repertorios) {
        this.repertorios = repertorios;
    }

    public Usuario getResponsavel() {
        return responsavel;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getImagemUrl() {
        return imagemUrl;
    }

    public void setImagemUrl(String imagem) {
        this.imagemUrl = imagem;
    }

    public Banda() {
    }

    public Banda(String nomeBanda, String genero, String imagemUrl) {
        this.nomeBanda = nomeBanda;
        this.genero = genero;
        this.imagemUrl = imagemUrl;
    }
}
