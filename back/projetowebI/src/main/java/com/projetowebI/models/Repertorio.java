package com.projetowebI.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.projetowebI.models.Musica;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@Entity
public class Repertorio {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idRepertorio;

    private String nome;

    @ManyToOne
    @JoinColumn(name = "id_banda", nullable = false)
    private Banda banda;

    @OneToMany(mappedBy = "repertorio", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<RepertorioMusicas> repertorioMusicas;

    public List<RepertorioMusicas> getMusicas() {
        return repertorioMusicas;
    }


    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public List<RepertorioMusicas> getRepertorioMusicas() {
        return repertorioMusicas;
    }

    public void setRepertorioMusicas(List<RepertorioMusicas> repertorioMusicas) {
        this.repertorioMusicas = repertorioMusicas;
    }

    public Integer getIdRepertorio() {
        return idRepertorio;
    }

    public void setIdRepertorio(Integer idRepertorio) {
        this.idRepertorio = idRepertorio;
    }

    public Banda getBanda() {
        return banda;
    }

    public void setBanda(Banda banda) {
        this.banda = banda;
    }




}
