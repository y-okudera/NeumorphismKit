//
//  OtherViewController.swift
//  Demo
//
//  Created by okudera on 2020/10/15.
//  Copyright © 2020 yuoku. All rights reserved.
//

import NeumorphismKit
import UIKit

class OtherViewController: UIViewController {

    private var text: String?
    @IBOutlet weak var label: NeumorphismLabel!

    class func instantiate(text: String) -> OtherViewController {
        let storyboard = UIStoryboard(name: "OtherViewController", bundle: nil)
        if #available(iOS 13.0, *) {
            let vc = storyboard.instantiateViewController(identifier: "OtherViewController") as! OtherViewController
            vc.text = text
            return vc
        } else {
            let vc = storyboard.instantiateViewController(withIdentifier: "OtherViewController") as! OtherViewController
            vc.text = text
            return vc
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = self.text
    }
}
