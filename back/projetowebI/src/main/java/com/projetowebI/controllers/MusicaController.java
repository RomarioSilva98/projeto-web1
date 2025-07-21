package com.projetowebI.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.projetowebI.models.Musica;
import com.projetowebI.repositories.MusicaRepository;
import com.projetowebI.services.IMusicaService;
import com.projetowebI.services.impl.FileStorageService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Path;
import java.util.List;

@RestController
@RequestMapping("/musicas")
public class MusicaController {

    private final FileStorageService fileStorageService;
    private final IMusicaService musicaService;
    private final MusicaRepository musicaRepository;

    @Autowired
    public MusicaController(IMusicaService musicaService, FileStorageService fileStorageService, MusicaRepository musicaRepository) {
        this.musicaService = musicaService;
        this.fileStorageService = fileStorageService;
        this.musicaRepository = musicaRepository;
    }

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> createMusica(
            @RequestPart("musica") String musicaJson,
            @RequestPart("file") MultipartFile file,
            @RequestParam(value = "bandaId", required = false) Integer bandaId) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            Musica musica = objectMapper.readValue(musicaJson, Musica.class);

            Musica savedMusica = musicaService.save(musica, file, bandaId);
            return ResponseEntity.ok(savedMusica);
        } catch (IOException e) {
            return ResponseEntity.status(500).body("Erro ao processar o JSON ou o arquivo: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(400).body(e.getMessage());
        }
    }

    @GetMapping("/arquivo/{idMusica}")
    public ResponseEntity<Resource> baixarArquivoMusica(@PathVariable Integer idMusica) {
        Musica musica = musicaService.findById(idMusica);
        if (musica == null || musica.getArquivoPdf() == null) {
            return ResponseEntity.notFound().build();
        }

        try {

            Path filePath = fileStorageService.getFilePath(musica.getArquivoPdf());
            Resource resource = new UrlResource(filePath.toUri());

            if (resource.exists() && resource.isReadable()) {
                return ResponseEntity.ok()
                        .contentType(MediaType.APPLICATION_PDF)
                        .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + musica.getTitulo() + ".pdf\"")
                        .body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (IOException e) {
            return ResponseEntity.status(500).body(null);
        }
    }


    @GetMapping("/buscar")
    public ResponseEntity<List<Musica>> buscarMusicasPorTitulo(
            @RequestParam String titulo,
            @RequestParam Integer idBanda) {
        List<Musica> musicas = musicaRepository.buscarMusicasPorTituloEBanda(titulo, idBanda);
        return ResponseEntity.ok(musicas);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Musica> getMusicaById(@PathVariable Integer id) {
        Musica musica = musicaService.findById(id);
        return (musica != null) ? ResponseEntity.ok(musica) : ResponseEntity.notFound().build();
    }

    @GetMapping
    public ResponseEntity<List<Musica>> getAllMusicas() {
        return ResponseEntity.ok(musicaService.findAll());
    }

    @PutMapping("/{id}")
    public ResponseEntity<Musica> updateMusica(@PathVariable Integer id, @RequestBody Musica musica) {
        Musica updatedMusica = musicaService.update(id, musica);
        return (updatedMusica != null) ? ResponseEntity.ok(updatedMusica) : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteMusica(@PathVariable Integer id) {
        String message = musicaService.delete(id);
        return message.equals("Música excluída com sucesso.") ? ResponseEntity.ok(message) : ResponseEntity.status(404).body(message);
    }
}
