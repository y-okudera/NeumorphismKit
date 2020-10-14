//
//  MainViewController.swift
//  Demo
//
//  Created by okudera on 2020/08/18.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit
import NeumorphismKit

class MainViewController: UIViewController {

    private var timer = Timer()

    @IBOutlet weak var purpleProgressView: NeumorphismProgressView!
    @IBOutlet weak var greenProgressView: NeumorphismProgressView!

    class func instantiate() -> MainViewController {
        let storyboard = UIStoryboard(name: "MainViewController", bundle: nil)
        if #available(iOS 13.0, *) {
            return storyboard.instantiateViewController(identifier: "MainViewController") as! MainViewController
        } else {
            return storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.greenProgressView.setProgress(0.0)
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(didProgresse), userInfo: nil, repeats: true)
    }

    @objc private func didProgresse() {
        self.purpleProgressView.decrementProgress(0.05)
        if self.purpleProgressView.progress <= 0.0 {
            self.purpleProgressView.setProgress(1.0)
        }

        self.greenProgressView.incrementProgress(0.05)
        if self.greenProgressView.progress >= 1.0 {
            self.greenProgressView.setProgress(0.0)
        }
    }
}
