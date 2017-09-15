//
//  CodeVertifyViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/15.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit

class CodeVertifyViewController: UIViewController {
    
    var testLabel:UILabel!

    @IBOutlet weak var requstNewCode: UIButton!
    @IBOutlet weak var tagLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        testLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 80, height: 44))
        view.addSubview(testLabel)

    }
}
