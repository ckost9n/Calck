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
    
    private var isFinishedTypingNumber = true
    private var isPointAdd = false
    
    private var displayValue: Double {
        get {
            guard let text = displayLabel.text,
                  let textDouble = Double(text) else { return 0 }
            
            return textDouble
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    private var mainStackView = UIStackView(views: [], axis: .vertical, spacing: 2)
    
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
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func createButton(text: String, color: UIColor) -> UIButton {
        let myButton = UIButton(text: text, color: color)
        if Int(text) != nil || text == Constants.dot.rawValue {
            myButton.addTarget(self, action: #selector(numButtonPressed), for: .touchUpInside)
        } else {
            myButton.addTarget(self, action: #selector(calcButtonPressed), for: .touchUpInside)
        }
        return myButton
    }
    
    private func createStackView(count: Int, textSubView: [String]) -> UIStackView {
        
        let myStackView = UIStackView(views: [], axis: .horizontal, spacing: spacingButton)
        let ac = [Constants.ac.rawValue, Constants.plusMinus.rawValue, Constants.del.rawValue]
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
    
    @objc private func calcButtonPressed(_ sender: UIButton) {
        
        isFinishedTypingNumber = true
        isPointAdd = false
        
        
        guard let operationValue = sender.titleLabel?.text else { return }
//        guard let resultStr = displayLabel.text,
//              let firstNum = Double(resultStr) else { return }
//        var secondNum = 0.0
        
        switch operationValue {
        case Constants.plusMinus.rawValue: displayValue *= -1
        case Constants.ac.rawValue: displayLabel.text = "0"
        case Constants.del.rawValue: displayValue *= 0.001
        default: break
        }
//        displayLabel.text = secondNum == 0.0 ? "0" : String(secondNum)
    }
    
    @objc private func numButtonPressed(_ sender: UIButton) {
        guard let numValue = sender.titleLabel?.text else { return }
        
        if isFinishedTypingNumber {
            displayLabel.text = numValue
            isFinishedTypingNumber = false
        } else {
            
            if numValue == Constants.dot.rawValue {
                
                if isPointAdd {
                    return
                }
                
                isPointAdd = true
            }
            displayLabel.text! += numValue
        }
        
        
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
