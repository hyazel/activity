//
//  MotionData.swift
//  CoreActivity
//
//  Created by laurent.droguet on 15/07/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation
import CoreMotion

public struct MotionData {
    var accelerationX: Double
    var accelerationY: Double
    var accelerationZ: Double
    var rotationX: Double
    var rotationY: Double
    var rotationZ: Double
}

extension MotionData {
    init(motion: CMDeviceMotion) {
        accelerationX = motion.userAcceleration.x
        accelerationY = motion.userAcceleration.y
        accelerationZ = motion.userAcceleration.z
        rotationX = motion.rotationRate.x
        rotationY = motion.rotationRate.y
        rotationZ = motion.rotationRate.z
    }
}
