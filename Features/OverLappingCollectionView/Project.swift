//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by sangmin han on 2023/02/12.
//

import ProjectDescription
import ProjectDescriptionHelpers


let deployTarget = Target(name: "OverLappingCollectionView",
                          platform: .iOS,
                          product: .staticFramework,
                          bundleId: ENV.bundleId + ".OverLappingCollectionView",
                          deploymentTarget: ENV.deployTarget,
                          infoPlist: .extendingDefault(with: [:]),
                          sources: ["Sources/**"],
                          resources: nil,
                          dependencies: [
                            .project(target: "CommonUI",
                                     path: .relativeToRoot("Modules/CommonUI"))
                          ])

let project = Project.makeModule(name: "OverLappingCollectionView",
                                 targets: [deployTarget])

