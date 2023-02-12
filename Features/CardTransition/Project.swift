//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by sangmin han on 2023/02/12.
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers


let deployTarget = Target(name: "CardTransition",
                          platform: .iOS,
                          product: .staticFramework,
                          bundleId: ENV.bundleId + ".CardTransition",
                          deploymentTarget: ENV.deployTarget,
                          infoPlist: .extendingDefault(with: [:]),
                          sources: ["Sources/**"],
                          resources: nil,
                          dependencies: [
                            .project(target: "CommonUI",
                                     path: .relativeToRoot("Modules/CommonUI"))
                          ])

let project = Project.makeModule(name: "CardTransition",
                                 targets: [deployTarget])

