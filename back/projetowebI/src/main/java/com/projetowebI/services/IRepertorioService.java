package com.projetowebI.services;

import com.projetowebI.dtos.BandaDTO;
import com.projetowebI.dtos.MusicaDTO;
import com.projetowebI.dtos.RepertorioMusicasDTO;
import com.projetowebI.models.Repertorio;
import java.util.List;
import java.util.Map;

public interface IRepertorioService {

    Repertorio criarRepertorio(Integer idBanda, String nomeRepertorio);

    Repertorio atualizarRepertorio(Integer idRepertorio, String novoNome);

    List<RepertorioMusicasDTO> listarMusicasPorRepertorio(Integer idRepertorio);

    void atualizarOrdem(Integer idRepertorio, List<Map<String, Integer>> musicas);


    BandaDTO adicionarMusicaAoRepertorio(Integer idRepertorio, Integer idBanda, Integer idMusica, String ordem);

    void removerMusicaDoRepertorio(Integer idRepertorio, Integer idMusica);

    void excluirRepertorio(Integer idRepertorio);

    List<RepertorioMusicasDTO> listarRepertorioPorBanda(Integer idBanda);

    BandaDTO listarBandaComMusicasDoRepertorio(Integer idRepertorio);


}
