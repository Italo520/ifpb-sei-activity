package com.explorajampa;

import com.explorajampa.model.ERole;
import com.explorajampa.model.Role;
import com.explorajampa.model.Interest;
import com.explorajampa.repository.InterestRepository;
import com.explorajampa.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Component
public class DataLoader implements CommandLineRunner {

    @Autowired
    RoleRepository roleRepository;

    @Autowired
    InterestRepository interestRepository;

    @Override
    public void run(String... args) throws Exception {
        if (roleRepository.findByName(ERole.ROLE_USER).isEmpty()) {
            roleRepository.save(new Role(ERole.ROLE_USER));
        }
        if (roleRepository.findByName(ERole.ROLE_ADMIN).isEmpty()) {
            roleRepository.save(new Role(ERole.ROLE_ADMIN));
        }

        List<String> interests = Arrays.asList("Praias", "Cultura", "Gastronomia", "Ecoturismo", "Aventura", "Relaxar");
        for (String interestName : interests) {
            if (interestRepository.findByName(interestName).isEmpty()) {
                interestRepository.save(new Interest(interestName));
            }
        }
    }
}
