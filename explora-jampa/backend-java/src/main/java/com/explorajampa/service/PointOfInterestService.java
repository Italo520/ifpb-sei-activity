package com.explorajampa.service;

import com.explorajampa.model.PointOfInterest;
import com.explorajampa.repository.PointOfInterestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PointOfInterestService {

    @Autowired
    private PointOfInterestRepository pointOfInterestRepository;

    public List<PointOfInterest> getAllPointsOfInterest() {
        return pointOfInterestRepository.findAll();
    }

    public PointOfInterest getPointOfInterestById(Long id) {
        return pointOfInterestRepository.findById(id).orElse(null);
    }

    public PointOfInterest createPointOfInterest(PointOfInterest pointOfInterest) {
        return pointOfInterestRepository.save(pointOfInterest);
    }

    public void deletePointOfInterest(Long id) {
        pointOfInterestRepository.deleteById(id);
    }
}
