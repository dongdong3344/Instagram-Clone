//
//  CodeTableViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/5.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit

class CodeTableViewController: UITableViewController {
    
    var mobileCodes = [MobileCode]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        mobileCodes = MobileCodeFetcher.getMobileCodes()
   
    }

    @IBAction func cancelClick(_ sender: UIBarButtonItem) {
        
         dismiss(animated: true) {
            
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return mobileCodes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = mobileCodes[indexPath.row].name
        
       
        let dialCodeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 24))
        dialCodeLabel.textAlignment = .right
        dialCodeLabel.textColor = UIColor.lightGray
        dialCodeLabel.font = UIFont.systemFont(ofSize: 15)
        dialCodeLabel.text = mobileCodes[indexPath.row].dialCode
        cell.accessoryView = dialCodeLabel

        return cell
    }
   

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
 
   


}
