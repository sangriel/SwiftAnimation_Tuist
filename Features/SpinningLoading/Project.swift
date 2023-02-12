//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by sangmin han on 2023/02/12.
//

import ProjectDescription
import ProjectDescriptionHelpers


let deployTarget = Target(name: "SpinningLoading",
                          platform: .iOS,
                          product: .staticFramework,
                          bundleId: ENV.bundleId + ".SpinningLoading",
                          deploymentTarget: ENV.deployTarget,
                          infoPlist: .extendingDefault(with: [:]),
                          sources: ["Sources/**"],
                          resources: nil,
                          dependencies: [])

let project = Project.makeModule(name: "SpinningLoading",
                                 targets: [deployTarget])
