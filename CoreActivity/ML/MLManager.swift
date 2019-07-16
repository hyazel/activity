//
//  MLManager.swift
//  Activity
//
//  Created by laurent.droguet on 15/07/2019.
//  Copyright © 2019 laurent.droguet. All rights reserved.
//

import Foundation
import CoreML

public final class MLManager {

    struct Constants {
        static let numOfFeatures: Int = 6
        static let predictionWindowSize = 30
        static let sensorsUpdateInterval = 1.0 / 30.0
        static let hiddenInLength = 200
        static let hiddenCellInLength = 200
        static let textErrorClassification = "N/A"
    }

    private let activityModel = MyActivityClassifier()
    private var currentIndexInPredictionWindow: Int

    private let predictionWindowDataArray = try? MLMultiArray(shape: [1,
                                                              NSNumber(value: Constants.predictionWindowSize),
                                                              NSNumber(value: Constants.numOfFeatures)],
                                                      dataType: MLMultiArrayDataType.double)
    private var lastHiddenOutput = try? MLMultiArray(shape:[Constants.hiddenInLength as NSNumber],
                                             dataType: MLMultiArrayDataType.double)
    private var lastHiddenCellOutput = try? MLMultiArray(shape:[Constants.hiddenCellInLength as NSNumber],
                                                 dataType: MLMultiArrayDataType.double)

    public init() {
        currentIndexInPredictionWindow = 0
    }

    public func handleMotionDataAndPredict(motionData: MotionData, classification: (String) -> Void) {
        guard let dataArray = predictionWindowDataArray else { return }

        dataArray[[0, currentIndexInPredictionWindow, 0] as [NSNumber]] = motionData.rotationX as NSNumber
        dataArray[[0, currentIndexInPredictionWindow, 1] as [NSNumber]] = motionData.rotationY as NSNumber
        dataArray[[0, currentIndexInPredictionWindow, 2] as [NSNumber]] = motionData.rotationZ as NSNumber

        dataArray[[0, currentIndexInPredictionWindow, 3] as [NSNumber]] = motionData.accelerationX as NSNumber
        dataArray[[0, currentIndexInPredictionWindow, 4] as [NSNumber]] = motionData.accelerationY as NSNumber
        dataArray[[0, currentIndexInPredictionWindow, 5] as [NSNumber]] = motionData.accelerationZ as NSNumber

        currentIndexInPredictionWindow += 1

        if (currentIndexInPredictionWindow == Constants.predictionWindowSize) {
            currentIndexInPredictionWindow = 0
            classification(performPrediction())
        }
    }

    public func performPrediction() -> String {
        guard let dataArray = predictionWindowDataArray else { return "Error"}

        let modelPrediction = try? activityModel.prediction(features: dataArray,
                                                            hiddenIn: lastHiddenOutput,
                                                            cellIn: lastHiddenCellOutput)

        lastHiddenOutput = modelPrediction?.hiddenOut
        lastHiddenCellOutput = modelPrediction?.cellOut

        return modelPrediction?.activity ?? Constants.textErrorClassification
    }
}
