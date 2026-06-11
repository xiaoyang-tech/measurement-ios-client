//
//  Segment.swift
//  MeasurementSDK
//
//  Created by DCK on 2025/12/5.
//  Copyright © 2025 CocoaPods. All rights reserved.
//
import SwiftUI


struct Segment: Identifiable {
    let id = UUID()
    let start: Double
    let end: Double
    let color: Color
}
