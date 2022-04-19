//
//  LinearGraph.swift
//  UI-312 (iOS)
//
//  Created by nyannyan0328 on 2021/09/21.
//

import SwiftUI

struct LinearGraph: View {
    var data : [Double]

    
    @State var graphProgress : CGFloat = 0
    
    var profit : Bool = false
    
    var body: some View {
        GeometryReader{proxy in
            let height = proxy.size.height
            let width = (proxy.size.width) / CGFloat(data.count - 1)
            
            let maxPoint = (data.max() ?? 0)
            let minPoint = data.min() ?? 0
            
            let points = data.enumerated().compactMap { item -> CGPoint in
                
                let progress = (item.element - minPoint) / (maxPoint - minPoint)
                
                let pathHight = progress * (height)
                let pathWidth = width * CGFloat(item.offset)
                
                
                return CGPoint(x: pathWidth, y: -pathHight + height)
                
                
                
                
                
            }
            
            ZStack{
                
            AnimatedGraphPath(progress: graphProgress, points: points)
                .fill(
                
                
                LinearGradient(colors: [
                
                    
                    profit ? Color("Profit") : Color("Loss"),
                    profit ? Color("Profit") : Color("Loss"),
                    
                    
                
                ], startPoint: .leading, endPoint: .trailing)
                
                
                )
                
                
                FILBG()
                
                    .clipShape(
                    
                    
                        Path{path in
                            
                            
                            path.move(to: CGPoint(x: 0, y: 0))
                            
                            path.addLines(points)
                            
                            path.addLine(to: CGPoint(x: proxy.size.width, y: height))
                            path.addLine(to: CGPoint(x: 0, y: height))
                        }
                    
                    )
                    .opacity(graphProgress)
                
                
                
                
            }
            
       
            
            
            
            
        }
        
      
        .padding(.horizontal,10)
     
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                
                withAnimation(.easeInOut(duration: 1.2)){
                    
                    graphProgress = 1
                }
            }
        }
        .onChange(of: data) { newValue in
            
            graphProgress = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                
                withAnimation(.easeInOut(duration: 1.2)){
                    
                    graphProgress = 1
                }
            }
        }
        
      
    }
    @ViewBuilder
    func FILBG()->some View{
        
        let color = profit ? Color("Profit") : Color("Loss")
        
        
        LinearGradient(colors: [
        
            color.opacity(0.3),
            color.opacity(0.2),
            color.opacity(0.1),
            color.opacity(0.1),
    
        
        ] + Array(repeating: color.opacity(0.1), count: 4) + Array(repeating: Color.clear.opacity(0.1), count: 2), startPoint: .top, endPoint: .bottom)
        
        
    }
}

struct LinearGraph_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AnimatedGraphPath : Shape{
    
    var progress : CGFloat
    var points : [CGPoint]
    var animatableData: CGFloat{
        
        get{return progress}
        set{progress = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        
        Path{Path in
            
            
            Path.move(to: CGPoint(x: 0, y: 0))
            Path.addLines(points)
            
            
            
        }
        .trimmedPath(from: 0, to: progress)
        .strokedPath(StrokeStyle(lineWidth: 2.3, lineCap: .round, lineJoin: .round))
        
    }
}


