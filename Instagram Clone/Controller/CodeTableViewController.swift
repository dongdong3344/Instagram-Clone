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

        MobileCode.getMobileCodes { (mobileCodes) in
            self.mobileCodes = mobileCodes
            
          
        }
    }

    @IBAction func cancelClick(_ sender: UIBarButtonItem) {
        
         dismiss(animated: true) {
            
        }
    }
    
    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return mobileCodes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = mobileCodes[indexPath.row].name


        return cell
    }
   

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
 
   


}
