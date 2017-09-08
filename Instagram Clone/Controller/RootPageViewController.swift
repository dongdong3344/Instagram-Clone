//
//  RootPageViewController.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/8.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit

class RootPageViewController: UIPageViewController,UIPageViewControllerDataSource {
    
    
    lazy var controllers:[UIViewController] = {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let cameraVC = storyboard.instantiateViewController(withIdentifier: "CameraViewController")
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        let messageVC = storyboard.instantiateViewController(withIdentifier: "MessageViewController")
        
        return [cameraVC,homeVC,messageVC]
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
       
       setViewControllers([controllers[1]], direction: .reverse, animated: false, completion: nil)
       
        
    }
   
    
    func indexForViewController(controller:UIViewController) -> Int {
        
        return controllers.index(of: controller)!
        
    }
   
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        
        let index = indexForViewController(controller:viewController )
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        return controllers[index - 1]
    }
    
   
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        
        let index = indexForViewController(controller:viewController )
        if (index == controllers.count - 1 || index == NSNotFound) {
            return nil
        }
        return controllers[index + 1]
        
    }
    

}
