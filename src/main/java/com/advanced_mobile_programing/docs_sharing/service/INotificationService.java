package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Notification;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface INotificationService {

    void notifyUser(String email, Notification notification);

    void sendPrivateNotification(String id);

    Page<Notification> findAllByUserReceived(User user, Pageable pageable);

    <S extends Notification> S save(S entity);

    Optional<Notification> findById(int uuid);
}
