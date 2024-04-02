package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.Notification;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.model.response_model.NotificationResponseModel;
import com.advanced_mobile_programing.docs_sharing.repository.INotificationRepository;
import com.advanced_mobile_programing.docs_sharing.service.INotificationService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class NotificationServiceImpl implements INotificationService {
    private final INotificationRepository notificationRepository;
    private final SimpMessagingTemplate simpMessagingTemplate;
    private final ModelMapper modelMapper;

    @Autowired
    public NotificationServiceImpl(INotificationRepository notificationRepository, SimpMessagingTemplate simpMessagingTemplate, ModelMapper modelMapper) {
        this.notificationRepository = notificationRepository;
        this.simpMessagingTemplate = simpMessagingTemplate;
        this.modelMapper = modelMapper;
    }

    @Override
    public void notifyUser(String email, Notification notification) {
        NotificationResponseModel notificationResponseModel = modelMapper.map(notification, NotificationResponseModel.class);
        simpMessagingTemplate.convertAndSendToUser(email, "/notify/send-back-user", notificationResponseModel);
    }

    @Override
    public void sendPrivateNotification(final String email) {
        NotificationResponseModel notificationResponseModel = new NotificationResponseModel();
        simpMessagingTemplate.convertAndSendToUser(email, "/topic/private-notifications", notificationResponseModel);
    }

    @Override
    public Page<Notification> findAllByUserReceived(User user, Pageable pageable) {
        return notificationRepository.findAllByUserReceived(user, pageable);
    }

    @Override
    public <S extends Notification> S save(S entity) {
        return notificationRepository.save(entity);
    }

    @Override
    public Optional<Notification> findById(int id) {
        return notificationRepository.findById(id);
    }
}
