//
//  MainViewController.swift
//  MaskStock
//
//  Created by 윤병진 on 2020/05/31.
//  Copyright © 2020 darkKnight. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    private let hospitalMainListView = MainListView()
    private let viewModel = MainViewModel()
    private var disposeBag = DisposeBag()
    private var cellIsSelected : IndexPath?
            
    deinit {
        print("Deinit \(String(describing: self.classForCoder))")
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        hospitalMainListViewConstraintsCondition()
        addDatePickerToolbar()
        textBind()
        buttonBind()
        setObserver()
        setTableViewDelegate()
        mainBind()
        tableViewBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
        
    
    private func addView() {
        view.backgroundColor = .pmsBackgroundColor
        view.addSubview(hospitalMainListView)
    }
    
    private func addDatePickerToolbar() {
        hospitalMainListView.searchView.inputStartDate.setInputViewDatePicker(target: self, selector: #selector(setStartDateDone))
        hospitalMainListView.searchView.inputEndDate.setInputViewDatePicker(target: self, selector: #selector(setEndDateDone))
    }
    
    private func textBind() {
        hospitalMainListView.searchView.inputDrName.rx.text.orEmpty.debug().map{$0}.bind(to: viewModel.storesAddr).disposed(by: disposeBag)
        //hospitalMainListView.searchView.inputStartDate.rx.text.orEmpty.debug().map{$0}.bind(to: viewModel.startDate).disposed(by: disposeBag)
        //hospitalMainListView.searchView.inputEndDate.rx.text.orEmpty.debug().map{$0}.bind(to: viewModel.endDate).disposed(by: disposeBag)
    }
    
    private func buttonBind() {
        hospitalMainListView.searchView.buttonRequest.rx.tap
            .asDriver()
            .throttle(.seconds(1))
            .debug("buttonRequest")
            .drive(onNext: { _ in
                IndicatorView.shared.show()
                self.viewModel.request()
                self.view.endEditing(true)
            }).disposed(by: disposeBag)
    }
    
    @objc func setStartDateDone() {
        if let datePicker = hospitalMainListView.searchView.inputStartDate.inputView as? UIDatePicker {
            let fomatter = DateFormatter()
            fomatter.dateFormat = "yyyy-MM-dd"
            hospitalMainListView.searchView.inputStartDate.text = fomatter.string(from: datePicker.date)
        }
        hospitalMainListView.searchView.inputStartDate.resignFirstResponder()
    }
    
    @objc func setEndDateDone() {
        if let datePicker = hospitalMainListView.searchView.inputEndDate.inputView as? UIDatePicker {
            let fomatter = DateFormatter()
            fomatter.dateFormat = "yyyy-MM-dd"
            hospitalMainListView.searchView.inputEndDate.text = fomatter.string(from: datePicker.date)
        }
        hospitalMainListView.searchView.inputEndDate.resignFirstResponder()
    }
            
    private func setTableViewDelegate() {
        hospitalMainListView.tableView.rx.setDelegate(self as UITableViewDelegate).disposed(by: disposeBag)
        //hospitalMainListView.tableView.emptyDataSetSource = self
        //hospitalMainListView.tableView.emptyDataSetDelegate = self
    }
    
    private func setObserver() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "refresh"), object: nil, queue: nil) { _ in
            self.viewModel.request()
        }
    }
            
    private func mainBind() {
        
        viewModel.model.asObservable()
        .map{$0}
        .subscribe(onNext: { response in
            IndicatorView.shared.hide()
 
        }).disposed(by: disposeBag)
        
        viewModel.responseError.asObservable()
            .debug("responseError")
            .subscribe(onNext: { error in
                if !error.isEmpty {
                    IndicatorView.shared.hide()
                    self.alertHandler("서버와의 통신이 원활하지 않습니다\n잠시 후에 시도해 주세요", actionButton: nil)
                }
            }).disposed(by: disposeBag)
    }
          
    private func tableViewBind() {
        viewModel.model
            .retry(3)
            .observeOn(MainScheduler.instance)
            .debug("TableView")
            .asObservable()
            .flatMap{Observable.from(optional: $0)}
            .map{$0.stores!}
            .bind(to: hospitalMainListView.tableView.rx.items) { tableView, row, model in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainTableViewCell
                cell.selectionStyle = .none
                cell.labelReqNum.text = "No. \(String(tableView.numberOfRows(inSection: 0) - row))"
                cell.labelExplain1.text = "이름: \(model.name)(\(model.typeDetail))"
                cell.labelExplain2.text = "재고 현황: \(model.remain)"
                cell.labelExplain3.text = "입고시간: \(model.stockAt)"
                cell.labelExplain4.text = "데이터 생성일자: \(model.createdAt)"
                cell.inputExpand1.text = "주소: \(model.address)"
                cell.inputExpand2.text = ""
                cell.inputExpand3.text = ""
                cell.inputExpand4.text = ""
                //cell.inputExpand5.text = "등록비: \(model.reqFee)원 (\(model.reqFeeDate))"
                cell.buttonDocView.rx.tap
                    .asDriver()
                    .throttle(.seconds(1))
                    .debug("buttonDocView")
                    .drive(onNext: { _ in
                        
                    }).disposed(by: cell.disposeBag)
                return cell
            }.disposed(by: disposeBag)
    }
            
    private func hospitalMainListViewConstraintsCondition() {
        hospitalMainListView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
        }
    }
}

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
            
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cellIsSelected == indexPath {
            return 360
        }
        return 190
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? MainTableViewCell else { return }
        cellIsSelected = nil

        cell.inputExpand1.isHidden = true
        cell.inputExpand2.isHidden = true
        cell.inputExpand3.isHidden = true
        cell.inputExpand4.isHidden = true
        cell.inputExpand5.isHidden = true
        cell.imageUpDown.image = UIImage(named: "TableViewCellDown")

        cell.disposeBag = DisposeBag()
         
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellIsSelected = cellIsSelected == indexPath ? nil : indexPath
        let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell

        if cellIsSelected == indexPath {
            cell?.inputExpand1.isHidden = false
            cell?.inputExpand2.isHidden = false
            cell?.inputExpand3.isHidden = false
            cell?.inputExpand4.isHidden = false
            cell?.inputExpand5.isHidden = false
            cell?.imageUpDown.image = UIImage(named: "TableViewCellUp")
            
        }
        else{
            cell?.inputExpand1.isHidden = true
            cell?.inputExpand2.isHidden = true
            cell?.inputExpand3.isHidden = true
            cell?.inputExpand4.isHidden = true
            cell?.inputExpand5.isHidden = true
            cell?.imageUpDown.image = UIImage(named: "TableViewCellDown")
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell
        cell?.inputExpand1.isHidden = true
        cell?.inputExpand2.isHidden = true
        cell?.inputExpand3.isHidden = true
        cell?.inputExpand4.isHidden = true
        cell?.inputExpand5.isHidden = true
        cell?.imageUpDown.image = UIImage(named: "TableViewCellDown")
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}
