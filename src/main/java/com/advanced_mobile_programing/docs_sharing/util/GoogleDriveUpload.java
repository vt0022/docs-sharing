package com.advanced_mobile_programing.docs_sharing.util;

import com.advanced_mobile_programing.docs_sharing.model.FileModel;
import com.google.api.client.http.FileContent;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.model.File;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

@Service
public class GoogleDriveUpload {
    private final Drive googleDrive;
    private final ThumbnailGenerator thumbnailGenerator;

    @Autowired
    public GoogleDriveUpload(Drive googleDrive, ThumbnailGenerator thumbnailGenerator) {
        this.googleDrive = googleDrive;
        this.thumbnailGenerator = thumbnailGenerator;
    }

    public void deleteFile(String fileId) {
        try {
            googleDrive.files().delete(fileId).execute();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public FileModel uploadFile(MultipartFile multipartFile, String name, String fileId, String thumbnailId) {
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
            gd.setThumbnail(generateThumbnail(tempFile, name.concat(".jpg"), thumbnailId));
            gd.setDownloadUrl(file.getWebContentLink());
            tempFile.delete();
            return gd;
        } catch (IOException e) {
            // Handle exceptions
            e.printStackTrace();
            return null;
        }
    }

    public FileModel uploadImage(MultipartFile multipartFile, String fileName, String fileId, String type) {
        try {
            // Set parent folder
            String folderId = type.equals("post") ? "1XnybAsjEda_D0ohYUeHgajgecIU2nDl0" : "1mBcfLCCQP9QK9S1h73OGYziYK_vp_6au";

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

    public String generateThumbnail(java.io.File pdfFile, String fileName, String thumbnailId) {
        try {
            BufferedImage thumbnail = thumbnailGenerator.generateThumbnail(pdfFile);

            // Set the folder to store thumbnail
            File ggDriveFile = new File();
            List<String> parents = Collections.singletonList("1GjXXKz4SP_6ct83ww-adneq_AggBFjF9");
            ggDriveFile.setParents(parents).setName(fileName);

            // Create temporary file
            java.io.File tempThumbnail = java.io.File.createTempFile("thumbnail", ".jpg");

            // Write the BufferedImage to the temporary File
            ImageIO.write(thumbnail, "jpg", tempThumbnail);

            // Create FileContent
            FileContent mediaContent = new FileContent("image/jpeg", tempThumbnail);

            // Delete old file
            if (thumbnailId != null) {
                try {
                    googleDrive.files().delete(thumbnailId).execute();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }

            // Use Google Drive API to create the file
            File uploadFile = googleDrive.files().create(ggDriveFile, mediaContent)
                    .setFields("id, name, webViewLink, webContentLink, thumbnailLink")
                    .execute();

            tempThumbnail.delete();
            return "https://drive.google.com/thumbnail?id=" + uploadFile.getId();
        } catch (IOException e) {
            // Handle exceptions
            e.printStackTrace();
            return null;
        }
    }
}
