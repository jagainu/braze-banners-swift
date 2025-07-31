//
//  ContentView.swift
//  BrazeBanners
//
//  Created by Makoto Taguchi on 2025/07/31.
//

import SwiftUI
import BrazeKit
import BrazeUI

struct BannerSwiftUIView: View {
    static let bannerPlacementID = "header_banner"
    
    @State var hasBannerForPlacement: Bool = false
    @State var contentHeight: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 20) {
            if let braze = AppDelegate.braze,
               hasBannerForPlacement {
                BrazeBannerUI.BannerView(
                    placementId: BannerSwiftUIView.bannerPlacementID,
                    braze: braze,
                    processContentUpdates: { result in
                        print("[BannerSwiftUIView] 📋 processContentUpdates called")
                        switch result {
                        case .success(let updates):
                            print("[BannerSwiftUIView] ✅ Banner content updates received")
                            
                            if let height = updates.height {
                                print("[BannerSwiftUIView] 📏 Height from updates: \(height)")
                                DispatchQueue.main.async {
                                    self.contentHeight = height
                                }
                            }
                        case .failure(let error):
                            print("[BannerSwiftUIView] ❌ Banner content update failed: \(error)")
                        }
                    }
                )
                .frame(height: contentHeight)
            }
        }
        .onAppear {
            print("[BannerSwiftUIView] 📐 BannerView appeared with contentHeight: \(contentHeight)")
            // バナーのリフレッシュが完了するまで少し待つ - requestBannersRefresh()のコールバックがないため暫定的な対応
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                AppDelegate.braze?.banners.getBanner(
                    for: BannerSwiftUIView.bannerPlacementID,
                    { banner in
                        DispatchQueue.main.async {
                            hasBannerForPlacement = banner != nil
                            if banner != nil {
                                print("[BannerSwiftUIView] ✅ Banner is now available")
                            } else {
                                print("[BannerSwiftUIView] ⚠️ Banner not available yet")
                            }
                        }
                    }
                )
            }
        }
        
            VStack(alignment: .leading, spacing: 10) {
                Text("Banners Status")
                    .font(.system(.headline, design: .default))
                    .foregroundColor(.primary)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "tag.fill")
                            .foregroundColor(.blue)
                        Text("Placement ID: \(BannerSwiftUIView.bannerPlacementID)")
                            .font(.system(.body, design: .default))
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: hasBannerForPlacement ? "checkmark.circle.fill" : "xmark.circle")
                            .foregroundColor(hasBannerForPlacement ? .green : .red)
                        Text("Banner Available: \(hasBannerForPlacement ? "Yes" : "No")")
                            .font(.system(.body, design: .default))
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "arrow.up.and.down")
                            .foregroundColor(.orange)
                        Text("Content Height: \(Int(contentHeight))px")
                            .font(.system(.body, design: .default))
                        Spacer()
                    }
                }
            }
            .padding()
            .background(Color.orange.opacity(0.1))
            .cornerRadius(10)
    }
    
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    BannerSwiftUIView()
                }
                .padding()
            }
            .navigationTitle("Banners")
        }
    }
    
}

#Preview {
    ContentView()
}
