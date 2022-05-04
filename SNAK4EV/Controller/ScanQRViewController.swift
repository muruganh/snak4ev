//
//  ScanQRViewController.swift
//  SNAK4EV
//
//  Created by Apple  on 30/03/22.
//

import UIKit
import MercariQRScanner
import AVKit

class ScanQRViewController: BaseViewController {
    
    @IBOutlet weak var txtQRNumber: UITextField!
    @IBOutlet weak var viewScan: UIView!
    var qrScannerView = QRScannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtQRNumber.setLeftPadding(8.0)
        self.setupQRScanner()
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        let vc = Storyboards.Main.instance.instantiateViewController(withIdentifier: "ConnectorSelectionViewController") as! ConnectorSelectionViewController
        vc.qrCode = self.txtQRNumber.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupQRScanner() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setupQRScannerView()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async { [weak self] in
                        self?.setupQRScannerView()
                    }
                }
            }
        default:
            showAlert()
        }
    }

    private func setupQRScannerView() {
        qrScannerView = QRScannerView(frame: self.viewScan.bounds)
        self.viewScan.addSubview(qrScannerView)
        qrScannerView.configure(delegate: self, input: .init(isBlurEffectEnabled: true))
        qrScannerView.startRunning()
    }

    private func showAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let alert = UIAlertController(title: "Error", message: "Camera is required to use in this application", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
}


extension ScanQRViewController: QRScannerViewDelegate {
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print(error)
        qrScannerView.stopRunning()
        DispatchQueue.main.async {
            self.qrScannerView.removeFromSuperview()
            self.setupQRScannerView()
        }
    }

    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        print(code)
        self.txtQRNumber.text = code
        qrScannerView.stopRunning()
        DispatchQueue.main.async {
            self.qrScannerView.removeFromSuperview()
            self.setupQRScannerView()
        }
    }
}
