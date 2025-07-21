package com.projetowebI.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import static org.springframework.security.config.Customizer.withDefaults; // Import necessário

import java.util.List;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .cors(cors -> cors.configurationSource(corsConfigurationSource())) // Configuração CORS
                .csrf(csrf -> csrf.disable()) // Desativa CSRF
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/login").permitAll() // Permite login sem autenticação
                        .requestMatchers("/api/**").authenticated() // Protege rotas da API
                        .anyRequest().permitAll() // Permite outras requisições
                )
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)) // Sem estado
                .headers(headers -> headers
                        .frameOptions(frame -> frame.sameOrigin()) // Permite iframes da mesma origem
                        .contentSecurityPolicy(csp -> csp.policyDirectives("frame-ancestors 'self' http://localhost:*")) // Permite iframes do frontend
                );


        return http.build();
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();

        // Adicione explicitamente as origens permitidas
        configuration.setAllowedOriginPatterns(List.of("http://localhost:*"));

        configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(List.of("*"));
        configuration.setExposedHeaders(List.of("Authorization", "Content-Type"));
        configuration.setAllowCredentials(true); // Permite credenciais

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
