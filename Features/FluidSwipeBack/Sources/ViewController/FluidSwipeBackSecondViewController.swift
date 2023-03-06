//
//  FluidSwipeBackSecondViewController.swift
//  FluidSwipeBack
//
//  Created by sangmin han on 2023/03/06.
//  Copyright © 2023 HSMProducts. All rights reserved.
//

import Foundation
import UIKit


class FluidSwipeBackSecondViewController : UIViewController {
    
    private let imageView = UIImageView()
    
    private let backBtn = UIButton()
    
    init(image : UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        makeImageView()
        makebackBtn()
        backBtn.addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
    }
    
    @objc func backBtnTapped(sender : UIButton){
        print("trying to pop")
        self.navigationController?.popViewController(animated: true)
    }
}
extension FluidSwipeBackSecondViewController {
    private func makeImageView(){
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    private func makebackBtn(){
        self.view.addSubview(backBtn)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        backBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backBtn.backgroundColor = .black
        backBtn.setTitle("BACK", for: .normal)
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        backBtn.layer.cornerRadius = 15
        
    }
}
