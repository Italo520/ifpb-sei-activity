package com.explorajampa.controller;

import com.explorajampa.model.UserBadge;
import com.explorajampa.security.services.UserDetailsImpl;
import com.explorajampa.service.GamificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/gamification")
public class GamificationController {

    @Autowired
    private GamificationService gamificationService;

    @PostMapping("/missions/{missionId}/start")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<?> startMission(@PathVariable Long missionId) {
        UserDetailsImpl userDetails = (UserDetailsImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        gamificationService.startMission(userDetails.getId(), missionId);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/missions/{missionId}/complete")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<?> completeMission(@PathVariable Long missionId) {
        UserDetailsImpl userDetails = (UserDetailsImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        gamificationService.completeMission(userDetails.getId(), missionId);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/users/{userId}/badges")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<UserBadge>> getUserBadges(@PathVariable Long userId) {
        List<UserBadge> badges = gamificationService.getUserBadges(userId);
        return ResponseEntity.ok(badges);
    }
}
