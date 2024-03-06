package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.Document;
import com.advanced_mobile_programing.docs_sharing.entity.DocumentLike;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.entity.UserDocument;
import com.advanced_mobile_programing.docs_sharing.repository.IDocumentLikeRepository;
import com.advanced_mobile_programing.docs_sharing.service.IDocumentLikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class DocumentLikeServiceImpl implements IDocumentLikeService {
    private final IDocumentLikeRepository documentLikeRepository;

    @Autowired
    public DocumentLikeServiceImpl(IDocumentLikeRepository documentLikeRepository) {
        this.documentLikeRepository = documentLikeRepository;
    }

    @Override
    public Optional<DocumentLike> findByUserAndDocument(User user, Document document) {
        return documentLikeRepository.findByUserAndDocument(user, document);
    }

    @Override
    public Optional<DocumentLike> findById(UserDocument userDocument) {
        return documentLikeRepository.findById(userDocument);
    }

    @Override
    public <S extends DocumentLike> S save(S entity) {
        return documentLikeRepository.save(entity);
    }

    @Override
    public void delete(DocumentLike entity) {
        documentLikeRepository.delete(entity);
    }
}
