//
//  Project.swift
//  ProjectDescriptionHelpers
//
//
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers




let deployTarget = Target(name: "CommonUI",
                          platform: .iOS,
                          product: .staticFramework,
                          bundleId: ENV.bundleId + ".CommonUI",
                          deploymentTarget: ENV.deployTarget,
                          infoPlist: .extendingDefault(with: [:]),
                          sources: ["Sources/**"],
                          resources: ["Resources/**"],
                          dependencies: [])

let project = Project.makeModule(name: "CommonUI",
                                 targets: [deployTarget])

