//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by sangmin han on 2023/03/03.
//
import ProjectDescription
import ProjectDescriptionHelpers



let deployTarget = Target(name: "FluidSwipeBack",
                          platform: .iOS,
                          product: .staticFramework,
                          bundleId: ENV.bundleId + ".FluidSwipeBack",
                          deploymentTarget: ENV.deployTarget,
                          infoPlist: .extendingDefault(with: [:]),
                          sources: ["Sources/**"],
                          resources: nil,
                          dependencies: [.project(target: "CommonUI",
                                                  path: .relativeToRoot("Modules/CommonUI"))
                                                  ])
                                         

let project = Project.makeModule(name: "FluidSwipeBack",
                                 targets: [deployTarget])

