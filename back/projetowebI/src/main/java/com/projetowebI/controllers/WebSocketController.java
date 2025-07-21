package com.projetowebI.controllers;
import com.projetowebI.dtos.MusicaDTO;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;



@Controller
public class WebSocketController {

    @MessageMapping("/mudar-musica")
    @SendTo("/topic/repertorio")
    public int mudarMusica(int index) {
        System.out.println("Mudando música para índice: " + index);
        return index; // Retorna o índice correto
    }

    @MessageMapping("/atualizar-bandas")
    @SendTo("/topic/bandas")
    public String atualizarBandas(String mensagem) {
        System.out.println("Atualizando lista de bandas para todos os usuários.");
        return mensagem; // Apenas uma notificação para os clientes se atualizarem
    }

    @MessageMapping("/atualizar-repertorio/{idRepertorio}")
    @SendTo("/topic/repertorio-atualizar/{idRepertorio}")
    public String atualizarRepertorio(@DestinationVariable String idRepertorio, String mensagem) {
        System.out.println("Atualizando repertório " + idRepertorio + ": " + mensagem);
        return mensagem;
    }


}
