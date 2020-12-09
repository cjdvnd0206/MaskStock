//
//  MainListView.swift
//  MaskStock
//
//  Created by 윤병진 on 2020/05/31.
//  Copyright © 2020 darkKnight. All rights reserved.
//

import UIKit

class MainListView: UIView {
    
    public let searchView = MainSearchView()
    public let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        tableViewAttributes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableViewConstraintsCondition()
        searchViewConstraintsCondition()
    }
    
    private func addView() {
        addSubview(tableView)
        addSubview(searchView)
    }
    
    private func tableViewAttributes() {
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = true
        tableView.tableFooterView = UIView()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .pmsBackgroundColor
    }

    private func tableViewConstraintsCondition() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(10)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    private func searchViewConstraintsCondition() {
        searchView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(30)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(130)
        }
    }
}
