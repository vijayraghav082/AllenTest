//
//  AddExpenseCell.swift
//  AllenTest
//
//  Created by Vijay Singh Raghav on 19/03/24.
//

import UIKit

protocol AddExpenseCellProtocol: AnyObject {
    func paidByName(name: String)
    func addExpenseType(type: String)
    func addAmountLabel(amount: Double)
}

class AddExpenseCell: UITableViewCell {
    
    weak var delegate: AddExpenseCellProtocol?

    @IBOutlet weak var paidByField: UITextField!
    @IBOutlet weak var expenseField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        paidByField.delegate = self
        expenseField.delegate = self
        amountTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension AddExpenseCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if  let text = textField.text, !text.isEmpty {
            if textField == expenseField {
                delegate?.addExpenseType(type: expenseField.text ?? "")
            } else if textField == paidByField  {
                delegate?.paidByName(name: paidByField.text ?? "")
            } else {
                delegate?.addAmountLabel(amount: Double(amountTextField.text ?? "0") ?? 0.0)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if  let text = textField.text, !text.isEmpty {
            if textField == expenseField {
                delegate?.addExpenseType(type: expenseField.text ?? "")
            } else if textField == paidByField  {
                delegate?.paidByName(name: paidByField.text ?? "")
            } else {
                delegate?.addAmountLabel(amount: Double(amountTextField.text ?? "0") ?? 0.0)
            }
        }
        return true
    }
}
