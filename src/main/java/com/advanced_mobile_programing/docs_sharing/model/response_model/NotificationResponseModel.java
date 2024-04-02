package com.advanced_mobile_programing.docs_sharing.model.response_model;

import com.advanced_mobile_programing.docs_sharing.model.lean_model.UserLeanModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NotificationResponseModel implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private int notiId;

    private String type;
    // DOC_LIKE, POST_LIKE, POST_REPLY, REPLY_LIKE

    private int referredId;

    private int isRead;

    private UserLeanModel userReceived;

    private UserLeanModel userTriggered;
}
