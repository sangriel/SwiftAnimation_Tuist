//
//  ListViewController.swift
//  SwiftAnimation
//
//  Created by sangmin han on 2023/02/11.
//  Copyright © 2023 HSMProducts. All rights reserved.
//

import Foundation
import UIKit
import CardTransition
import OverLappingCollectionView
import SpinningLoading
import SpiralLoading


class ListViewController : UIViewController {
    
    let data : [String] = ["SpinningloadingAnimation","SpiralLoadingAnimation","CardTransitionAnimation","OverLappingCollectionView"]
    
    lazy var tableView : UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.delegate = self
        tb.dataSource = self
        tb.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellId)
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Animations"
        
        setupView()
    }
    
    private func setupView(){
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    
    
    
}
extension ListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId, for: indexPath) as! MainTableViewCell
        var content = cell.defaultContentConfiguration()
        content.text = data[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(SpinningLoadingResolver.getSpinningLoadingView(), animated: true)
        }
        else if indexPath.row == 1 {
            self.navigationController?.pushViewController(SpiralLoadingResolver.getSpiralLoading(), animated: true)
        }
        else if indexPath.row == 2 {
            self.navigationController?.pushViewController(CardTransitionResolver.getCardTransitionView(), animated: true)
        }
        else if indexPath.row == 3 {
            self.navigationController?.pushViewController(OverLappingCollectionViewResolver.getOverLappingCollectionView(), animated: true)
        }
    }
    
    
    
    
}
