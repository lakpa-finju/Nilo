//
//  customPlaceHolder.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-24.
//
import SwiftUI

// Combined extension for TextField and SecureField
extension View {
    @ViewBuilder
    func customPlaceholder(_ placeholder: String, text: Binding<String>) -> some View {
        ZStack(alignment: .leading) {
            if text.wrappedValue.isEmpty {
                Text(placeholder)
                    .bold()
                    .foregroundColor(.black)
            }
            self
        }
    }
}
