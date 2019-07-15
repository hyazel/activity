//
//  MotionManager.swift
//  Activity
//
//  Created by laurent.droguet on 15/07/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation


public protocol MotionManageable {
    func getData(to: OperationQueue, withHandler: @escaping (MotionData?, Error?) -> Void)
}

public final class MotionManager {
    static let shared = MotionManager()

    struct Constants {
        static let sensorsUpdateInterval = 1.0 / 30.0
    }

    public let manager: MotionManageable = CMMotionEngine(sensorsUpdateInterval: Constants.sensorsUpdateInterval)
    
    public init() {}

    public func getMotionData(result: @escaping (MotionData)->()) {
        manager.getData(to: .main) { (data, error) in
            guard let data = data, error == nil else { return }

            result(data)
        }
    }
}


