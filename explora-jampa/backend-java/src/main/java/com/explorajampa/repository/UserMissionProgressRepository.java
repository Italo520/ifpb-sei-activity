package com.explorajampa.repository;

import com.explorajampa.model.Mission;
import com.explorajampa.model.User;
import com.explorajampa.model.UserMissionProgress;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserMissionProgressRepository extends JpaRepository<UserMissionProgress, Long> {
    Optional<UserMissionProgress> findByUserAndMission(User user, Mission mission);
}
