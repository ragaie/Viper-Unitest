//
//  CurrenciesView.swift
//  CurrencyConversion
//
//  Created by Ragaie Alfy on 12/3/20.
//

import UIKit
//cellId tableViewCellID
class CurrenciesView: UIViewController {
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var tableViewCurrencies: UITableView!
    @IBOutlet weak var errorMessage: UILabel!
    weak var homeSentBackDelegate: SentBackKeyToHomeDelegate?
    var presenter: CurrenciesPresenterDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        tableViewCurrencies.delegate = self
        tableViewCurrencies
            .dataSource = self
        self.title = "Currencies"
        presenter = CurrenciesPresenter()
        presenter?.setInteeractor()
        presenter?.view = self
        presenter?.getAllData()
        // Do any additional setup after loading the view.
    }
}

extension CurrenciesView: CurrenciesHomeDelegate {
    func gotAnError(error: String) {
        tableViewCurrencies.isHidden = true
        loader.isHidden = true
        errorMessage.isHidden = false
        errorMessage.text = error
    }
    func updateScreenWithData() {
        tableViewCurrencies.isHidden = false
        loader.isHidden = true
        tableViewCurrencies.reloadData()
    }
}
extension CurrenciesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.currenciesItems?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID", for: indexPath)
        cell.detailTextLabel?.text = Array(presenter!.currenciesItems!.keys)[indexPath.row]
        cell.textLabel?.text =  Array(presenter!.currenciesItems!.values)[indexPath.row]
    return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homeSentBackDelegate?.selectCode(code: Array(presenter!.currenciesItems!.keys)[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
