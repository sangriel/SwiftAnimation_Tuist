import ProjectDescription
import ProjectDescriptionHelpers

public extension Project {
    static func makeModule(
        name: String,
        organizationName: String = "HSMProducts",
        packages: [Package] = [],
        targets : [Target]
    ) -> Project {
        let settings: Settings = .settings(
            base: [:],
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ], defaultSettings: .recommended)
        
        var schemeTargetName : String = name
        if let target = targets.first {
            schemeTargetName = target.name
        }
        var schemes : [Scheme] = [.makeScheme(target: .debug, name: schemeTargetName),
                                 .makeScheme(target: .release, name: schemeTargetName)]
        
        
        
        var targets: [Target] = targets
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
    
    static func makeApp(
        name: String,
        platform: Platform = .iOS,
        organizationName: String = "HSMProducts",
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "15.0", devices: [.iphone]),
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default
    ) -> Project {
        let settings: Settings = .settings(
            base: [:],
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ], defaultSettings: .recommended)
        
        let appTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "\(organizationName).\(name)",
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            dependencies: dependencies
        )
        
        let schemes: [Scheme] = [.makeScheme(target: .debug, name: name),
                                 .makeScheme(target: .release, name: name)]
        
        let targets: [Target] = [appTarget]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }

}

extension Scheme {
    static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)"],
                configuration: target,
                options: .options(coverage: true,
                                  codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
    
}

public extension InfoPlist {
    static  func sceneDefault(with : [String : Value]) -> InfoPlist {
        var infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UILaunchStoryboardName": "LaunchScreen",
            "UISupportedInterfaceOrientations" : ["UIInterfaceOrientationPortrait"],
            "UIUserInterfaceStyle":"Light",
            "UIApplicationSceneManifest" : [
                "UIApplicationSupportsMultipleScenes":true,
                "UISceneConfigurations":[
                    "UIWindowSceneSessionRoleApplication":[
                        ["UISceneConfigurationName":"Default Configuration",
                         "UISceneDelegateClassName":"$(PRODUCT_MODULE_NAME).SceneDelegate"]
                    ]
                ]
            ]
        ]
        
        
        for (key,value) in with {
            infoPlist[key] = value
        }
        return .extendingDefault(with: infoPlist)
    }
    
}

