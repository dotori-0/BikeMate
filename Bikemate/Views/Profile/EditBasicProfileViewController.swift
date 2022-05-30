//
//  EditBasicProfileViewController.swift
//  Bikemate
//
//

import UIKit

class EditBasicProfileViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nameValueTextField: UITextField!
    @IBOutlet weak var ageValueTextField: UITextField!
    @IBOutlet weak var districtValueTextField: UITextField!
    
    var agePicker: UIPickerView!
    var districtPicker: UIPickerView!
    var selectedAge = 20
    var selectedDistrict = "구"
    
    let ageValues = [Int](20...60)
    let districtValues = ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameValueTextField.delegate = self
        
        // 기본 정보
        nameValueTextField.text = UserModel.shared.name
        ageValueTextField.text = String(UserModel.shared.age)
        districtValueTextField.text = UserModel.shared.location.rawValue
        
        setPickerViews()
        
        print("이름: \(UserModel.shared.name)")
    }
    
    // MARK: - Picker View Settings
    // using ageValueTextField: UITextField
    
    func setPickerViews() {
        // Picker View for setting age
        let agePickerView = UIPickerView()
        agePickerView.delegate = self
        agePickerView.dataSource = self
        agePickerView.backgroundColor = .white
        ageValueTextField.tintColor = .clear
        agePicker = agePickerView
        if let row = ageValues.firstIndex(of: UserModel.shared.age) {
            agePicker.selectRow(row, inComponent: 0, animated: true)
        }

        // Picker View for setting preferred district
        let districtPickerView = UIPickerView()
        districtPickerView.delegate = self
        districtPickerView.dataSource = self
        districtPickerView.backgroundColor = .white
        districtValueTextField.tintColor = .clear
        districtPicker = districtPickerView
        if let row = districtValues.firstIndex(of: UserModel.shared.location.rawValue) {
            districtPicker.selectRow(row, inComponent: 0, animated: false)
        }
        
        // 툴바 세팅
        let toolBarForAge = UIToolbar()
        toolBarForAge.sizeToFit()
        toolBarForAge.tintColor = .black
        
        let toolBarForDistrict = UIToolbar()
        toolBarForDistrict.sizeToFit()
        toolBarForDistrict.tintColor = .black
        
        let cancelButtonForAge = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(onCancel))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButtonForAge = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onConfirmAge))
        toolBarForAge.setItems([cancelButtonForAge, space, doneButtonForAge], animated: true)
        toolBarForAge.isUserInteractionEnabled = true
        
        let cancelButtonForDistrict = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(onCancel))
        let doneButtonForDistrict = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onConfirmDistrict))
        toolBarForDistrict.setItems([cancelButtonForDistrict, space, doneButtonForDistrict], animated: true)
        toolBarForDistrict.isUserInteractionEnabled = true
        
        
        // 텍스트필드 입력 수단 연결 및 툴바 장착
        ageValueTextField.inputView = agePickerView
        ageValueTextField.inputAccessoryView = toolBarForAge
        districtValueTextField.inputView = districtPickerView
        districtValueTextField.inputAccessoryView = toolBarForDistrict
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == agePicker { return ageValues.count }
        else { return districtValues.count }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == agePicker { return "\(ageValues[row])" }
        else { return districtValues[row] }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == agePicker { selectedAge = ageValues[row] }
        else { selectedDistrict = districtValues[row] }
    }
    
    // Age Picker View > 확인 탭
    @objc func onConfirmAge() {
        // 텍스트필드 텍스트 변경
        ageValueTextField.text = String(selectedAge)
        
        // UserModel 업데이트
        UserDatabaseManager.shared.editUserAge(to: selectedAge)
        
        // Picker View 내리기
        ageValueTextField.resignFirstResponder()
    }
    
    // District Picker View > 확인 탭
    @objc func onConfirmDistrict() {
        // 텍스트필드 텍스트 변경
        districtValueTextField.text = selectedDistrict
        
        UserDatabaseManager.shared.editUserDistrict(to: Location(rawValue: selectedDistrict)!)
        
        // Picker View 내리기
        districtValueTextField.resignFirstResponder()
    }
    
    // Picker View > 취소 탭
    @objc func onCancel() {
        ageValueTextField.resignFirstResponder()
        districtValueTextField.resignFirstResponder()
    }
}

extension EditBasicProfileViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == nameValueTextField {
        nameValueTextField.resignFirstResponder()
        UserDatabaseManager.shared.editUserName(to: nameValueTextField.text ?? "이름 없음") 
    }
    return true
  }
}
