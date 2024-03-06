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
@Table(name = "Field")
public class Field {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int fieldId;

    @Column(unique = true, length = 100, nullable = false)
    private String fieldName;

    private Timestamp createdAt;

    private Timestamp updatedAt;

    private boolean isDisabled;

    @OneToMany(mappedBy = "field")
    private List<Document> documents = new ArrayList<>();

    @PrePersist
    protected void onCreate() {
        createdAt = new Timestamp(System.currentTimeMillis());
        updatedAt = new Timestamp(System.currentTimeMillis());
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = new Timestamp(System.currentTimeMillis());
    }
}
