//
//  ViewController.swift
//  Calck
//
//  Created by Konstantin on 20.06.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let testView: UIView = {
       let myView = UIView()
        myView.backgroundColor = .orange
        myView.translatesAutoresizingMaskIntoConstraints = false
        return myView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().inset(100)
            
        }
    }
    
    

}

