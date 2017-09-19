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
    
    var timeCount: Int = 60
    var timer: DispatchSourceTimer?
    

    
    @IBAction func requestNewCode(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let phone = UserDefaults.standard.getPhoneNumber()
        tagLabel.text = "请输入我们发送到\(phone!)的验证码。"
        timerCountDown()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if timer != nil {
            timer?.cancel()
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
            
           self.timeCount = self.timeCount - 1
            
            if self.timeCount <= 0  {
                // 倒计时结束
                self.timer?.cancel()
  
                DispatchQueue.main.async {
                    let title = "重新请求验证码。"
                    self.requestNewCodeButton.setTitle(title, for: .normal)
                    self.requestNewCodeButton.setTitleColor(UIColor.blue, for: .normal)
                    self.requestNewCodeButton.isUserInteractionEnabled = true
                }
            }else{
                
                DispatchQueue.main.async {
                    let title = "\(self.timeCount)秒后重新获取验证码。"
                    self.requestNewCodeButton.setTitle(title, for: .normal)
                    self.requestNewCodeButton.setTitleColor(UIColor(red: 135/255, green: 200/255, blue: 250/200, alpha: 1), for: .normal)
                    self.requestNewCodeButton.isUserInteractionEnabled = false
                }
                
            }
        }
        timer?.resume() //定时器继续
     
    }
    
    
}
