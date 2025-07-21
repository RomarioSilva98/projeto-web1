package com.projetowebI.services.impl;

import com.projetowebI.dtos.BandaDTO;
import com.projetowebI.dtos.RepertorioMusicasDTO;
import com.projetowebI.models.*;
import com.projetowebI.repositories.*;
import com.projetowebI.services.IRepertorioService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class RepertorioServiceImpl implements IRepertorioService {

    @Autowired
    private RepertorioRepository repertorioRepository;

    @Autowired
    private RepertorioMusicasRepository repertorioMusicasRepository;

    @Autowired
    private BandaRepository bandaRepository;

    @Autowired
    private MusicaRepository musicaRepository;

    @Autowired
    private BandaMusicaRepository bandaMusicaRepository;

    public Repertorio criarRepertorio(Integer idBanda, String nomeRepertorio) {
        Banda banda = bandaRepository.findById(Long.valueOf(idBanda))
                .orElseThrow(() -> new IllegalArgumentException("Banda não encontrada!"));

        Repertorio repertorio = new Repertorio();
        repertorio.setBanda(banda);
        repertorio.setNome(nomeRepertorio); // Agora atribuímos o nome

        return repertorioRepository.save(repertorio);
    }

    @Override
    public BandaDTO adicionarMusicaAoRepertorio(Integer idRepertorio, Integer idBanda, Integer idMusica, String ordem) {
        Repertorio repertorio = repertorioRepository.findById(idRepertorio)
                .orElseThrow(() -> new IllegalArgumentException("Repertório não encontrado!"));

        Banda banda = bandaRepository.findById(Long.valueOf(idBanda))
                .orElseThrow(() -> new IllegalArgumentException("Banda não encontrada!"));

        if (!repertorio.getBanda().getIdBanda().equals(banda.getIdBanda())) {
            throw new IllegalArgumentException("O repertório não pertence à banda fornecida!");
        }

        Musica musica = musicaRepository.findById(idMusica)
                .orElseThrow(() -> new IllegalArgumentException("Música não encontrada!"));

        // Verificar se a música já está associada ao repertório
        if (repertorioMusicasRepository.existsByRepertorioAndMusica(repertorio, musica)) {
            throw new IllegalArgumentException("A música já está no repertório!");
        }

        // Criar relação na tabela RepertorioMusicas
        RepertorioMusicas repertorioMusicas = new RepertorioMusicas();
        repertorioMusicas.setRepertorio(repertorio);
        repertorioMusicas.setBanda(banda);
        repertorioMusicas.setMusica(musica);
        repertorioMusicas.setOrdem(ordem);

        repertorioMusicasRepository.save(repertorioMusicas);

        // Verificar se já existe a relação na tabela BandaMusica
        if (!bandaMusicaRepository.existsByBandaAndMusica(banda, musica)) {
            BandaMusica bandaMusica = new BandaMusica();
            bandaMusica.setBanda(banda);
            bandaMusica.setMusica(musica);
            bandaMusica.setDataAdicao(new Date());
            bandaMusicaRepository.save(bandaMusica);
        }

        // Atualizar status da música para ativa
        musica.setStatus(Musica.StatusMusica.ativa);
        musica.setRepertorioId(idRepertorio);
        musicaRepository.save(musica);

        return listarBandaComMusicasDoRepertorio(idRepertorio);
    }



    @Override
    public void removerMusicaDoRepertorio(Integer idRepertorio, Integer idMusica) {
        Repertorio repertorio = repertorioRepository.findById(idRepertorio)
                .orElseThrow(() -> new IllegalArgumentException("Repertório não encontrado!"));

        Musica musica = musicaRepository.findById(idMusica)
                .orElseThrow(() -> new IllegalArgumentException("Música não encontrada!"));

        RepertorioMusicas repertorioMusicas = repertorioMusicasRepository.findByRepertorioAndMusica(repertorio, musica)
                .orElseThrow(() -> new IllegalArgumentException("A música não está associada a este repertório!"));

        // Remover vínculo de RepertorioMusicas
        repertorioMusicasRepository.delete(repertorioMusicas);

        // Limpar o repertorioId da música e alterar o status para inativa
        musica.setRepertorioId(null);
        musica.setStatus(Musica.StatusMusica.inativa);
        musicaRepository.save(musica);
    }

    @Override
    public BandaDTO listarBandaComMusicasDoRepertorio(Integer idRepertorio) {
        // Buscar o repertório pelo ID
        Repertorio repertorio = repertorioRepository.findById(idRepertorio)
                .orElseThrow(() -> new IllegalArgumentException("Repertório não encontrado!"));

        Banda banda = repertorio.getBanda();

        // Obter músicas associadas ao repertório e convertê-las para RepertorioMusicasDTO
        List<RepertorioMusicasDTO> repertoriosMusicas = repertorioMusicasRepository.findByRepertorio(repertorio).stream()
                .map(repertorioMusica -> new RepertorioMusicasDTO(
                        repertorioMusica.getIdRepertorioMusica(),
                        repertorioMusica.getMusica().getIdMusica(),
                        repertorioMusica.getMusica().getTitulo(),
                        repertorioMusica.getOrdem(),
                        repertorioMusica.getRepertorio().getIdRepertorio(),
                        repertorioMusica.getBanda().getIdBanda()
                ))
                .collect(Collectors.toList());

        // Criar e retornar o DTO da banda com os repertórios de músicas
        BandaDTO bandaDTO = new BandaDTO(
                banda.getIdBanda(),
                banda.getNomeBanda(),
                banda.getGenero(), // Adicionando o gênero
                banda.getImagemUrl()
        );



        bandaDTO.setRepertoriosMusicas(repertoriosMusicas);

        return bandaDTO;
    }

    @Override
    public Repertorio atualizarRepertorio(Integer idRepertorio, String novoNome) {
        Repertorio repertorio = repertorioRepository.findById(idRepertorio)
                .orElseThrow(() -> new IllegalArgumentException("Repertório não encontrado!"));

        repertorio.setNome(novoNome);
        return repertorioRepository.save(repertorio);
    }


    @Transactional
    @Override
    public void excluirRepertorio(Integer idRepertorio) {
        // Buscar o repertório pelo ID
        Repertorio repertorio = repertorioRepository.findById(idRepertorio)
                .orElseThrow(() -> new IllegalArgumentException("Repertório não encontrado!"));

        List<Musica> musicasAssociadas = musicaRepository.findByRepertorioId(idRepertorio);

        for (Musica musica : musicasAssociadas) {
            musica.setStatus(Musica.StatusMusica.inativa);  // Alterando o status da música
            musica.setRepertorioId(null);  // Limpando o repertorioId
            musicaRepository.save(musica);  // Salvando a música com as alterações
        }

        // Remover todos os vínculos com músicas antes de excluir o repertório
        musicaRepository.updateRepertorioIdToNull(idRepertorio);
        repertorioMusicasRepository.deleteByRepertorio(repertorio);

        // Excluir o repertório
        repertorioRepository.delete(repertorio);
    }

    @Override
    public List<RepertorioMusicasDTO> listarMusicasPorRepertorio(Integer idRepertorio) {
        Repertorio repertorio = repertorioRepository.findById(idRepertorio)
                .orElseThrow(() -> new IllegalArgumentException("Repertório não encontrado!"));

        List<RepertorioMusicas> repertorioMusicas = repertorioMusicasRepository.findByRepertorio(repertorio);

        return repertorioMusicas.stream().map(repertorioMusica -> new RepertorioMusicasDTO(
                repertorioMusica.getIdRepertorioMusica(),
                repertorioMusica.getMusica().getIdMusica(),
                repertorioMusica.getMusica().getTitulo(),
                repertorioMusica.getOrdem(),
                repertorioMusica.getMusica().getArquivoPdf(),
                repertorioMusica.getRepertorio().getIdRepertorio(),
                repertorioMusica.getRepertorio().getBanda().getIdBanda()
        )).collect(Collectors.toList());
    }

@Override
public void atualizarOrdem(Integer idRepertorio, List<Map<String, Integer>> musicas) {
    Repertorio repertorio = repertorioRepository.findById(idRepertorio)
            .orElseThrow(() -> new IllegalArgumentException("Repertório não encontrado!"));

    for (Map<String, Integer> musicaData : musicas) {
        Integer idMusica = musicaData.get("idMusica");
        String novaOrdem = String.valueOf(musicaData.get("ordem")); // 🔹 Conversão para String

        RepertorioMusicas repertorioMusica = repertorioMusicasRepository.findByRepertorioAndMusica_IdMusica(repertorio, idMusica)
                .orElseThrow(() -> new IllegalArgumentException("Música não encontrada no repertório!"));

        repertorioMusica.setOrdem(novaOrdem);
        repertorioMusicasRepository.save(repertorioMusica);
    }
}



    @Override
    public List<RepertorioMusicasDTO> listarRepertorioPorBanda(Integer idBanda) {
        Banda banda = bandaRepository.findById(Long.valueOf(idBanda))
                .orElseThrow(() -> new IllegalArgumentException("Banda não encontrada!"));

        List<RepertorioMusicas> repertorioMusicas = repertorioMusicasRepository.findByBanda(banda);

        return repertorioMusicas.stream().map(repertorioMusica -> new RepertorioMusicasDTO(
                repertorioMusica.getIdRepertorioMusica(),
                repertorioMusica.getMusica().getIdMusica(),
                repertorioMusica.getMusica().getTitulo(),
                repertorioMusica.getOrdem(),
                repertorioMusica.getMusica().getArquivoPdf(),
                repertorioMusica.getRepertorio().getIdRepertorio(),
                repertorioMusica.getRepertorio().getBanda().getIdBanda()
        )).collect(Collectors.toList());
    }




}
