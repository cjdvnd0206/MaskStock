//
//  MainSearchView.swift
//  MaskStock
//
//  Created by 윤병진 on 2020/05/31.
//  Copyright © 2020 darkKnight. All rights reserved.
//

import UIKit

class MainSearchView : UIView {
    
    private let customView = UIView()
    private let labelDrName = UILabel()
    public let inputDrName = UITextField()
    private let labelCName = UILabel()
    private let inputCName = UITextField()
    private let labelDate = UILabel()
    public let inputStartDate = UITextField()
    private let labelWave = UILabel()
    public let inputEndDate = UITextField()
    public let buttonRequest = UIButton()
    private let shadowLayer = CAShapeLayer()
    private let conerRadius : CGFloat = 15
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        //makeLabelCompanyNameAttributes()
        //makeInputCompanyNameAttributes()
        makeLabelDoctorNameAttributes()
        makeInputDoctorNameAttributes()
        //makeLabelDateAttributes()
        //makeInputStartDateAttributes()
        //makeLabelWaveAttributes()
        //makeInputEndDateAttributes()
        makeButtonRequestAttributes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        customViewConstraints()
        //makeLabelCompanyNameConstraints()
        //makeInputCompanyNameConstraints()
        makeLabelDoctorNameConstraints()
        makeInputDoctorNameConstraints()
        //makeLabelDateConstraints()
        //makeInputStartDateConstraints()
        //makeLabelWaveConstraints()
        //makeInputEndDateConstraints()
        makeButtonRequestConstraints()
    }
    
    override func draw(_ rect: CGRect) {
        setShadowCornerRadius()
    }

    private func addView() {
        addSubview(customView)
        customView.addSubview(labelCName)
        customView.addSubview(inputCName)
        customView.addSubview(labelDrName)
        customView.addSubview(inputDrName)
        customView.addSubview(labelDate)
        customView.addSubview(inputStartDate)
        customView.addSubview(labelWave)
        customView.addSubview(inputEndDate)
        customView.addSubview(buttonRequest)
    }
    
    private func setShadowCornerRadius() {
        shadowLayer.path = UIBezierPath(roundedRect: customView.bounds, cornerRadius: conerRadius).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = UIColor.pmsShadowColor.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        shadowLayer.shadowOpacity = 0
        shadowLayer.shadowRadius = 3
        customView.layer.insertSublayer(shadowLayer, at: 0)
    }
       
    // MARK: Attributes
    private func makeLabelCompanyNameAttributes() {
        labelCName.text = "요양시설 이름"
        labelCName.textColor = .rgbColor(74, 73, 92)
        labelCName.font = .boldSystemFont(ofSize: 13)
    }
    
    private func makeInputCompanyNameAttributes() {
        inputCName.backgroundColor = .rgbColor(242, 245, 247)
        inputCName.textColor = .rgbColor(99, 102, 108)
        inputCName.font = .boldSystemFont(ofSize: 13)
        inputCName.layer.cornerRadius = 5
        inputCName.setLeftPaddingPoints(15)
    }
    
    private func makeLabelDoctorNameAttributes() {
        labelDrName.text = "주소"
        labelDrName.textColor = .rgbColor(74, 73, 92)
        labelDrName.font = .boldSystemFont(ofSize: 13)
    }
    
    private func makeInputDoctorNameAttributes() {
        inputDrName.backgroundColor = .rgbColor(242, 245, 247)
        inputDrName.textColor = .rgbColor(99, 102, 108)
        inputDrName.font = .boldSystemFont(ofSize: 13)
        inputDrName.layer.cornerRadius = 5
        inputDrName.setLeftPaddingPoints(15)
    }
    
    private func makeLabelDateAttributes() {
        labelDate.text = "촉탁기간"
        labelDate.textColor = .rgbColor(74, 73, 92)
        labelDate.font = .boldSystemFont(ofSize: 13)
    }
    
    private func makeInputStartDateAttributes() {
        inputStartDate.backgroundColor = .rgbColor(242, 245, 247)
        inputStartDate.textColor = .rgbColor(99, 102, 108)
        inputStartDate.font = .boldSystemFont(ofSize: 13)
        inputStartDate.layer.cornerRadius = 5
        inputStartDate.textAlignment = .center
        inputStartDate.adjustsFontSizeToFitWidth = true
        inputStartDate.minimumFontSize = 0.5
    }
    
    private func makeLabelWaveAttributes() {
        labelWave.text = "~"
        labelWave.textColor = .rgbColor(74, 73, 92)
        labelWave.font = .boldSystemFont(ofSize: 14)
    }
    
    private func makeInputEndDateAttributes() {
        inputEndDate.backgroundColor = .rgbColor(242, 245, 247)
        inputEndDate.textColor = .rgbColor(99, 102, 108)
        inputEndDate.font = .boldSystemFont(ofSize: 13)
        inputEndDate.layer.cornerRadius = 5
        inputEndDate.textAlignment = .center
        inputEndDate.adjustsFontSizeToFitWidth = true
        inputEndDate.minimumFontSize = 0.5
    }
    
    private func makeButtonRequestAttributes() {
        buttonRequest.setTitle("조회", for: .normal)
        buttonRequest.titleLabel?.font = .boldSystemFont(ofSize: 13)
        buttonRequest.backgroundColor = .rgbColor(94, 124, 226)
        buttonRequest.setTitleColor(.white, for: .normal)
        buttonRequest.layer.cornerRadius = 3
    }
    
    // MARK: ConstraintsCondition
    private func customViewConstraints() {
        customView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.bottom.equalTo(self)
        }
    }
    
    private func makeLabelCompanyNameConstraints() {
        labelCName.snp.makeConstraints { make in
            make.top.equalTo(customView).offset(20)
            make.leading.equalTo(customView).offset(20)
            make.trailing.equalTo(inputCName.snp.leading)
        }
    }
    
    private func makeInputCompanyNameConstraints() {
        inputCName.snp.makeConstraints { make in
            make.centerY.equalTo(labelCName.snp.centerY)
            make.leading.equalTo(labelCName.snp.leading).offset(70)
            make.trailing.equalTo(customView.snp.centerX).offset(30)
            make.height.equalTo(20)
        }
    }

    private func makeLabelDoctorNameConstraints() {
        labelDrName.snp.makeConstraints { make in
            make.top.equalTo(customView).offset(20)
            make.leading.equalTo(customView).offset(20)
            make.trailing.equalTo(customView.snp.centerX).offset(-70)
        }
    }
    
    private func makeInputDoctorNameConstraints() {
        inputDrName.snp.makeConstraints { make in
            make.centerY.equalTo(labelDrName.snp.centerY)
            make.leading.equalTo(labelDrName.snp.trailing)
            make.trailing.equalTo(customView).offset(-70)
            make.height.equalTo(25)
        }
    }
    
    private func makeLabelDateConstraints() {
        labelDate.snp.makeConstraints { make in
            make.top.equalTo(labelDrName.snp.bottom).offset(20)
            make.leading.equalTo(customView).offset(20)
            make.trailing.equalTo(customView.snp.centerX).offset(-70)
        }
    }
    
    private func makeInputStartDateConstraints() {
        inputStartDate.snp.makeConstraints { (make) in
            make.centerY.equalTo(labelDate.snp.centerY)
            make.leading.equalTo(labelDate.snp.trailing)
            make.trailing.equalTo(customView).offset(-140)
            make.height.equalTo(25)
        }
    }
    
    private func makeLabelWaveConstraints() {
        labelWave.snp.makeConstraints { make in
            make.centerY.equalTo(labelDate.snp.centerY)
            make.left.equalTo(inputStartDate.snp.right)
            make.height.equalTo(25)
        }
    }
    
    private func makeInputEndDateConstraints() {
        inputEndDate.snp.makeConstraints { (make) in
            make.centerY.equalTo(labelDate.snp.centerY)
            make.left.equalTo(labelWave.snp.right)
            make.width.height.equalTo(inputStartDate)
        }
    }
    
    private func makeButtonRequestConstraints() {
        buttonRequest.snp.makeConstraints { (make) in
            make.bottom.equalTo(customView).offset(-20)
            make.leading.equalTo(customView).offset(140)
            make.trailing.equalTo(customView).offset(-140)
            make.height.equalTo(30)
        }
    }
}
