package com.advanced_mobile_programing.docs_sharing.service;

import com.advanced_mobile_programing.docs_sharing.entity.Document;
import com.advanced_mobile_programing.docs_sharing.entity.DocumentLike;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.entity.UserDocument;

import java.util.Optional;

public interface IDocumentLikeService {
    Optional<DocumentLike> findByUserAndDocument(User user, Document document);

    Optional<DocumentLike> findById(UserDocument userDocument);

    <S extends DocumentLike> S save(S entity);

    void delete(DocumentLike entity);
}
