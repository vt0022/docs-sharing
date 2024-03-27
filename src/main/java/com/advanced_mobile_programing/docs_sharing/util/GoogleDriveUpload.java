package com.advanced_mobile_programing.docs_sharing.util;

import com.advanced_mobile_programing.docs_sharing.model.FileModel;
import com.google.api.client.http.FileContent;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.model.File;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

@Service
public class GoogleDriveUpload {
    private final Drive googleDrive;

    @Autowired
    public GoogleDriveUpload(Drive googleDrive) {
        this.googleDrive = googleDrive;
    }

    public void deleteFile(String fileId) {
        try {
            googleDrive.files().delete(fileId).execute();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public FileModel uploadFile(MultipartFile multipartFile, String name, String fileId) {
        try {
            // Set parent folder
            List<String> parents = Collections.singletonList("19cQqP6PPO6UBu7mG3qViLifydFr8H382");

            // Create Drive file and apply parent folder and name
            File ggDriveFile = new File();
            String fileName = name;
            ggDriveFile.setParents(parents).setName(fileName);

            // Create temporary file
            java.io.File tempFile = java.io.File.createTempFile("temp", ".pdf");
            multipartFile.transferTo(tempFile);

            // Create FileContent from the MultipartFile bytes
            FileContent mediaContent = new FileContent(multipartFile.getContentType(), tempFile);

            // Delete old file
            if (fileId != null) {
                try {
                    googleDrive.files().delete(fileId).execute();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }

            // Use Google Drive API to create the file
            File file = googleDrive.files().create(ggDriveFile, mediaContent)
                    .setFields("id, webContentLink") //, thumbnailLink
                    .execute();
            FileModel gd = new FileModel();
            gd.setName(fileName);
            gd.setViewUrl("https://drive.google.com/file/d/" + file.getId() + "/preview");
            gd.setDownloadUrl(file.getWebContentLink());
            tempFile.delete();
            return gd;
        } catch (IOException e) {
            // Handle exceptions
            e.printStackTrace();
            return null;
        }
    }

    public FileModel uploadImage(MultipartFile multipartFile, String fileName, String fileId) {
        try {
            // Set parent folder
            String folderId = "1mBcfLCCQP9QK9S1h73OGYziYK_vp_6au";

            List<String> parents = Collections.singletonList(folderId);

            // Create Drive file and apply parent folder and name
            File ggDriveFile = new File();
            ggDriveFile.setParents(parents).setName(fileName);

            // Create temporary file
            java.io.File tempFile = java.io.File.createTempFile("temp", null);
            multipartFile.transferTo(tempFile);

            // Create FileContent from the MultipartFile bytes
            FileContent mediaContent = new FileContent(multipartFile.getContentType(), tempFile);

            // Delete old file
            if (fileId != null) {
                try {
                    googleDrive.files().delete(fileId).execute();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }

            // Use Google Drive API to create the file
            File file = googleDrive.files().create(ggDriveFile, mediaContent)
                    .setFields("id, webContentLink")
                    .execute();
            FileModel gd = new FileModel();
            gd.setViewUrl("https://drive.google.com/thumbnail?id=" + file.getId());

            tempFile.delete();
            return gd;
        } catch (Exception e) {
            // Handle exceptions
            e.printStackTrace();
            return null;
        }
    }

}
