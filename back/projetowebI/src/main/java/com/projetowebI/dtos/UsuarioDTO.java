package com.projetowebI.dtos;

import com.projetowebI.models.Banda;
import com.projetowebI.models.Usuario;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Data
public class UsuarioDTO {
    private Integer idUsuario;
    private String nomeUsuario;
    private String email;
    private String senha;
    private List<BandaDTO> bandas;

    public UsuarioDTO(Usuario usuario) {
        this.idUsuario = usuario.getIdUsuario();
        this.nomeUsuario = usuario.getNomeUsuario();
        this.email = usuario.getEmail();
        this.senha = usuario.getSenha();

        // Convertendo Participacoes para BandaDTOs
        this.bandas = Optional.ofNullable(usuario.getParticipacoes())
                .orElse(Collections.emptyList())
                .stream()
                .map(participacao -> {
                    Banda banda = participacao.getBanda();
                    return new BandaDTO(
                            banda.getIdBanda(),
                            banda.getNomeBanda(),
                            banda.getGenero(),
                            banda.getImagemUrl()
                    );
                })
                .collect(Collectors.toList());
    }

    public UsuarioDTO() {
    }

    public Integer getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNomeUsuario() {
        return nomeUsuario;
    }

    public void setNomeUsuario(String nomeUsuario) {
        this.nomeUsuario = nomeUsuario;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public List<BandaDTO> getBandas() {
        return bandas;
    }

    public void setBandas(List<BandaDTO> bandas) {
        this.bandas = bandas;
    }
}
