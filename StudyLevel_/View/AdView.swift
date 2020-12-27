//
//  AdView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/26.
//

import Foundation
import SwiftUI
import GoogleMobileAds

struct AdView: UIViewRepresentable {
    var unitID: String
    
    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: kGADAdSizeBanner)
        banner.adUnitID = unitID
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {
    }
}
