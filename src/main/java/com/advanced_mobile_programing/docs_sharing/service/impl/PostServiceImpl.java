package com.advanced_mobile_programing.docs_sharing.service.impl;

import com.advanced_mobile_programing.docs_sharing.entity.Post;
import com.advanced_mobile_programing.docs_sharing.entity.User;
import com.advanced_mobile_programing.docs_sharing.repository.IPostRepository;
import com.advanced_mobile_programing.docs_sharing.service.IPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class PostServiceImpl implements IPostService {

    private final IPostRepository postRepository;

    @Autowired
    public PostServiceImpl(IPostRepository postRepository) {
        this.postRepository = postRepository;
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
    public void save(Post post) {
        postRepository.save(post);
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
}
