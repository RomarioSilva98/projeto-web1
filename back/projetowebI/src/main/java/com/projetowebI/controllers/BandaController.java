package com.projetowebI.controllers;

import com.projetowebI.dtos.BandaDTO;
import com.projetowebI.dtos.CriarBandaDTO;
import com.projetowebI.models.Banda;
import com.projetowebI.services.IBandaService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/banda")
public class BandaController {

    @Autowired
    private IBandaService bandaService;

    @PostMapping("/criar")
    public ResponseEntity<BandaDTO> criar(@Valid @RequestBody CriarBandaDTO dto) {
        try {
            Banda banda = bandaService.criarBanda(dto);
            return ResponseEntity.ok(new BandaDTO(banda));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
    }

    @GetMapping("/usuario/{usuarioId}")
    public ResponseEntity<List<BandaDTO>> listarBandasPorUsuario(@PathVariable Integer usuarioId) {
        List<BandaDTO> bandas = bandaService.listarBandasPorUsuario(usuarioId);

        System.out.println("Bandas retornadas para o usuário " + usuarioId + ": " + bandas.size());
        bandas.forEach(b -> System.out.println("Banda DTO: " + b.getNomeBanda() + " - Usuários: " + b.getUsuarios().size()));

        return ResponseEntity.ok(bandas);
    }


    @PostMapping("/{bandaId}/adicionarMusico")
    public ResponseEntity<Banda> adicionarMusico(@PathVariable Integer bandaId, @RequestParam Integer musicoId) {
        Banda banda = bandaService.adicionarMusico(bandaId, musicoId);
        return ResponseEntity.ok(banda);
    }

    @DeleteMapping("/{bandaId}/removerMusico")
    public ResponseEntity<Banda> removerMusico(@PathVariable Integer bandaId, @RequestParam Integer musicoId) {
        Banda banda = bandaService.removerMusico(bandaId, musicoId);
        return ResponseEntity.ok(banda);
    }

    @PutMapping("/{bandaId}/atualizar")
    public ResponseEntity<Banda> atualizarBanda(
            @PathVariable Integer bandaId,
            @RequestParam(required = false) String novoNome,
            @RequestParam(required = false) String novoGenero) {

        Banda banda = bandaService.atualizarBanda(bandaId, novoNome, novoGenero);
        return ResponseEntity.ok(banda);
    }

    @DeleteMapping("/{bandaId}/excluir")
    public ResponseEntity<String> excluirBanda(@PathVariable Integer bandaId, @RequestParam Integer usuarioId) {
        try {
            bandaService.excluirBanda(bandaId, usuarioId);
            return ResponseEntity.ok("Banda excluída com sucesso.");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        } catch (SecurityException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(e.getMessage());
        }
    }

    @GetMapping("/{bandaId}")
    public ResponseEntity<BandaDTO> getBandaById(@PathVariable Integer bandaId) {
        Banda banda = bandaService.buscarBandaPorId(bandaId);
        return banda != null ? ResponseEntity.ok(new BandaDTO(banda)) : ResponseEntity.notFound().build();
    }
}
