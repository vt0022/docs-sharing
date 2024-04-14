package com.advanced_mobile_programing.docs_sharing.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

@Entity
public class Document {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int docId;

    @Column(nullable = false)
    private String docName;

    @Column(length = 65535)
    private String docIntroduction;

    @Column(nullable = false)
    private String viewUrl;

    @Column(nullable = false)
    private String downloadUrl;

    private Timestamp uploadedAt;

    private Timestamp updatedAt;

    private int totalView;

    @Column(nullable = true)
    private String thumbnail;

    @ManyToOne
    @JoinColumn(name = "uploadedBy")
    private User user;

    @ManyToOne
    @JoinColumn(name = "categoryId")
    private Category category;

    @ManyToOne
    @JoinColumn(name = "fieldId")
    private Field field;

    @OneToMany(mappedBy = "document", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DocumentLike> documentLikes = new ArrayList<>();

    @ManyToMany
    @JoinTable(name = "post_tag",
            joinColumns = @JoinColumn(name = "post_id"),
            inverseJoinColumns = @JoinColumn(name = "tag_id"))
    private List<Tag> tags = new ArrayList<>();

    @PrePersist
    protected void onCreate() {
        uploadedAt = new Timestamp(System.currentTimeMillis());
        updatedAt = new Timestamp(System.currentTimeMillis());
        totalView = 0;
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = new Timestamp(System.currentTimeMillis());
    }

}
