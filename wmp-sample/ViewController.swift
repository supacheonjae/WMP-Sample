//
//  ViewController.swift
//  wmp-sample
//
//  Created by Yun Ha on 2020/10/17.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private lazy var appStoreViewModel: AppStoreViewModel = {
        let termObservable = searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
        
        return AppStoreViewModel(termObservable: termObservable)
    }()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindTableViewItems()
        bindTableViewSelected()
        bindEtc()
    }

    private func bindTableViewItems() {
        appStoreViewModel.rx_appInfos
            .drive(tableView.rx.items(cellIdentifier: "AppInfoCell", cellType: AppInfoCell.self))
            { (row, appInfo, cell) in
                
                cell.nameLabel.text = appInfo.trackName
                cell.sellerNameLabel.text = appInfo.sellerName
                cell.ratingLabel.text = appInfo.ratingDescription
                
                cell.iconImageView.setImage(from: appInfo.artworkUrl100)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindTableViewSelected() {
        func openLinkUrl(string url: String) {
            guard let url = URL(string: url),
                UIApplication.shared.canOpenURL(url)
                else { return }
                
            UIApplication.shared.open(url)
        }
        
        Observable
            .zip(tableView.rx.itemSelected,
                 tableView.rx.modelSelected(AppInfo.self))
            .subscribe(onNext: { [unowned self] indexPath, appInfo in
                self.tableView.deselectRow(at: indexPath, animated: false)
                
                openLinkUrl(string: appInfo.trackViewUrl)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindEtc() {
        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] _ in
                self?.searchBar.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        // "검색 결과 없음" 화면
        appStoreViewModel.rx_appInfos
            .map { $0.count > 0 }
            .drive(emptyView.rx.isHidden)
            .disposed(by: disposeBag)
    }
}

