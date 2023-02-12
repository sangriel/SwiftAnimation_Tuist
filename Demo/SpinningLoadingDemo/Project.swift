//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by sangmin han on 2023/02/12.
//


import ProjectDescription
import ProjectDescriptionHelpers

let demoTarget = Target(name: "SpinningLoadingDemo",
                        platform: .iOS,
                        product: .app,
                        bundleId: ENV.bundleId + ".SpinningLoading.Demo",
                        deploymentTarget: ENV.deployTarget,
                        infoPlist: .sceneDefault(with: [:]),
                        sources: ["Sources/**"],
                        resources: nil,
                        dependencies: [
                            .project(target: "SpinningLoading", path: .relativeToRoot("Features/SpinningLoading"))
                        ])



let project = Project.makeModule(name: "SpinningLoadingDemo",
                                 targets: [demoTarget])
