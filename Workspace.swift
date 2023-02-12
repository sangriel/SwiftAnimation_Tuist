
import ProjectDescription
import ProjectDescriptionHelpers
import Foundation



let workspace = Workspace(
    name: "SwiftAnimation",
    projects: [
        "Modules/CommonUI",
        "Features/**",
        "Application/SwiftAnimation"
    ] + (ENV.GENTYPE == "APP" ? [] : ["Demo/**"])
)
