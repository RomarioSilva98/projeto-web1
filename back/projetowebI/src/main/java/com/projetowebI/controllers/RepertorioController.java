package com.projetowebI.controllers;

import com.projetowebI.dtos.BandaDTO;
import com.projetowebI.dtos.RepertorioMusicasDTO;
import com.projetowebI.models.Repertorio;
import com.projetowebI.services.IRepertorioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/repertorios")
public class RepertorioController {

    private final IRepertorioService repertorioService;

    @Autowired
    public RepertorioController(IRepertorioService repertorioService) {
        this.repertorioService = repertorioService;
    }

    // Criar um novo repertório
    @PostMapping("/criar/{idBanda}")
    public ResponseEntity<String> criarRepertorio(@PathVariable Integer idBanda, @RequestBody Map<String, String> request) {
        String nomeRepertorio = request.get("nomeRepertorio");
        if (nomeRepertorio == null || nomeRepertorio.isEmpty()) {
            return ResponseEntity.badRequest().body("Nome do repertório é obrigatório.");
        }

        repertorioService.criarRepertorio(idBanda, nomeRepertorio);
        return ResponseEntity.ok("Repertório criado com sucesso.");
    }



    // Adicionar uma música ao repertório
    @PostMapping("/adicionar")
    public ResponseEntity<BandaDTO> adicionarMusicaAoRepertorio(
            @RequestParam Integer idRepertorio,
            @RequestParam Integer idBanda,
            @RequestParam Integer idMusica,
            @RequestParam String ordem) {

        BandaDTO bandaDTO = repertorioService.adicionarMusicaAoRepertorio(idRepertorio, idBanda, idMusica, ordem);
        return ResponseEntity.ok(bandaDTO);
    }


    // Listar músicas do repertório de uma banda
    @GetMapping("/{idRepertorio}")
    public ResponseEntity<List<RepertorioMusicasDTO>> listarMusicasDoRepertorio(@PathVariable Integer idRepertorio) {
        List<RepertorioMusicasDTO> musicas = repertorioService.listarMusicasPorRepertorio(idRepertorio);
        return ResponseEntity.ok(musicas);
    }

    @PutMapping("/{idRepertorio}/atualizar-ordem")
    public ResponseEntity<List<RepertorioMusicasDTO>> atualizarOrdem(
            @PathVariable Integer idRepertorio,
            @RequestBody Map<String, List<Map<String, Integer>>> request) {

        System.out.println("🔄 Recebendo nova ordem: " + request.get("musicas"));

        repertorioService.atualizarOrdem(idRepertorio, request.get("musicas"));

        List<RepertorioMusicasDTO> musicasAtualizadas = repertorioService.listarMusicasPorRepertorio(idRepertorio);

        System.out.println("✅ Lista atualizada: " + musicasAtualizadas);

        return ResponseEntity.ok(musicasAtualizadas);
    }




    // Remover uma música do repertório
    @DeleteMapping("/remover")
    public ResponseEntity<String> removerMusicaDoRepertorio(
            @RequestParam Integer idRepertorio,
            @RequestParam Integer idMusica) {

        repertorioService.removerMusicaDoRepertorio(idRepertorio, idMusica);
        return ResponseEntity.ok("Música removida do repertório com sucesso.");
    }

    @GetMapping("/banda-repertorio/{idRepertorio}")
    public ResponseEntity<BandaDTO> listarBandaComMusicasDoRepertorio(@PathVariable Integer idRepertorio) {
        BandaDTO bandaComMusicas = repertorioService.listarBandaComMusicasDoRepertorio(idRepertorio);
        return ResponseEntity.ok(bandaComMusicas);
    }

    // Excluir repertório de uma banda


    @PutMapping("/atualizar/{idRepertorio}")
    public ResponseEntity<String> atualizarRepertorio(
            @PathVariable Integer idRepertorio,
            @RequestBody Map<String, String> request) {

        String novoNome = request.get("novoNome");
        if (novoNome == null || novoNome.isEmpty()) {
            return ResponseEntity.badRequest().body("O novo nome do repertório é obrigatório.");
        }

        repertorioService.atualizarRepertorio(idRepertorio, novoNome);
        return ResponseEntity.ok("Repertório atualizado com sucesso.");
    }

    @DeleteMapping("/excluir/repertorio/{idRepertorio}")
    public ResponseEntity<String> excluirRepertorio(@PathVariable Integer idRepertorio) {
        repertorioService.excluirRepertorio(idRepertorio);
        return ResponseEntity.ok("Repertório excluído com sucesso.");
    }

}
