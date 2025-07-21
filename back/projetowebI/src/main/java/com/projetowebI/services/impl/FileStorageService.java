package com.projetowebI.services.impl;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.*;

@Service
public class FileStorageService {
    private final Path fileStorageLocation;

    public FileStorageService(@Value("${file.upload-dir}") String uploadDir) throws IOException {
        this.fileStorageLocation = Paths.get(uploadDir).toAbsolutePath().normalize();
        Files.createDirectories(fileStorageLocation); // Cria a pasta se não existir
    }

    public String storeFile(MultipartFile file, String fileName) throws IOException {
        Path targetLocation = fileStorageLocation.resolve(fileName);
        Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);

        return "http://localhost:8080/arquivos/download/" + fileName;
    }

    public Path getFilePath(String fileUrl) {
        // Extraímos apenas o nome do arquivo da URL completa
        String nomeArquivo = fileUrl.substring(fileUrl.lastIndexOf("/") + 1); // Extrai o nome do arquivo
        return fileStorageLocation.resolve(nomeArquivo).normalize(); // Usa fileStorageLocation em vez de uploadDir
    }


}
