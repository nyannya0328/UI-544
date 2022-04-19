//
//  UI_544App.swift
//  Shared
//
//  Created by nyannyan0328 on 2022/04/19.
//

import SwiftUI

@main
struct UI_544App: App {
    @NSApplicationDelegateAdaptor(AppDeletage.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
class AppDeletage : NSObject,ObservableObject,NSApplicationDelegate{
    @Published var statusItem : NSStatusItem?
    @Published var popOver = NSPopover()
    
    func application(_ app: NSApplication, didDecodeRestorableState coder: NSCoder) {
        
        setUP()
        
    }
    
    func setUP(){
        
        popOver.animates = true
        popOver.behavior = .transient
        
        
        popOver.contentViewController = NSViewController()
        popOver.contentViewController?.view = NSHostingView(rootView: Home())
        
        
        popOver.contentViewController?.view.window?.makeKey()
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        
        if let menuButton = statusItem?.button{
            
            
            menuButton.image = .init(systemSymbolName: "dollarsign.circle", accessibilityDescription: nil)
            menuButton.action = #selector(MenuButtonAction(sender: ))
        }
        
        
        
        
        
    }
    @objc func MenuButtonAction(sender : AnyObject){
        
        if popOver.isShown{
            
            popOver.performClose(sender)
        }
        else{
            
            if let menuButon = statusItem?.button{
                
                popOver.show(relativeTo: menuButon.bounds, of: menuButon, preferredEdge: .minY)
            }
        }
        
        
    }
    
}
