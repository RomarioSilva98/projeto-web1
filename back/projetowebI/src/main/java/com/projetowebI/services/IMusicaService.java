package com.projetowebI.services;

import com.projetowebI.models.Musica;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface IMusicaService {
    List<Musica> findAll();
    Musica findById(Integer id);
    Musica save(Musica musica, MultipartFile file, Integer bandaId) throws IOException;
    Musica update(Integer id, Musica musica);
    String delete(Integer id);
}
