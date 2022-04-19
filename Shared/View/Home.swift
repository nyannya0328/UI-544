//
//  Home.swift
//  UI-544 (iOS)continuous
//
//  Created by nyannyan0328 on 2022/04/19.
//

import SwiftUI

struct Home: View {
    @State var currentTab : String = "Crypton"
    @Namespace var animation
    @StateObject var model : AppViewModel = .init()
    var body: some View {
        VStack{
            
        CustomSegnmentController()
                .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                
                VStack{
                    
                    if let coins = model.coins{
                        
                        ForEach(coins){coin in
                            
                            VStack{
                                
                                CardView(coins: coin)
                                
                                Divider()
                            }
                            
                            
                            .padding()
                            
                        }
                    }
                }
            
                
                
            }
            
            HStack{
                
                Button {
                    
                } label: {
                    
                    Image(systemName: "gearshape.fill")
                    
                    
                }
                Spacer()
                
                Button {
                    
                } label: {
                    
                    Image(systemName: "power")
                    
                    
                }
                

                
                
            }
            .padding()
            .background(.black)
            
            
        }
        .frame(width: 350, height: 450)
        .background{Color("BG")}
        .buttonStyle(.plain)
        .preferredColorScheme(.dark)
    }
    @ViewBuilder
    func CardView(coins : CryptoModel)->some View{
        
        HStack{
            
            VStack(alignment: .leading, spacing: 14) {
                
                
                Text(coins.name)
                    .font(.title3.bold())
                    .foregroundColor(.white)
                
                Text(coins.symbol)
                    .font(.caption.weight(.light))
                    .foregroundColor(.gray)
            }
            .frame(width: 60, height: 50)
            
            
            LinearGraph(data: coins.last_7days_price.price, profit: coins.price_change > 0)
            
            
            VStack(alignment: .trailing, spacing: 15) {
                
                Text(coins.current_price.convertCurrncy())
                    .font(.title3.bold())
                
                
                Text("\(coins.price_change > 0 ? "+" : "")\(String(format: "%.2f",coins.price_change))")
                    .font(.caption)
                    .foregroundColor(coins.price_change > 0 ? Color("LightGreen") : .red)
                
                
                
                    
                
            }
        }
        
        
    }
    @ViewBuilder
    func CustomSegnmentController()->some View{
        
        HStack{
            
            ForEach(["Crypton","Stocks"],id:\.self){tab in
                
                
                Text(tab)
                    .fontWeight(currentTab == tab ? .semibold : .regular)
                    .foregroundColor(currentTab == tab ? .white : .gray)
                    .padding(.vertical,6)
                    .frame(maxWidth:.infinity)
                    .background{
                        
                        if currentTab == tab{
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.gray)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                            
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        
                        withAnimation{currentTab = tab}
                    }
                
            }
        }
        .padding(2)
        .background{
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.black)
            
            
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Double{
    
    func convertCurrncy()->String{
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "gu_IN")
        
        return formatter.string(from: .init(value: self)) ?? ""
    }
}
