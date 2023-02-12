//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by sangmin han on 2023/02/12.
//

import ProjectDescription
import ProjectDescriptionHelpers



let deployTarget = Target(name: "SpiralLoading",
                          platform: .iOS,
                          product: .staticFramework,
                          bundleId: ENV.bundleId + ".SpiralLoading",
                          deploymentTarget: ENV.deployTarget,
                          infoPlist: .extendingDefault(with: [:]),
                          sources: ["Sources/**"],
                          resources: nil,
                          dependencies: [])

let project = Project.makeModule(name: "SpiralLoading",
                                 targets: [deployTarget])
