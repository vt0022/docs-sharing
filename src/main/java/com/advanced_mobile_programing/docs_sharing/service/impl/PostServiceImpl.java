package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.Post;
import com.advanced_mobile_programing.docs_sharing.entity.Tag;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.repository.IPostRepository;
import com.advanced_mobile_programing.docs_sharing.service.IPostService;
import com.advanced_mobile_programing.docs_sharing.service.ITagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class PostServiceImpl implements IPostService {

    private final IPostRepository postRepository;
    private final ITagService tagService;

    @Autowired
    public PostServiceImpl(IPostRepository postRepository, ITagService tagService) {
        this.postRepository = postRepository;
        this.tagService = tagService;
    }

    @Override
    public Page<Post> findAll(Pageable pageable) {
        return postRepository.findAll(pageable);
    }

    @Override
    public Page<Post> searchAll(String order, String q, Pageable pageable) {
        return order.equals("mostLikes") ?
                postRepository.findAllOrderByLikes(q, pageable) :
                postRepository.findByTitleContainingIgnoreCaseOrContentContainingIgnoreCaseOrderByCreatedAtDesc(q, q, pageable);
    }

    @Override
    public Optional<Post> findById(Integer integer) {
        return postRepository.findById(integer);
    }

    @Override
    public <S extends Post> S save(S entity) {
        return postRepository.save(entity);
    }

    @Override
    public void delete(int postId) {
        postRepository.deleteById(postId);
    }

    @Override
    public long countByCreatedAtYearAndMonth(int year, int month) {
        LocalDateTime start = LocalDateTime.of(year, month, 1, 0, 0);
        LocalDateTime end = start.plusMonths(1);
        return postRepository.countByCreatedAtBetween(start, end);
    }

    @Override
    public long countAll() {
        return postRepository.count();
    }

    @Override
    public long countByCreatedAtYear(int year) {
        return postRepository.countByCreatedAtYear(year);
    }

    @Override
    public Page<Post> findByUserOrderByCreatedAtDesc(User user, Pageable pageable) {
        return postRepository.findByUserOrderByCreatedAtDesc(user, pageable);
    }

    @Override
    @Query("SELECT p FROM Post p " +
            "JOIN p.postLikes l " +
            "WHERE l.user = :user " +
            "ORDER BY l.likedAt DESC")
    public Page<Post> findByUserLike(User user, Pageable pageable) {
        return postRepository.findByUserLike(user, pageable);
    }

    @Override
    public Page<Post> searchWithTag(String q, int tagId, String order, Pageable pageable) {
        Tag tag = tagService.findById(tagId).orElseThrow(() -> new RuntimeException("Tag not found"));

        if (order.equals("mostLikes")) {
            return postRepository.findAllByTagsOrderByLikes(q, tag, pageable);
        } else {
            Sort sort;
            Pageable newPageable;
            if (order.equals("oldest"))
                sort = Sort.by(Sort.Direction.ASC, "createdAt");
            else
                sort = Sort.by(Sort.Direction.DESC, "createdAt");

            newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
            return postRepository.findAllByTags(q, tag, newPageable);
        }
    }
}
