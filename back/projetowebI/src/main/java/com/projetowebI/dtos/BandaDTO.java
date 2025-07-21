package com.projetowebI.dtos;

import com.projetowebI.models.Banda;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Data
@NoArgsConstructor
public class BandaDTO {
    private Integer idBanda;
    private String nomeBanda;
    private String genero;
    private String imagemUrl;
    private List<UsuarioDTO> usuarios;
    private UsuarioDTO responsavel;
    private List<RepertorioDTO> repertorios;
    private List<RepertorioMusicasDTO> repertoriosMusicas;




    public BandaDTO(Banda banda) {
        this.idBanda = banda.getIdBanda();
        this.nomeBanda = banda.getNomeBanda();
        this.genero = banda.getGenero();
        this.imagemUrl = banda.getImagemUrl();

        this.usuarios = (banda.getParticipacoes() != null)
                ? banda.getParticipacoes().stream()
                .map(participacao -> new UsuarioDTO(participacao.getUsuario()))
                .collect(Collectors.toList())
                : Collections.emptyList();

        this.responsavel = (banda.getResponsavel() != null) ? new UsuarioDTO(banda.getResponsavel()) : null;

        this.repertorios = (banda.getRepertorios() != null)
                ? banda.getRepertorios().stream()
                .map(RepertorioDTO::new)
                .collect(Collectors.toList())
                : Collections.emptyList();

        this.repertoriosMusicas = Collections.emptyList();
    }


    public BandaDTO(Integer idBanda, String nomeBanda, String genero, String imagemUrl) {
        this.idBanda = idBanda;
        this.nomeBanda = nomeBanda;
        this.genero = genero;
        this.imagemUrl = imagemUrl;
    }



    public List<RepertorioMusicasDTO> getRepertoriosMusicas() {
        return repertoriosMusicas;
    }

    public void setRepertoriosMusicas(List<RepertorioMusicasDTO> repertoriosMusicas) {
        this.repertoriosMusicas = repertoriosMusicas;
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

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getImagemUrl() {
        return imagemUrl;
    }

    public void setImagemUrl(String imagemUrl) {
        this.imagemUrl = imagemUrl;
    }

    public List<UsuarioDTO> getUsuarios() {
        return usuarios;
    }

    public void setUsuarios(List<UsuarioDTO> usuarios) {
        this.usuarios = usuarios;
    }

    public UsuarioDTO getResponsavel() {
        return responsavel;
    }

    public void setResponsavel(UsuarioDTO responsavel) {
        this.responsavel = responsavel;
    }

    public List<RepertorioDTO> getRepertorios() {
        return repertorios;
    }

    public void setRepertorios(List<RepertorioDTO> repertorios) {
        this.repertorios = repertorios;
    }
}
