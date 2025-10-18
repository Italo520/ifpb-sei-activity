package com.explorajampa.service;

import com.explorajampa.model.*;
import com.explorajampa.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GamificationService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private MissionRepository missionRepository;

    @Autowired
    private UserMissionProgressRepository userMissionProgressRepository;

    @Autowired
    private BadgeRepository badgeRepository;

    @Autowired
    private UserBadgeRepository userBadgeRepository;

    public void startMission(Long userId, Long missionId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        Mission mission = missionRepository.findById(missionId).orElseThrow(() -> new RuntimeException("Mission not found"));

        UserMissionProgress progress = userMissionProgressRepository.findByUserAndMission(user, mission)
                .orElse(new UserMissionProgress(user, mission, MissionStatus.NOT_STARTED));

        progress.setStatus(MissionStatus.IN_PROGRESS);
        userMissionProgressRepository.save(progress);
    }

    public void completeMission(Long userId, Long missionId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        Mission mission = missionRepository.findById(missionId).orElseThrow(() -> new RuntimeException("Mission not found"));

        UserMissionProgress progress = userMissionProgressRepository.findByUserAndMission(user, mission)
                .orElseThrow(() -> new RuntimeException("User has not started this mission"));

        progress.setStatus(MissionStatus.COMPLETED);
        userMissionProgressRepository.save(progress);

        checkAndAwardBadges(user);
    }

    private void checkAndAwardBadges(User user) {
        // Lógica de exemplo: Conceder um badge após completar 3 missões
        List<UserMissionProgress> completedMissions = userMissionProgressRepository.findAll().stream()
                .filter(p -> p.getUser().equals(user) && p.getStatus() == MissionStatus.COMPLETED)
                .toList();

        if (completedMissions.size() >= 3) {
            Badge badge = badgeRepository.findById(1L).orElse(null); // Assume que o badge de "3 missões" tem ID 1
            if (badge != null) {
                UserBadge existingUserBadge = userBadgeRepository.findByUser(user).stream()
                        .filter(ub -> ub.getBadge().equals(badge))
                        .findFirst()
                        .orElse(null);

                if (existingUserBadge == null) {
                    userBadgeRepository.save(new UserBadge(user, badge));
                }
            }
        }
    }

    public List<UserBadge> getUserBadges(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        return userBadgeRepository.findByUser(user);
    }
}
