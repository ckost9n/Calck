//
//  ViewController.swift
//  Calck
//
//  Created by Konstantin on 20.06.2022.
//

import UIKit
import SnapKit

enum Constants: String {
    case dot = "."
    case ac = "AC"
    case plusMinus = "+/-"
    case del = "%"
    case percent = "÷"
    case myltiply = "×"
    case plus = "+"
    case minus = "-"
    case equal = "="
}

class ViewController: UIViewController {
    
    private var spacingButton: CGFloat = 10
    
    var mainStackView = UIStackView(views: [], axis: .vertical, spacing: 2)
    
    private lazy var buttonStackView = UIStackView(views: [], axis: .vertical, spacing: spacingButton)
    
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
        
        let myStackView = UIStackView(views: [], axis: .horizontal, spacing: spacingButton)
        let ac = ["AC", "+/-", "%"]
        var color: UIColor
        for i in 0...count - 1 {
            color = (i == count - 1) ? .buttonOrangeColor : .buttonBlueColor
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
        
        buttonStackView.addArrangedSubview(createStackView(count: 4, textSubView: [
            Constants.ac.rawValue,
            Constants.plusMinus.rawValue,
            Constants.del.rawValue,
            Constants.percent.rawValue
        ]))
        buttonStackView.addArrangedSubview(createStackView(count: 4, textSubView: [
            "7", "8", "9", Constants.myltiply.rawValue
        ]))
        buttonStackView.addArrangedSubview(createStackView(count: 4, textSubView: [
            "4", "5", "6", Constants.minus.rawValue
        ]))
        buttonStackView.addArrangedSubview(createStackView(count: 4, textSubView: [
            "1", "2", "3", Constants.plus.rawValue
        ]))
        let dotEualView = createStackView(count: 2, textSubView: [
            Constants.dot.rawValue, Constants.equal.rawValue
        ])
        let douwnStackView = UIStackView(views: [
            createButton(text: "0", color: .buttonBlueColor),
            dotEualView
        ], axis: .horizontal, spacing: spacingButton)
        buttonStackView.addArrangedSubview(douwnStackView)
        
        mainStackView.addArrangedSubview(displayView)
        mainStackView.addArrangedSubview(buttonStackView)
        mainStackView.distribution = .fillProportionally
    }

}

extension ViewController {
    
    private func setContstraints() {
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).inset(10)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        displayLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        displayView.snp.makeConstraints { make in
            make.height.equalTo(self.mainStackView.snp.height).multipliedBy(0.4)
        }
    }
    
}
