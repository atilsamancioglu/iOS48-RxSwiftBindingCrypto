//
//  ViewController.swift
//  CryptoRxSwift
//
//  Created by Atil Samancioglu on 18.12.2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate {
   
    let disposeBag = DisposeBag()
    let cryptoVM = CryptoViewModel()
    //var cryptoList = [Crypto]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //tableView.delegate = self
        //tableView.dataSource = self
        view.backgroundColor = .black
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        setupBindings()
        cryptoVM.requestData()
    }
    
    private func setupBindings() {
            
        //do not forget to select hides when stopped property of indicator in storyboard
            cryptoVM.loading
                .bind(to: self.indicatorView.rx.isAnimating)
                .disposed(by: disposeBag)
            
                        
            cryptoVM
                .error
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { failure in
                    print(failure)
                })
                .disposed(by: disposeBag)
            
        //get the cryptos like this by observing or bind the data directly to cell like below
        //in order to bind, we delete datasourcedelegate from vc, and bind the view table like below
        //we have to create a custom cell
        
        /*
            cryptoVM
                .cryptos
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { crypto in
                    self.cryptoList = crypto
                    self.tableView.reloadData()
                })
                .disposed(by: disposeBag)
        */
           
        cryptoVM.cryptos.bind(to: tableView.rx.items(cellIdentifier: "cryptoTableViewCellID", cellType: CryptoTableViewCell.self)) { (row,item,cell) in
            cell.item = item
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Crypto.self).subscribe(onNext: { item in
            print("SelectedItem: \(item.currency)")
            }).disposed(by: disposeBag)
        }
    
  /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            var content = cell.defaultContentConfiguration()
            content.text = cryptoList[indexPath.row].currency
            content.secondaryText = cryptoList[indexPath.row].price
            cell.contentConfiguration = content
            return cell

    }
     */
     
     

}
