//
//  HomeView.swift
//  CurrencyConversion
//
//  Created by Ragaie Alfy on 12/3/20.
//

import UIKit
//collection cell id  -->  cellID
class HomeView: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var currencyValueTextFiled: UITextField!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var currentCurrencyButton: UIButton!
    @IBOutlet weak var curreenciesCollection: UICollectionView!
    var presneter : HomePresenterDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        presneter = HomePresenter(router: HomeRouter())
        presneter?.view = self
        presneter?.setInteractor()
        Coordinator.shared
            .rootNavigationController = self.navigationController
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presneter?.getData()
        self.navigationController?.navigationBar.isHidden = true
    }
    func setUp() {
        if let flowLayout = curreenciesCollection?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = .zero
        }
        currencyValueTextFiled.addTarget(self, action: #selector(textFieldEditingDidEnded(_:)), for: UIControl.Event.editingChanged)
        curreenciesCollection.delegate = self
        curreenciesCollection.dataSource = self
    }
    @objc func textFieldEditingDidEnded(_ sender: UITextField) {
        if let amount = Float.init(currencyValueTextFiled.text ?? "") {
            presneter?.convertAmount(amount: amount)
        }
    }
    @IBAction func selectCurrentCurrency(_ sender: Any) {
        presneter?.callingIndex = 0
        presneter?.addNewCountryCode(delegate: self)
    }
    @IBAction func addMoreCurrency(_ sender: Any) {
        presneter?.callingIndex = 1
        presneter?.addNewCountryCode(delegate: self)
    }
}
extension HomeView: SentBackKeyToHomeDelegate {
    func selectCode(code: String) {
        if presneter?.callingIndex == 0 {
            presneter?.fromCountryCode(code: code)
            currentCurrencyButton.setTitle(code, for: .normal)
        } else {
            presneter?.selectedNewCode(code: code)
        }
    }
}
extension HomeView : HomeDelegate {
    func loaderIsHidden(ishidden: Bool) {
        loaderView.isHidden = true
    }
    func updateScreenWithData() {
        curreenciesCollection.reloadData()
        errorLabel.text = ""
    }
    func gotAnError(error: String) {
        errorLabel.text = error
    }
}

extension HomeView:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  presneter?.codesSelected.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? CurrencyCollectionViewCell
        cell?.shadowDecorate()
        cell?.currencyCode.text = presneter?.codesSelected[indexPath.row]
        cell?.valueLabel.text = String(presneter?.calculatedValues[indexPath.row] ?? 0)
        return cell ?? UICollectionViewCell()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGSize
        size = CGSize.init(width: (collectionView.frame.width / 2) - 10 , height: 150)
        return size
    }
}
