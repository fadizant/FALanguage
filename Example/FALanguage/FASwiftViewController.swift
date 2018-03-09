//
//  FASwiftViewController.swift
//  FALanguage_Example
//
//  Created by Fadi Abuzant on 3/10/18.
//  Copyright © 2018 fadizant. All rights reserved.
//

import UIKit
import FALanguage

class FASwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier {
            if identifier == "english" {
                Bundle.setLanguage("en")
            }else {
                Bundle.setLanguage("ar")
            }
            
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = self.storyboard?.instantiateInitialViewController()
            appDelegate?.window??.makeKeyAndVisible()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                if let nav = appDelegate?.window??.rootViewController as? UINavigationController {
                    nav.pushViewController((self.storyboard?.instantiateViewController(withIdentifier: segue.destination.restorationIdentifier!))!, animated: true)
                }
            })
        }
    }
    

}
