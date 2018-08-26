//
//  First.swift
//  VirtualAssistantforiOSSideProject
//
//  Created by Omar Yahya Alfawzan on 8/7/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import UIKit

class First: UIViewController {
    @IBOutlet weak var gifimageview: UIImageView!
    
    @IBOutlet weak var load: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
self.view.backgroundColor = UIColor(patternImage: UIImage(named: "food1")!)
       
       gifimageview.image = UIImage.gif(name: "logo")

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) {
            self.load.isHidden = true
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
