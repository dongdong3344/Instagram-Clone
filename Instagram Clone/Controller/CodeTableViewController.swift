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
    var mobileCodesWithSections = [[MobileCode]]()
    var sectionTitles = [String]()

    let collation = UILocalizedIndexedCollation.current()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mobileCodes = MobileCodeFetcher.getMobileCodes()
        
        let (arrayMobileCodes, arrayTitles) = collation.partitionObjects(array: mobileCodes, collationStringSelector: #selector(getter: MobileCode.name))
        mobileCodesWithSections = arrayMobileCodes as![[MobileCode]]
        sectionTitles = arrayTitles
    }

    @IBAction func cancelClick(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return collation.sectionTitles[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mobileCodesWithSections[section].count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let mobileCode = mobileCodesWithSections[indexPath.section][indexPath.row]
        cell.textLabel?.text = mobileCode.name
        
        let dialCodeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 24))
        dialCodeLabel.textAlignment = .right
        dialCodeLabel.textColor = UIColor.lightGray
        dialCodeLabel.font = UIFont.systemFont(ofSize: 15)
        dialCodeLabel.text = mobileCode.dialCode
        cell.accessoryView = dialCodeLabel
        return cell
    }
   

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = mobileCodes[indexPath.row].code + " " + mobileCodes[indexPath.row].dialCode
        UserDefaults.standard.set(title, forKey: "CodeButtonTitle")
        UserDefaults.standard.synchronize()
        
        dismiss(animated: true, completion: nil)
        
    }

}

extension UILocalizedIndexedCollation{
    func partitionObjects(array:[AnyObject], collationStringSelector:Selector) -> ([AnyObject], [String]) {
    var unsortedSections = [[AnyObject]]()
    //1. Create a array to hold the data for each section
    for _ in self.sectionTitles {
        unsortedSections.append([]) //appending an empty array
    }
    //2. Put each objects into a section
    for item in array {
        let index:Int = self.section(for: item, collationStringSelector:collationStringSelector)
        unsortedSections[index].append(item)
    }
    //3. sorting the array of each sections
    var sectionTitles = [String]()
    var sections = [AnyObject]()
    for index in 0 ..< unsortedSections.count { if unsortedSections[index].count > 0 {
        sectionTitles.append(self.sectionTitles[index])
        sections.append(self.sortedArray(from: unsortedSections[index], collationStringSelector: collationStringSelector) as AnyObject)
        }
    }
    return (sections, sectionTitles)
}
}
