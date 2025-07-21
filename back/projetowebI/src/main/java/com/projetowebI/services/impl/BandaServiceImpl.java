
package com.projetowebI.services.impl;

import com.projetowebI.dtos.BandaDTO;
import com.projetowebI.dtos.CriarBandaDTO;
import com.projetowebI.models.Banda;
import com.projetowebI.models.Participacao;
import com.projetowebI.models.Repertorio;
import com.projetowebI.models.Usuario;
import com.projetowebI.repositories.BandaRepository;
import com.projetowebI.repositories.RepertorioRepository;
import com.projetowebI.repositories.UsuarioRepository;
import com.projetowebI.services.IBandaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class BandaServiceImpl implements IBandaService {

    @Autowired
    private BandaRepository bandaRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private RepertorioRepository repertorioRepository;

    @Autowired
    private RepertorioServiceImpl repertorioService;

    @Override
    public Banda criarBanda(CriarBandaDTO criarBandaDTO) {
        Usuario responsavel = usuarioRepository.findById(criarBandaDTO.getIdResponsavel())
                .orElseThrow(() -> new IllegalArgumentException("Responsável não encontrado."));

        Banda banda = new Banda();
        banda.setNomeBanda(criarBandaDTO.getNomeBanda());
        banda.setGenero(criarBandaDTO.getGenero()); // Setando o gênero
        banda.setResponsavel(responsavel);
        banda.setImagemUrl(criarBandaDTO.getImagemUrl());

        // Criando participação para o responsável
        Participacao participacao = new Participacao();
        participacao.setBanda(banda);
        participacao.setUsuario(responsavel);

        // Adicionando participação na banda
        banda.getParticipacoes().add(participacao);

        return bandaRepository.save(banda);
    }


    @Override
    public Banda adicionarMusico(Integer bandaId, Integer idUsuario) {
        Banda banda = bandaRepository.findById(Long.valueOf(bandaId))
                .orElseThrow(() -> new IllegalArgumentException("Banda não encontrada."));

        Usuario usuario = usuarioRepository.findById(idUsuario)
                .orElseThrow(() -> new IllegalArgumentException("Usuário não encontrado."));

        Participacao participacao = new Participacao();
        participacao.setBanda(banda);
        participacao.setUsuario(usuario);
        banda.getParticipacoes().add(participacao);

        return bandaRepository.save(banda);
    }

    @Override
    public Banda removerMusico(Integer bandaId, Integer musicoId) {
        Banda banda = bandaRepository.findById(Long.valueOf(bandaId))
                .orElseThrow(() -> new IllegalArgumentException("Banda não encontrada."));

        Usuario musico = usuarioRepository.findById(musicoId)
                .orElseThrow(() -> new IllegalArgumentException("Músico não encontrado."));

        // Removendo a participação do músico na banda
        banda.getParticipacoes().removeIf(participacao -> participacao.getUsuario().equals(musico));
        return bandaRepository.save(banda);
    }


    @Override
    public Banda atualizarBanda(Integer bandaId, String novoNome, String novoGenero) {
        Banda banda = bandaRepository.findById(Long.valueOf(bandaId))
                .orElseThrow(() -> new IllegalArgumentException("Banda não encontrada."));

        if (novoNome != null && !novoNome.isBlank()) {
            banda.setNomeBanda(novoNome);
        }
        if (novoGenero != null && !novoGenero.isBlank()) {
            banda.setGenero(novoGenero);
        }

        return bandaRepository.save(banda);
    }


    @Override
    public void excluirBanda(Integer bandaId, Integer usuarioId) {
        Banda banda = bandaRepository.findById(Long.valueOf(bandaId))
                .orElseThrow(() -> new IllegalArgumentException("Banda não encontrada."));

        if (!banda.getResponsavel().getIdUsuario().equals(usuarioId)) {
            throw new SecurityException("Usuário não é responsável pela banda.");
        }

        List<Repertorio> repertorios = repertorioRepository.findByBanda(banda);

        for (Repertorio repertorio : repertorios) {
            repertorioService.excluirRepertorio(repertorio.getIdRepertorio());
        }
        bandaRepository.delete(banda);
    }

    @Override
    public Banda buscarBandaPorId(Integer bandaId) {
        return bandaRepository.findById(Long.valueOf(bandaId))
                .orElseThrow(() -> new IllegalArgumentException("Banda não encontrada."));
    }


    @Override
    public List<Banda> buscarBandaPorNome(String nome) {
        return bandaRepository.findByNomeBandaContainingIgnoreCase(nome);
    }

    @Override
    public List<BandaDTO> listarBandasPorUsuario(Integer usuarioId) {
        Usuario usuario = usuarioRepository.findById(usuarioId)
                .orElseThrow(() -> new IllegalArgumentException("Usuário não encontrado."));

        List<Banda> bandas = bandaRepository.findByParticipacoes_Usuario(usuario);

        System.out.println("Bandas encontradas no banco: " + bandas.size());

        return bandas.stream()
                .map(BandaDTO::new)
                .collect(Collectors.toList());
    }

}
