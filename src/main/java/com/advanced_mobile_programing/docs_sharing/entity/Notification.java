package com.advanced_mobile_programing.docs_sharing.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

@Entity
public class Notification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int notiId;

    private String type;
    // DOC_LIKE, POST_LIKE, POST_COMMENT, COMMENT_LIKE

    private int referredId;

    private boolean isRead;

    @ManyToOne
    @JoinColumn(name = "userReceivedId")
    private User userReceived;

    @ManyToOne
    @JoinColumn(name = "userTriggeredId")
    private User userTriggered;
}
