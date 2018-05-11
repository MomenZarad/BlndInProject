//
//  CreatePostViewController.swift
//  blndIn
//
//  Created by Zyad Galal on 4/19/18.
//  Copyright © 2018 Zyad Galal. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {

    @IBAction func CancelBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //label in the navigation bar
        if let navigationBar = self.navigationController?.navigationBar {
            
            let secondFrame = CGRect(x: (navigationBar.frame.width/2)-30, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
            let secondLabel = UILabel(frame: secondFrame)
            secondLabel.text = "Create Post"
            
            navigationBar.addSubview(secondLabel)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
