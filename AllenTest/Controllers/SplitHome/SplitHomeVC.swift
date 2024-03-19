//
//  ViewController.swift
//  AllenTest
//
//  Created by Vijay Singh Raghav on 19/03/24.
//

import UIKit

class SplitHomeVC: UIViewController {
    
    enum ScreenType {
        case addExpense
        case viewBalance
    }

    var splitList: [SplitModel] = []
    var screenType: ScreenType = .addExpense
    var members: [[String: Any]] = []
    var expenseAmount: Double = 0.0
    var expenseName: String = ""
    var expensePerson: String = ""
    
    @IBOutlet weak var splitTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    @IBAction func addButttonAction(_ sender: Any) {
        screenType = .addExpense
        splitTableView.reloadData()
    }
    
    @IBAction func viewBalanceButttonAction(_ sender: Any) {
        screenType = .viewBalance
        splitTableView.reloadData()
    }
    
    @IBAction func addExpenseButton(_ sender: UIButton) {
        let splitAmout = expenseAmount / Double(members.count)
        for i in 0..<members.count {
            members[i]["amount"] = splitAmout
        }
        splitList.append(SplitModel(expenseName: expenseName, expenseAmount: expenseAmount, expensePersonName: expensePerson, expenseMembers: members))
        expenseName = ""
        expensePerson = ""
        expenseAmount = 0.0
        members = []
        splitTableView.reloadData()
        print("My List", splitList)
    }
    
    func setupTableView() {
        splitTableView.register(UINib(nibName: "MemberCell", bundle: .main), forCellReuseIdentifier: "MemberCell")
        splitTableView.register(UINib(nibName: "AddExpenseCell", bundle: .main), forCellReuseIdentifier: "AddExpenseCell")
        splitTableView.register(UINib(nibName: "AddParticipantCell", bundle: .main), forCellReuseIdentifier: "AddParticipantCell")
        splitTableView.delegate = self
        splitTableView.dataSource = self
    }
}

extension SplitHomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch screenType {
        case .addExpense:
            return 3
        case .viewBalance:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch screenType {
        case .addExpense:
            switch section {
            case 0, 1: return 1
            default: return members.count
            }
        case .viewBalance:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch screenType {
        case .addExpense:
            switch indexPath.section {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddExpenseCell") as? AddExpenseCell else { return UITableViewCell() }
                let value = (expenseAmount == 0.0) ? "" : ("\(expenseAmount)" )
                cell.delegate = self
                cell.amountTextField.text = value
                cell.expenseField.text = expenseName
                cell.paidByField.text = expensePerson
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddParticipantCell") as? AddParticipantCell else { return UITableViewCell() }
                cell.delegate = self
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell") as? MemberCell else { return UITableViewCell() }
                let dict = members[indexPath.row]
                cell.memberLabel.text = dict["name"] as? String
                return cell
            }
        case .viewBalance:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SplitHomeVC: AddParticipantProtocol {
    
    func addParticipant() {
        let alertVc = UIAlertController(title: nil, message: "Enter the Name of the Participant", preferredStyle: .alert)

        alertVc.addTextField { (textField) in
            textField.placeholder = "Enter Name"
        }
        alertVc.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alertVc] (_) in
            if let textFieldText = alertVc?.textFields![0].text {
                self.members.append(["name" : textFieldText, "amount": 0])
                self.splitTableView.reloadData()
            }
        }))
        self.navigationController?.present(alertVc, animated: true, completion: nil)
    }
}

extension SplitHomeVC: AddExpenseCellProtocol {
    func paidByName(name: String) {
        expensePerson = name
    }
    
    func addExpenseType(type: String) {
        expenseName = type
    }
    
    func addAmountLabel(amount: Double) {
        expenseAmount = amount
    }
}

