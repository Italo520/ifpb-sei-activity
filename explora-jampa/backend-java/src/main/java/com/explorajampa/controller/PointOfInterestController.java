package com.explorajampa.controller;

import com.explorajampa.model.PointOfInterest;
import com.explorajampa.service.PointOfInterestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/pois")
public class PointOfInterestController {

    @Autowired
    private PointOfInterestService pointOfInterestService;

    @GetMapping
    public List<PointOfInterest> getAllPointsOfInterest() {
        return pointOfInterestService.getAllPointsOfInterest();
    }

    @GetMapping("/{id}")
    public PointOfInterest getPointOfInterestById(@PathVariable Long id) {
        return pointOfInterestService.getPointOfInterestById(id);
    }

    @PostMapping
    public PointOfInterest createPointOfInterest(@RequestBody PointOfInterest pointOfInterest) {
        return pointOfInterestService.createPointOfInterest(pointOfInterest);
    }

    @DeleteMapping("/{id}")
    public void deletePointOfInterest(@PathVariable Long id) {
        pointOfInterestService.deletePointOfInterest(id);
    }
}
