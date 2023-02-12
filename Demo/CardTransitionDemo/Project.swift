//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by sangmin han on 2023/02/12.
//


import ProjectDescription
import ProjectDescriptionHelpers


let demoTarget = Target(name: "CardTransitionDemo",
                        platform: .iOS,
                        product: .app,
                        bundleId: ENV.bundleId + ".CardTransition.Demo",
                        deploymentTarget: ENV.deployTarget,
                        infoPlist: .sceneDefault(with: [:]),
                        sources: ["Sources/**"],
                        resources: nil,
                        dependencies: [
                            .project(target: "CardTransition", path: .relativeToRoot("Features/CardTransition")),
                            .project(target: "CommonUI",
                                     path: .relativeToRoot("Modules/CommonUI"))
                        ])



let project = Project.makeModule(name: "CardTransitionDemo",
                                 targets: [demoTarget])
