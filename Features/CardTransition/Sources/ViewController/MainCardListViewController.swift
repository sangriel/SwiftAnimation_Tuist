//
//  MainCardListViewController.swift
//  Animation
//
//  Created by sangmin han on 2023/01/31.
//

import Foundation
import UIKit
import CommonUI


class MainCardListViewController : UIViewController {
    
    
    
    
    let dataSource : [CardViewModel] = [.init(title: "first Cell", image:
                                                CommonUIAsset.backgroundImage1.image),
                                        .init(title: "second Cell", image:
                                                CommonUIAsset.backgroundImage2.image),
                                        .init(title: "Third Cell", image:
                                                CommonUIAsset.backgroundImage3.image),
                                        .init(title: "Fourth Cell",
                                              image: CommonUIAsset.backgroundImage4.image)]
    lazy private var tableView : UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.delegate = self
        tb.dataSource = self
        tb.register(MainCardListCell.self, forCellReuseIdentifier: MainCardListCell.cellId)
        tb.separatorStyle = .none
        return tb
    }()
    
    private let transitionManager = CardTransitionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        maketableView()
        
    }
    
    
    
}
extension MainCardListViewController {
    private func maketableView(){
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.backgroundColor = .white
    }
}
extension MainCardListViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainCardListCell.cellId, for: indexPath) as! MainCardListCell
        cell.cardView.setViewModel(viewModel: dataSource[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cardViewModel = dataSource[indexPath.row]
        cardViewModel.currentType = .detail
        let detailView = CardDetailViewController(cardViewModel: cardViewModel)
        detailView.modalPresentationStyle = .overCurrentContext
        detailView.transitioningDelegate = transitionManager
        self.present(detailView, animated: true,completion: nil)
        
        CFRunLoopWakeUp(CFRunLoopGetCurrent())
    }
    
    func selectedCardView() -> CardView? {
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
        let cell = tableView.cellForRow(at: indexPath) as! MainCardListCell
        
        return cell.cardView
        
        
    }
}
