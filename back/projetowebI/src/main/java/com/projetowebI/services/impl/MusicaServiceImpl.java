package com.projetowebI.services.impl;

import com.projetowebI.models.Banda;
import com.projetowebI.models.BandaMusica;
import com.projetowebI.models.Musica;
import com.projetowebI.repositories.BandaMusicaRepository;
import com.projetowebI.repositories.BandaRepository;
import com.projetowebI.repositories.MusicaRepository;
import com.projetowebI.services.IMusicaService;
import com.projetowebI.services.impl.FileStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@Service
public class MusicaServiceImpl implements IMusicaService {

    @Autowired
    private MusicaRepository musicaRepository;

    @Autowired
    private BandaRepository bandaRepository;

    @Autowired
    private BandaMusicaRepository bandaMusicaRepository;

    @Autowired
    private FileStorageService fileStorageService;

    @Override
    public List<Musica> findAll() {
        return musicaRepository.findAll();
    }

    @Override
    public Musica findById(Integer id) {
        return musicaRepository.findById(id).orElse(null);
    }

    @Override
    public Musica save(Musica musica, MultipartFile file, Integer bandaId) throws IOException {
        // Salvar o arquivo e definir a URL correta
        String fileUrl = fileStorageService.storeFile(file, file.getOriginalFilename());
        musica.setArquivoPdf(fileUrl);

        // Salvar a música no banco de dados
        Musica savedMusica = musicaRepository.save(musica);

        // Criar relação com a banda se um ID de banda foi fornecido
        if (bandaId != null) {
            Banda banda = bandaRepository.findById(Long.valueOf(bandaId))
                    .orElseThrow(() -> new IllegalArgumentException("Banda não encontrada!"));

            BandaMusica bandaMusica = new BandaMusica();
            bandaMusica.setBanda(banda);
            bandaMusica.setMusica(savedMusica);
            bandaMusica.setDataAdicao(new Date());

            bandaMusicaRepository.save(bandaMusica);
        }

        return savedMusica;
    }


    @Override
    public Musica update(Integer id, Musica musica) {
        return musicaRepository.findById(id).map(existingMusica -> {
            if (musica.getTitulo() != null) {
                existingMusica.setTitulo(musica.getTitulo());
            }
            if (musica.getArquivoPdf() != null && !musica.getArquivoPdf().isEmpty()) {
                if (!musica.getArquivoPdf().startsWith("http")) {
                    existingMusica.setArquivoPdf("http://localhost:8080/arquivos/download/" + musica.getArquivoPdf());
                } else {
                    existingMusica.setArquivoPdf(musica.getArquivoPdf());
                }
            }
            return musicaRepository.save(existingMusica);
        }).orElse(null);
    }

    @Override
    public String delete(Integer id) {
        if (musicaRepository.existsById(id)) {
            musicaRepository.deleteById(id);
            return "Música excluída com sucesso.";
        } else {
            return "Erro: Música não encontrada.";
        }
    }
}
