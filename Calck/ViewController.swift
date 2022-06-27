//
//  ViewController.swift
//  Calck
//
//  Created by Konstantin on 20.06.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var mainStackView = UIStackView(views: [], axis: .vertical, spacing: 2)
    
    private let displayView: UIView = {
       let myView = UIView()
        myView.backgroundColor = .dispalayColor
        myView.translatesAutoresizingMaskIntoConstraints = false
        return myView
    }()
    
    private let displayLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 50, weight: .thin)
        label.textColor = .baseButtonColor
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func createButton(text: String, color: UIColor) -> UIButton {
        let myButton = UIButton(text: text, color: color)
        if Int(text) != nil || text == "." {
            myButton.addTarget(self, action: #selector(returnActionNum), for: .touchUpInside)
        } else {
            myButton.addTarget(self, action: #selector(returnActionCalc), for: .touchUpInside)
        }
        return myButton
    }
    
    private func createStackView(count: Int, textSubView: [String]) -> UIStackView {
        
        let myStackView = UIStackView(views: [], axis: .horizontal, spacing: 2)
        let ac = ["AC", "+/-", "%", "÷"]
        
        for i in 0...count - 1 {
            var color = (i == count - 1) ? UIColor.buttonOrangeColor : UIColor.buttonBlueColor
            if ac.contains(textSubView[i]) {
                color = .buttonDarkColor
            }
            myStackView.addArrangedSubview(createButton(text: textSubView[i], color: color))
        }
        
        return myStackView
    }
    
    @objc private func returnActionCalc(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else { return }
        print("Tap \(text)")
        
    }
    
    @objc private func returnActionNum(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else { return }
        print("Tap \(text)")
        
    }
    
    private var calcButtonPressed = UIAction(handler: { action in
        print("TAP CALC")
    })
    
    
    
    private var numButtonPressed = UIAction(handler: { action in
        print("TAP NUM")
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupViews()
        setContstraints()

    }
    
    private func setupViews() {
        view.backgroundColor = .dispalayColor
        view.addSubview(mainStackView)
        displayView.addSubview(displayLabel)
        mainStackView.addArrangedSubview(displayView)
        mainStackView.addArrangedSubview(createStackView(count: 4, textSubView: [
            "AC", "+/-", "%", "÷"
        ]))
        mainStackView.addArrangedSubview(createStackView(count: 4, textSubView: [
            "7", "8", "9", "×"
        ]))
        mainStackView.addArrangedSubview(createStackView(count: 4, textSubView: [
            "4", "5", "6", "-"
        ]))
        mainStackView.addArrangedSubview(createStackView(count: 4, textSubView: [
            "1", "2", "3", "+"
        ]))
        let dotEualView = createStackView(count: 2, textSubView: [
            ".", "="
        ])
        let dounStackView = UIStackView(views: [
            createButton(text: "0", color: .buttonBlueColor),
            dotEualView
        ], axis: .horizontal, spacing: 2)
        mainStackView.addArrangedSubview(dounStackView)
        
    }

}

extension ViewController {
    
    private func setContstraints() {
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        displayLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
}
