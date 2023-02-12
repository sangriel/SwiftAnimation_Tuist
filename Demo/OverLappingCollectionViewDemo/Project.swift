//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by sangmin han on 2023/02/12.
//


import ProjectDescription
import ProjectDescriptionHelpers

let demoTarget = Target(name: "OverLappingCollectionViewDemo",
                        platform: .iOS,
                        product: .app,
                        bundleId: ENV.bundleId + ".OverLappingCollectionView.Demo",
                        deploymentTarget: ENV.deployTarget,
                        infoPlist: .sceneDefault(with: [:]),
                        sources: ["Sources/**"],
                        resources: nil,
                        dependencies: [
                            .project(target: "OverLappingCollectionView", path: .relativeToRoot("Features/OverLappingCollectionView")),
                            .project(target: "CommonUI",
                                     path: .relativeToRoot("Modules/CommonUI"))
                        ])



let project = Project.makeModule(name: "OverLappingCollectionViewDemo",
                                 targets: [demoTarget])
