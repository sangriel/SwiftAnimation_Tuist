//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by sangmin han on 2023/02/12.
//


import ProjectDescription
import ProjectDescriptionHelpers

let demoTarget = Target(name: "SpiralLoadingDemo",
                        platform: .iOS,
                        product: .app,
                        bundleId: ENV.bundleId + ".SpiralLoading.Demo",
                        deploymentTarget: ENV.deployTarget,
                        infoPlist: .sceneDefault(with: [:]),
                        sources: ["Sources/**"],
                        resources: nil,
                        dependencies: [
                            .project(target: "SpiralLoading", path: .relativeToRoot("Features/SpiralLoading"))
                        ])



let project = Project.makeModule(name: "SpiralLoadingDemo",
                                 targets: [demoTarget])
