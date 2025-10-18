package com.explorajampa.service;

import com.explorajampa.model.Interest;
import com.explorajampa.model.User;
import com.explorajampa.repository.InterestRepository;
import com.explorajampa.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class InterestService {

    @Autowired
    private InterestRepository interestRepository;

    @Autowired
    private UserRepository userRepository;

    public List<Interest> getAllInterests() {
        return interestRepository.findAll();
    }

    public void saveUserInterests(Long userId, Set<Long> interestIds) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Set<Interest> interests = new HashSet<>(interestRepository.findAllById(interestIds));
        user.setInterests(interests);
        userRepository.save(user);
    }
}
