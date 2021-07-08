//
//  AddEditToDoListViewController.swift
//  ToDo
//
//  Created by Avnish Kumar on 06/07/21.
//

import UIKit

class AddEditToDoListViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var reminderEnabledDisableSwitch: UISwitch!
    
    var addEditToDoViewModel = AddEditToDoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
        self.loadDataInViews()
        addObserverToViewModel()
    }
        
    func updateViews() {
        hideKeyboardWhenTappedAround()
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: Constant.multiply)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: Constant.multiply)
        self.detailTextView.delegate = self
        self.detailTextView.autocorrectionType = .no
        loadDatePicker()
    }
    
    func loadDatePicker() {
        self.dateTextField.delegate = self
        let datePicker = UIDatePicker()
        datePicker.minimumDate = Date()
        datePicker.locale = .current
        datePicker.timeZone = .current
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        dateTextField.inputView = datePicker
        datePicker.sizeToFit()
        datePicker.addTarget(self, action: #selector(datePickerChangedDate(datePicker:)), for: .valueChanged)
    }

    func loadDataInViews() {
        addEditToDoViewModel.loadData()
        dateTextField.text = addEditToDoViewModel.dateText
        detailTextView.text = addEditToDoViewModel.detailText
        reminderEnabledDisableSwitch.isOn = addEditToDoViewModel.isReminderEnabled
    }
    
    func addObserverToViewModel() {
        addEditToDoViewModel.isDetailsValid.observe {[weak self] isValid
            in
            guard let self = self else {
                return
            }
            if isValid {
                self.navigationController?.popViewController(animated: true)
            }else {
                Utility.showAlert(vc: self, title: "Invalid Data", message: "Pleae enter the valid details")
            }
        }
    }
    
    @objc func datePickerChangedDate(datePicker:UIDatePicker) {
        dateTextField.text = datePicker.date.dateInStringFormatFor()
        self.addEditToDoViewModel.selectedDate = datePicker.date
    }
    
    @IBAction func reminderEnableDisableSwitchValueChanged(_ sender: UISwitch) {
        self.addEditToDoViewModel.isReminderEnabled = sender.isOn
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        addEditToDoViewModel.addUpdateToDo()
    }
}

extension AddEditToDoListViewController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        false
    }
}

extension AddEditToDoListViewController:UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.addEditToDoViewModel.detailText = textView.text
    }
}

