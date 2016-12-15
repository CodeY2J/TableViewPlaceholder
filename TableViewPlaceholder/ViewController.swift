//
//  ViewController.swift
//  TableViewPlaceholder
//
//  Created by Limingkai on 16/12/15.
//  Copyright © 2016年 ctbri. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var count : NSInteger = 0
    fileprivate var errorType = ErrorType.NoData
    
    private struct ErrorType {
        static let NoData = 1
        static let NoNetWork = 2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let nodataPlaceholder = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        nodataPlaceholder.backgroundColor = UIColor.gray
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.text = "暂时没有数据,请稍后再试"
        label.sizeToFit()
        label.center = view.center
        nodataPlaceholder.addSubview(label)
        
        let nonetworkPlaceholder = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        nonetworkPlaceholder.backgroundColor = UIColor.red
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label1.text = "暂时没有网络,请稍后再试"
        label1.sizeToFit()
        label1.center = view.center
        nonetworkPlaceholder.addSubview(label1)
    
        tableView.placeholder = {[weak self] _ in
            if let _self = self {
                switch _self.errorType {
                case ErrorType.NoData:
                    return nodataPlaceholder
                case ErrorType.NoNetWork:
                    return nonetworkPlaceholder
                default:
                    return UIView()
                }
            }
            return UIView()
        }

        tableView.tableFooterView = UIView()
        tableView.lmk_reloadData()
    }
    @IBAction func noNetworkButtonPressed(_ sender: Any) {
        errorType = ErrorType.NoNetWork
        count = 0
        tableView.lmk_reloadData()
    }
    @IBAction func haveDataPressed(_ sender: Any) {
        count = 10
        tableView.lmk_reloadData()
    }
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "hello"
        return cell!
    }
}

