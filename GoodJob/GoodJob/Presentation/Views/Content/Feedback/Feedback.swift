//
//  Feedback.swift
//  GoodJob
//
//  Created by JeongTaek Han on 2/3/24.
//

import Foundation
import SwiftUI
import MessageUI


struct MenuView: View {
    
    @State private var isShowingSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("FeedBack") {
                    Button(action: { isShowingSheet.toggle() }) {
                        Label("Contact to Developer", systemImage: "envelope")
                    }
                }
            }
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowingSheet) {
                MailView(recipient: "smart8612@gmail.com", subject: "App Feedback", message: .init())
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
    
}

struct FeedbackView_Previews: PreviewProvider {
    
    static var previews: some View {
        MenuView()
    }
    
}

fileprivate struct MailView: UIViewControllerRepresentable {
    
    var recipient: String
    var subject: String
    var message: String

    func makeUIViewController(context: Context) -> UIViewController {
        let mailViewController = MFMailComposeViewController()
        mailViewController.setToRecipients([recipient])
        mailViewController.setSubject(subject)
        mailViewController.setMessageBody(message, isHTML: false)
        mailViewController.mailComposeDelegate = context.coordinator
        return mailViewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailView

        init(_ parent: MailView) {
            self.parent = parent
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
}
