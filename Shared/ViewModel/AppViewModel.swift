//
//  AppViewModel.swift
//  Crypton
//
//  Created by nyannyan0328 on 2022/04/11.
//

import SwiftUI

class AppViewModel: ObservableObject {
    @Published var coins : [CryptoModel]?
    @Published var currentCoin : CryptoModel?
    
    
    init() {
        Task{
            
            do{
                
                try await fetchCryptonData()
                
            }
            catch{
                
                print(error.localizedDescription)
            }
        }
    }
    
    
    func fetchCryptonData()async throws{
        
        guard let url = url else{return}
        
        let session = URLSession.shared
        
        let responce = try await session.data(from: url)
        
        let jsonData = try JSONDecoder().decode([CryptoModel].self, from: responce.0)
        
        await MainActor.run(body: {
            
            self.coins = jsonData
            
            if let fistCoin = jsonData.first{
                
                self.currentCoin = fistCoin
            }
        })
    }
}

