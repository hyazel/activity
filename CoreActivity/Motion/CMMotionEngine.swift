//
//  CMMotionEngine.swift
//  CoreActivity
//
//  Created by laurent.droguet on 15/07/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation
import CoreMotion

final class CMMotionEngine: MotionManageable {
    private let manager = CMMotionManager()
    private let sensorsUpdateInterval: TimeInterval

    init(sensorsUpdateInterval: TimeInterval) {
        self.sensorsUpdateInterval = sensorsUpdateInterval
    }

    private func canUseSensors() -> Bool {
        return manager.isAccelerometerAvailable && manager.isGyroAvailable
    }

    func getData(to: OperationQueue, withHandler: @escaping (MotionData?, Error?) -> Void) {
        if canUseSensors(){
            manager.deviceMotionUpdateInterval = sensorsUpdateInterval
            manager.startDeviceMotionUpdates(to: .main) { (data, error) in
                guard let data = data, error == nil else {
                    return
                }
                withHandler(MotionData(motion: data), error)
            }
        }
    }
}
