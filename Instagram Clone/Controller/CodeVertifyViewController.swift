//
//  CodeVertifyViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/15.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit


class CodeVertifyViewController: UIViewController {
    
    @IBOutlet weak var requestNewCodeButton: UIButton!
    @IBOutlet weak var tagLabel: UILabel!
    
    var timeOut: Int = 60
    var timer: DispatchSourceTimer?
    

    
    @IBAction func requestNewCode(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        timerCountDown()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if timer != nil {
            timer?.cancel()
            timer = nil
        }
    }
    
    @IBAction func nextButtonClick(_ sender: UIButton) {
        
     
        
    }
    
    func timerCountDown(){
        
        let queue = DispatchQueue(label: "com.omni.timer", qos: .background, attributes: .concurrent)
        
        timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        
        // 每秒执行
        timer?.scheduleRepeating(deadline: .now(),interval: .seconds(1))
        
        timer?.setEventHandler() { [unowned self] in
            
           self.timeOut = self.timeOut - 1
            
            if self.timeOut <= 0  {
                // 倒计时结束
                self.timer?.cancel()
                self.timer = nil
                
                DispatchQueue.main.async {
                    let title = "重新请求验证码。"
                    self.requestNewCodeButton.setTitle(title, for: .normal)
                }
            }else{
                
                DispatchQueue.main.async {
                    let title = "\(self.timeOut)秒后重新获取验证码。"
                    self.requestNewCodeButton.setTitle(title, for: .normal)
                }
                
            }
        }
        timer?.resume() //定时器继续
        
 
    }
    
}
