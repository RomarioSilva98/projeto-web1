<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SongFlow - Sistema de Gerenciamento de Bandas</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #1a1a2e;
            color: #e6e6e6;
            line-height: 1.6;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        header {
            text-align: center;
            padding: 30px 0;
            background: linear-gradient(135deg, #162447 0%, #1a1a2e 100%);
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
        }
        
        h1 {
            font-size: 3rem;
            margin-bottom: 15px;
            color: #f8c300;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }
        
        h2 {
            font-size: 2rem;
            margin: 25px 0 15px;
            color: #4ecca3;
            border-bottom: 2px solid #4ecca3;
            padding-bottom: 8px;
        }
        
        h3 {
            font-size: 1.5rem;
            margin: 20px 0 10px;
            color: #f8c300;
        }
        
        .subtitle {
            font-size: 1.2rem;
            color: #4ecca3;
            margin-bottom: 20px;
        }
        
        section {
            background: #162447;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        ul {
            list-style-type: none;
            padding-left: 20px;
        }
        
        li {
            margin-bottom: 10px;
            padding-left: 25px;
            position: relative;
        }
        
        li:before {
            content: "🎵";
            position: absolute;
            left: 0;
            top: 0;
        }
        
        .tech-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .tech-card {
            background: #1f4068;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .feature-card {
            background: #1f4068;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            height: 100%;
        }
        
        .feature-card h3 {
            color: #f8c300;
            margin-top: 0;
        }
        
        .code-block {
            background: #1f4068;
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
            overflow-x: auto;
            font-family: monospace;
        }
        
        footer {
            text-align: center;
            margin-top: 40px;
            padding: 20px;
            border-top: 1px solid #4ecca3;
        }
        
        .highlight {
            color: #f8c300;
            font-weight: bold;
        }
        
        .note {
            background: #1f4068;
            padding: 15px;
            border-left: 4px solid #f8c300;
            margin: 15px 0;
            border-radius: 4px;
        }
        
        @media (max-width: 768px) {
            .tech-grid, .features-grid {
                grid-template-columns: 1fr;
            }
            
            h1 {
                font-size: 2.2rem;
            }
            
            h2 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1>🎵 SongFlow</h1>
        <p class="subtitle">Sistema de Gerenciamento de Repertórios para Bandas com Sincronização em Tempo Real</p>
    </header>

    <section>
        <h2>📋 Descrição do Projeto</h2>
        <p>Sistema completo para gerenciamento de repertórios musicais em bandas, com sincronização em tempo real durante apresentações. Desenvolvido como trabalho acadêmico para a disciplina Web I.</p>
    </section>

    <section>
        <h2>🎯 Objetivo</h2>
        <p>Gerenciar bandas, músicas, repertórios e membros com sincronização em tempo real durante shows, onde o responsável da banda controla a mudança de músicas para todos os integrantes simultaneamente.</p>
    </section>

    <section>
        <h2>🛠️ Tecnologias Utilizadas</h2>
        <div class="tech-grid">
            <div class="tech-card">
                <h3>Backend</h3>
                <ul>
                    <li>Java Spring Boot - Framework principal</li>
                    <li>Spring Security - Autenticação e autorização</li>
                    <li>WebSocket - Sincronização em tempo real</li>
                    <li>MySQL - Banco de dados relacional</li>
                    <li>JPA/Hibernate - ORM e persistência de dados</li>
                    <li>Maven - Gerenciamento de dependências</li>
                </ul>
            </div>
            
            <div class="tech-card">
                <h3>Frontend</h3>
                <ul>
                    <li>Flutter - Framework multiplataforma</li>
                    <li>Dart - Linguagem de programação</li>
                    <li>Syncfusion Flutter PDF Viewer - Visualização de partituras</li>
                    <li>WebSocket - Comunicação em tempo real</li>
                </ul>
            </div>
        </div>
    </section>

    <section>
        <h2>📊 Funcionalidades</h2>
        <div class="features-grid">
            <div class="feature-card">
                <h3>👤 Gestão de Usuários</h3>
                <ul>
                    <li>Cadastro e autenticação de músicos</li>
                    <li>Perfil de usuário</li>
                    <li>Participação em múltiplas bandas</li>
                </ul>
            </div>
            
            <div class="feature-card">
                <h3>🎸 Gestão de Bandas</h3>
                <ul>
                    <li>Criação e administração de bandas</li>
                    <li>Adição/remoção de membros</li>
                    <li>Um responsável principal por banda</li>
                </ul>
            </div>
            
            <div class="feature-card">
                <h3>🎶 Gestão de Músicas</h3>
                <ul>
                    <li>Cadastro de músicas em formato PDF</li>
                    <li>Armazenamento de partituras e cifras</li>
                    <li>Catálogo centralizado de músicas</li>
                </ul>
            </div>
            
            <div class="feature-card">
                <h3>📖 Gestão de Repertórios</h3>
                <ul>
                    <li>Criação de repertórios para shows</li>
                    <li>Ordenação de músicas no repertório</li>
                    <li>Adição/remoção não destrutiva de músicas</li>
                </ul>
            </div>
            
            <div class="feature-card">
                <h3>⚡ Sincronização em Tempo Real</h3>
                <ul>
                    <li>WebSocket para comunicação durante shows</li>
                    <li>Controle centralizado pelo responsável da banda</li>
                    <li>Mudança sincronizada de músicas em todos os dispositivos</li>
                </ul>
            </div>
        </div>
    </section>

    <section>
        <h2>🗃️ Estrutura do Banco de Dados</h2>
        <h3>Principais Entidades</h3>
        <ul>
            <li>Usuario - Músicos do sistema</li>
            <li>Banda - Grupos musicais</li>
            <li>Musica - Músicas do catálogo</li>
            <li>Repertorio - Listas de músicas para shows</li>
            <li>Participacao - Relação usuário-banda</li>
            <li>BandaMusica - Relação banda-música</li>
            <li>RepertorioMusicas - Relação repertório-música</li>
        </ul>
    </section>

    <section>
        <h2>🚀 Como Executar</h2>
        
        <h3>Pré-requisitos</h3>
        <ul>
            <li>Java JDK 17+</li>
            <li>Flutter SDK</li>
            <li>MySQL Server (ou outro banco, configure no application.properties)</li>
        </ul>
        
        <h3>Backend (Spring Boot)</h3>
        <div class="code-block">
            cd back/projetowebI<br>
            mvn spring-boot:run
        </div>
        
        <h3>Frontend (Flutter)</h3>
        <div class="code-block">
            cd front/projetoweb1<br>
            flutter pub get<br>
            flutter run
        </div>
    </section>

    <section>
        <h2>📱 Funcionalidades do App</h2>
        <h3>Telas Principais</h3>
        <ul>
            <li>Login/Registro - Autenticação de usuários</li>
            <li>Home - Dashboard principal</li>
            <li>Gerenciar Bandas - Criação e administração</li>
            <li>Criar Música - Upload de partituras PDF</li>
            <li>Gerenciar Repertório - Montagem de setlists</li>
            <li>Visualizador PDF - Exibição de partituras</li>
            <li>Show ao Vivo - Modo de apresentação sincronizado</li>
        </ul>
    </section>

    <section>
        <h2>🎨 Funcionalidades de Sincronização</h2>
        <ul>
            <li>Início do Show - Responsável inicia sessão WebSocket</li>
            <li>Conexão dos Músicos - Integrantes conectam-se à sessão</li>
            <li>Controle de Músicas - Responsável avança músicas</li>
            <li>Sincronização Automática - Todos dispositivos atualizam simultaneamente</li>
        </ul>
    </section>

    <section>
        <h2>📊 Regras de Negócio</h2>
        <ul>
            <li>Um usuário pode participar de múltiplas bandas</li>
            <li>Cada banda possui um único responsável</li>
            <li>Músicas removidas do repertório não são excluídas do sistema</li>
            <li>A ordem das músicas é sincronizada para todos os membros</li>
            <li>Apenas o responsável pode controlar a sequência durante shows</li>
        </ul>
        
        <div class="note">
            <p>PS: Na pasta uploads tem os pdfs de musicas usados para testar e apresentar o projeto.</p>
        </div>
    </section>

    <section>
        <h2>👥 Desenvolvido por</h2>
        <p>Romário</p>
    </section>

    <section>
        <h2>📄 Licença</h2>
        <p>Este projeto foi desenvolvido para fins acadêmicos como parte da avaliação da disciplina.</p>
    </section>

    <footer>
        <p>🎓 <span class="highlight">SongFlow</span> - Sistema de Gerenciamento de Bandas | Desenvolvido com Java Spring Boot e Flutter</p>
    </footer>
</body>
</html>
