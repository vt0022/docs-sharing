package com.advanced_mobile_programing.docs_sharing.repository;

import com.advanced_mobile_programing.docs_sharing.entity.Document;
import com.advanced_mobile_programing.docs_sharing.entity.DocumentLike;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.entity.UserDocument;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IDocumentLikeRepository extends JpaRepository<DocumentLike, UserDocument> {
    Optional<DocumentLike> findByUserAndDocument(User user, Document document);
}
