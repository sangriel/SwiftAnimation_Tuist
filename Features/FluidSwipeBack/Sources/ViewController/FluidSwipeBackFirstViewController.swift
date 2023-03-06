//
//  FluidSwipeBackFirstViewController.swift
//  FluidSwipeBack
//
//  Created by sangmin han on 2023/03/06.
//  Copyright © 2023 HSMProducts. All rights reserved.
//

import Foundation
import UIKit
import CommonUI



class FluidSwipeBackFirstViewController : UIViewController {
    
    
    let dataSource = [CommonUIAsset.backgroundImage1.image,
                      CommonUIAsset.backgroundImage2.image,
                      CommonUIAsset.backgroundImage3.image,
                      CommonUIAsset.backgroundImage4.image]
    
    lazy private var tb : UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    
    let fluidSwipeBackTransition = FluidSwipeBackTransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "FluidSwipeBackAnimation"
        makeTb()
        self.navigationController?.delegate = fluidSwipeBackTransition
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
}
extension FluidSwipeBackFirstViewController {
    private func makeTb(){
        self.view.addSubview(tb)
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tb.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        tb.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        tb.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        tb.backgroundColor = .white
    }
}
extension FluidSwipeBackFirstViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "CELLID")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "CELLID")
        }
        
        var backgroundContent = UIBackgroundConfiguration.listPlainCell()
        backgroundContent.backgroundColor = .white
        backgroundContent.backgroundInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        backgroundContent.image = dataSource[indexPath.row % 4]
        backgroundContent.imageContentMode = .scaleAspectFill
        backgroundContent.cornerRadius = 15
        
        cell!.backgroundConfiguration = backgroundContent
    
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FluidSwipeBackSecondViewController(image: dataSource[(indexPath.row + 1) % 4])
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
