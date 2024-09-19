//
//  About.swift
//  MacSpresso
//
//  Created by 6b70 on 9/8/24.
//

import Cocoa
import SwiftUI

struct AboutView: View {
    var nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject

    var body: some View {
        let version = nsObject as! String
        VStack(alignment: .center, spacing: 10) {
            VStack(alignment: .center) {
                Image("AppIconImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)

                Text("MacSpresso \(version)")
                    .bold()
                    .font(.title)
                    .padding(.vertical, 5.0)
                    .accessibility(hint: Text("Rek \(version)"))

                Text("Created by 6b70")
                    .underline()
                    .onTapGesture {
                        let link = "https://github.com/6b70"
                        if let url = URL(string: link) {
                            NSWorkspace.shared.open(url)
                        }
                    }
                    .accessibility(hint: Text("Opens GitHub profile on click."))
            }
            .padding(.vertical, 10.0)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)

            HStack {
                Text("Report Bug")

                Button(action: {
                    let repo = "https://github.com/6b70/MacSpresso/issues"
                    if let url = URL(string: repo) {
                        NSWorkspace.shared.open(url)
                    }
                }) {
                    Text("Tell Me")
                }
            } .accessibility(hint: Text("Opens github repository issues"))
        }.padding(.horizontal, 10.0)
            .background(Color.clear)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}



class AboutWindowController {
    static func createWindow() {
        var windowRef: NSWindow
        windowRef = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 250, height: 210),
            styleMask: [
                .titled,
                .closable,
                .borderless],
            backing: .buffered, defer: false)
        windowRef.center()
        windowRef.contentView = NSHostingView(rootView: AboutView())
        windowRef.title = "About MacSpresso"
        windowRef.level = NSWindow.Level.screenSaver
        windowRef.isReleasedWhenClosed = false
        windowRef.makeKeyAndOrderFront(nil)
    }
}
