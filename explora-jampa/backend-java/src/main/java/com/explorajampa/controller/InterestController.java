package com.explorajampa.controller;

import com.explorajampa.model.Interest;
import com.explorajampa.security.services.UserDetailsImpl;
import com.explorajampa.service.InterestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

@RestController
@RequestMapping("/api")
public class InterestController {

    @Autowired
    private InterestService interestService;

    @GetMapping("/interests")
    public ResponseEntity<List<Interest>> getAllInterests() {
        List<Interest> interests = interestService.getAllInterests();
        return ResponseEntity.ok(interests);
    }

    @PostMapping("/users/me/interests")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<?> saveUserInterests(@RequestBody Set<Long> interestIds) {
        UserDetailsImpl userDetails = (UserDetailsImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        interestService.saveUserInterests(userDetails.getId(), interestIds);
        return ResponseEntity.ok().build();
    }
}
