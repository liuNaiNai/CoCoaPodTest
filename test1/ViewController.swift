//
//  ViewController.swift
//  test1
//
//  Created by 刘坤 on 2018/3/20.
//  Copyright © 2018年 HiveOperation. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let  tb = UITableView()
        tb.separatorStyle = .none
        tb.backgroundColor = UIColor.white
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UITableViewCell")
        cell.textLabel?.text = "text =\(indexPath.row)"
        cell.detailTextLabel?.text = "detail text =\(indexPath.row )"
        return cell
    }
}





