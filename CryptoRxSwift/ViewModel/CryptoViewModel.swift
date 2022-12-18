//
//  CryptoViewModel.swift
//  CryptoRxSwift
//
//  Created by Atil Samancioglu on 18.12.2022.
//

import Foundation
import RxSwift
import RxCocoa


class CryptoViewModel {
    
    
    public let cryptos : PublishSubject<[Crypto]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<String> = PublishSubject()
    
    
    public func requestData(){
        
        self.loading.onNext(true)
        Webservice().downloadCurrencies(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!) { cryptoResult in
            self.loading.onNext(false)
            switch cryptoResult {
            case .success(let cryptos):
                print(cryptos)
                self.cryptos.onNext(cryptos)
            case .failure(let failure):
                switch failure {
                case .parsingEror:
                    self.error.onNext("Cannot parse your data")
                case .serverError:
                    self.error.onNext("Cannot get your data at all")
                }
            }
        }
        
        
    }
}
