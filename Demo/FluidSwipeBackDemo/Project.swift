//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by sangmin han on 2023/03/03.
//

import ProjectDescription
import ProjectDescriptionHelpers

let demoTarget = Target(name: "FluidSwipeBackDemo",
                        platform: .iOS,
                        product: .app,
                        bundleId: ENV.bundleId + ".FluidSwipeBack.Demo",
                        deploymentTarget: ENV.deployTarget,
                        infoPlist: .sceneDefault(with: [:]),
                        sources: ["Sources/**"],
                        resources: nil,
                        dependencies: [
                            .project(target: "FluidSwipeBack", path: .relativeToRoot("Features/FluidSwipeBack"))
                        ])



let project = Project.makeModule(name: "FluidSwipeBackDemo",
                                 targets: [demoTarget])
