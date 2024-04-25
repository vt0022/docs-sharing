package com.advanced_mobile_programing.docs_sharing.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

@Entity
public class PostImage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int postImageId;

    private String url;

    @ManyToOne
    @JoinColumn(name = "postId")
    private Post post;
}
