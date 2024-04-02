package com.advanced_mobile_programing.docs_sharing.model.request_model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NotificationRequestModel implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private String type;
    // DOC_LIKE, POST_LIKE, POST_REPLY, REPLY_LIKE

    private int referredId;

    private int userReceivedId;

    private int userTriggeredId;
}
