package com.projetowebI.models;


import jakarta.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@Entity
public class Participacao {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idParticipacao;

    @ManyToOne
    @JoinColumn(name = "id_banda")
    private Banda banda;

    @ManyToOne
    @JoinColumn(name = "id_usuario")
    private Usuario usuario;

    public Integer getIdParticipacao() {
        return idParticipacao;
    }

    public void setIdParticipacao(Integer idParticipacao) {
        this.idParticipacao = idParticipacao;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Banda getBanda() {
        return banda;
    }

    public void setBanda(Banda banda) {
        this.banda = banda;
    }

    // Getters e Setters
}