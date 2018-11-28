//
//  RepresentativeViewController.swift
//  Contact the US Government
//
//  Created by Chengji Liu on 11/27/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit

class RepresentativeViewController: UIViewController {

    var representative: Representative!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = representative.name
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
