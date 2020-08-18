//
//  ViewController.swift
//  Demo
//
//  Created by okudera on 2020/08/18.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit
import NeumorphismKit

class ViewController: UIViewController {

    private var timer = Timer()

    @IBOutlet weak var greenProgressView: NeumorphismProgressView!

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
        self.greenProgressView.incrementProgress(0.05)
        if self.greenProgressView.progress >= 1.0 {
            self.greenProgressView.setProgress(0.0)
        }
    }
}
