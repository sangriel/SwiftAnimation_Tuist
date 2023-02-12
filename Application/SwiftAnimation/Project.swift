//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by sangmin han on 2023/02/12.
//

import ProjectDescription
import ProjectDescriptionHelpers

let APPDependency : [TargetDependency] = [
    .project(target: "SpinningLoading",
             path: .relativeToRoot("Features/SpinningLoading")),
    .project(target: "SpiralLoading",
             path: .relativeToRoot("Features/SpiralLoading")),
    .project(target: "CardTransition",
             path: .relativeToRoot("Features/CardTransition")),
    .project(target: "OverLappingCollectionView",
             path: .relativeToRoot("Features/OverLappingCollectionView"))
  ]


let project = Project.makeApp(name: "SwiftAnimation",
                              dependencies: APPDependency,
                              resources: ["Resources/**"],
                              infoPlist: .sceneDefault(with: [:]))

