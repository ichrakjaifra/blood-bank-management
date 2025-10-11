package com.bloodbank.service;

import com.bloodbank.model.BloodGroup;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class BloodCompatibilityService {

    private static final Map<BloodGroup, List<BloodGroup>> COMPATIBILITY_MAP =
            Map.ofEntries(
                    Map.entry(BloodGroup.O_NEGATIVE, Arrays.asList(
                            BloodGroup.O_NEGATIVE, BloodGroup.O_POSITIVE,
                            BloodGroup.A_NEGATIVE, BloodGroup.A_POSITIVE,
                            BloodGroup.B_NEGATIVE, BloodGroup.B_POSITIVE,
                            BloodGroup.AB_NEGATIVE, BloodGroup.AB_POSITIVE
                    )),
                    Map.entry(BloodGroup.O_POSITIVE, Arrays.asList(
                            BloodGroup.O_POSITIVE, BloodGroup.A_POSITIVE,
                            BloodGroup.B_POSITIVE, BloodGroup.AB_POSITIVE
                    )),
                    Map.entry(BloodGroup.A_NEGATIVE, Arrays.asList(
                            BloodGroup.A_NEGATIVE, BloodGroup.A_POSITIVE,
                            BloodGroup.AB_NEGATIVE, BloodGroup.AB_POSITIVE
                    )),
                    Map.entry(BloodGroup.A_POSITIVE, Arrays.asList(
                            BloodGroup.A_POSITIVE, BloodGroup.AB_POSITIVE
                    )),
                    Map.entry(BloodGroup.B_NEGATIVE, Arrays.asList(
                            BloodGroup.B_NEGATIVE, BloodGroup.B_POSITIVE,
                            BloodGroup.AB_NEGATIVE, BloodGroup.AB_POSITIVE
                    )),
                    Map.entry(BloodGroup.B_POSITIVE, Arrays.asList(
                            BloodGroup.B_POSITIVE, BloodGroup.AB_POSITIVE
                    )),
                    Map.entry(BloodGroup.AB_NEGATIVE, Arrays.asList(
                            BloodGroup.AB_NEGATIVE, BloodGroup.AB_POSITIVE
                    )),
                    Map.entry(BloodGroup.AB_POSITIVE, Arrays.asList(
                            BloodGroup.AB_POSITIVE
                    ))
            );

    public static boolean isCompatible(BloodGroup donorBloodGroup, BloodGroup receiverBloodGroup) {
        List<BloodGroup> compatibleGroups = COMPATIBILITY_MAP.get(donorBloodGroup);
        return compatibleGroups != null && compatibleGroups.contains(receiverBloodGroup);
    }

    public static List<BloodGroup> getCompatibleBloodGroups(BloodGroup receiverBloodGroup) {
        return COMPATIBILITY_MAP.entrySet().stream()
                .filter(entry -> entry.getValue().contains(receiverBloodGroup))
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());
    }
}