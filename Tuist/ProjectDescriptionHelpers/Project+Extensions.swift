//
//  Project+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by sangmin han on 2023/02/13.
//

import Foundation
import ProjectDescription

public enum ENV {
    public static var GENTYPE : String { return ProcessInfo.processInfo.environment["TUIST_GENTYPE"] ?? "" }
    public static var bundleId : String { return "com.app" }
    public static var deployTarget : DeploymentTarget { return .iOS(targetVersion: "15.0", devices: .iphone)}
}
