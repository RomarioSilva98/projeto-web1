package com.projetowebI.services;

import com.projetowebI.dtos.BandaDTO;
import com.projetowebI.dtos.CriarBandaDTO;
import com.projetowebI.models.Banda;

import java.util.List;

public interface IBandaService {
    // Cria uma nova banda e define o responsável
    Banda criarBanda(CriarBandaDTO criarBandaDTO);

    // Adiciona um músico à banda
    Banda adicionarMusico(Integer bandaId, Integer idUsuario);

    // Remove um músico da banda
    Banda removerMusico(Integer bandaId, Integer musicoId);

    // Atualiza os dados de uma banda existente

    Banda atualizarBanda(Integer bandaId, String novoNome, String novoGenero);

    // Exclui uma banda pelo ID
    void excluirBanda(Integer bandaId, Integer usuarioId);

    // Busca bandas pelo nome
    List<Banda> buscarBandaPorNome(String nome);

    Banda buscarBandaPorId(Integer bandaId);


    // Lista bandas de um usuário
    List<BandaDTO> listarBandasPorUsuario(Integer usuarioId);
}
