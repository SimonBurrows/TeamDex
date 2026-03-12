//
//  QRCodeScannerView.swift
//  TeamDex
//
//  Created by Simon Burrows on 12/03/2026.
//

import SwiftUI
import VisionKit

struct QRCodeScannerView: UIViewControllerRepresentable {
    typealias Completion = (Result<String, Error>) -> Void

    let completion: Completion

    func makeCoordinator() -> Coordinator {
        Coordinator(completion: completion)
    }

    func makeUIViewController(context: Context) -> DataScannerViewController {
        let controller = DataScannerViewController(
            recognizedDataTypes: [.barcode(symbologies: [.qr])],
            qualityLevel: .balanced,
            recognizesMultipleItems: false,
            isHighFrameRateTrackingEnabled: false,
            isHighlightingEnabled: true
        )
        controller.delegate = context.coordinator

        do {
            try controller.startScanning()
        } catch {
            completion(.failure(error))
        }

        return controller
    }

    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {}

    static func dismantleUIViewController(_ uiViewController: DataScannerViewController, coordinator: Coordinator) {
        uiViewController.stopScanning()
    }

    final class Coordinator: NSObject, DataScannerViewControllerDelegate {
        let completion: Completion
        private var hasCompleted = false

        init(completion: @escaping Completion) {
            self.completion = completion
        }

        func dataScanner(
            _ dataScanner: DataScannerViewController,
            didAdd addedItems: [RecognizedItem],
            allItems: [RecognizedItem]
        ) {
            guard !hasCompleted else { return }

            for item in addedItems {
                if case .barcode(let barcode) = item,
                   let payload = barcode.payloadStringValue {
                    hasCompleted = true
                    completion(.success(payload))
                    break
                }
            }
        }

        func dataScanner(
            _ dataScanner: DataScannerViewController,
            becameUnavailableWithError error: Error
        ) {
            guard !hasCompleted else { return }
            hasCompleted = true
            completion(.failure(error))
        }
    }
}

extension QRCodeScannerView {
    static func makeStartedController(
        delegate: DataScannerViewControllerDelegate
    ) -> DataScannerViewController {
        let controller = DataScannerViewController(
            recognizedDataTypes: [.barcode(symbologies: [.qr])],
            qualityLevel: .balanced,
            recognizesMultipleItems: false,
            isHighFrameRateTrackingEnabled: false,
            isHighlightingEnabled: true
        )
        controller.delegate = delegate
        try? controller.startScanning()
        return controller
    }
}
