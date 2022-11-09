////
////  Extension+UIImage.swift
////  MiniAppCore
////
////  Created by Trinh Quang Hiep on 20/09/2022.
////
//
//import Foundation
//import UIKit
//extension UIImage {
//    public enum DataUnits: String {
//        case byte, kilobyte, megabyte, gigabyte
//    }
//    func getSizeIn(_ type: DataUnits)-> Double {
//        guard let data = self.jpegData(compressionQuality: 1) else {
//            return 0.0
//        }
//        var size: Double = 0.0
//        
//        switch type {
//        case .byte:
//            size = Double(data.count)
//        case .kilobyte:
//            size = Double(data.count) / 1024
//        case .megabyte:
//            size = Double(data.count) / 1024 / 1024
//        case .gigabyte:
//            size = Double(data.count) / 1024 / 1024 / 1024
//        }
//        return  size
//    }
//    func caculateScaleImage(maxSizeByte : Int)-> Double{
//        for i in (1...10).reversed(){
//            if let size = self.jpegData(compressionQuality: Double(i)/10.0) {
//                if Double(size.count) <= Double(maxSizeByte){
//                    return Double(i)/10.0
//                }
//            }
//        }
//        return 0.0
//    }
//    func convertImageToBase64String() -> String {
//        return self.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
//    }
//    
//    func getBase64() -> String {
//        let bestCapacity = bestCapacityOfImage(image: self, maxCapacityMegaByte: 5.0)
//        return self.jpegData(compressionQuality: bestCapacity)?.base64EncodedString() ?? ""
//    }
//    
//    private func bestCapacityOfImage(image : UIImage , maxCapacityMegaByte : Double) -> CGFloat {
//        var quality: Double = 1.0
//        while quality > 0 {
//            if getCapacityOfImageMegaByte(image: image, quality: quality) <= maxCapacityMegaByte { // > 2 megabyte
//                return CGFloat(quality)
//            }else{
//                quality = quality - 0.1
//            }
//        }
//        return 0.05
//    }
//    
//    private func getCapacityOfImageMegaByte(image : UIImage , quality: Double) -> Double{
//        let imgData = NSData(data: image.jpegData(compressionQuality: CGFloat(quality))!)
//        let imageSize: Double = Double(imgData.count/1000000) // convert byte -> megabyte
//        return imageSize
//    }
//}
//extension UIImage {
//    func resized(toSize size: CGFloat, isOpaque: Bool = true) -> UIImage? {
//        let width = self.size.width
//        let height = self.size.height
//        let canvas: CGSize
//        if width <= size && height <= size {
//            return self
//        } else if width > height {
//            canvas = CGSize(width: size, height: CGFloat(ceil(size/width * height)))
//        } else {
//            canvas = CGSize(width: CGFloat(ceil(size/height * width)), height: size)
//        }
//        
//        let format = imageRendererFormat
//        format.opaque = isOpaque
//        return UIGraphicsImageRenderer(size: canvas, format: format).image {
//            _ in draw(in: CGRect(origin: .zero, size: canvas))
//        }
//    }
//    
//    func fixOrientation() -> UIImage {
//        guard imageOrientation != .up else { return self }
//        
//        var transform: CGAffineTransform = .identity
//        switch imageOrientation {
//        case .down, .downMirrored:
//            transform = transform
//                .translatedBy(x: size.width, y: size.height).rotated(by: .pi)
//        case .left, .leftMirrored:
//            transform = transform
//                .translatedBy(x: size.width, y: 0).rotated(by: .pi)
//        case .right, .rightMirrored:
//            transform = transform
//                .translatedBy(x: 0, y: size.height).rotated(by: -.pi/2)
//        case .upMirrored:
//            transform = transform
//                .translatedBy(x: size.width, y: 0).scaledBy(x: -1, y: 1)
//        default:
//            break
//        }
//        
//        guard
//            let cgImage = cgImage,
//            let colorSpace = cgImage.colorSpace,
//            let context = CGContext(
//                data: nil, width: Int(size.width), height: Int(size.height),
//                bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0,
//                space: colorSpace, bitmapInfo: cgImage.bitmapInfo.rawValue
//            )
//        else { return self }
//        context.concatenate(transform)
//        
//        var rect: CGRect
//        switch imageOrientation {
//        case .left, .leftMirrored, .right, .rightMirrored:
//            rect = CGRect(x: 0, y: 0, width: size.height, height: size.width)
//        default:
//            rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        }
//        
//        context.draw(cgImage, in: rect)
//        return context.makeImage().map { UIImage(cgImage: $0) } ?? self
//    }
//    
//    func cropOCRImage(frame : CGRect) -> UIImage? {
//
//        guard let cgImage = cgImage else {
//            return nil
//        }
//        let width : Double = Double(cgImage.width) - (frame.minX * 2.0) // tinh width theo hinh anh thuc te
//        let frameCrop = CGRect(x: frame.minX, y: frame.minY, width: width, height: frame.height + 10)
//        guard let newCgImage = cgImage.cropping(to: frameCrop) else {
//            return nil
//        }
//
//        return UIImage(cgImage: newCgImage, scale: scale, orientation: imageOrientation)
//    }
//    
//    func withTintColor(uiColor color: UIColor) -> UIImage {
//        if #available(iOS 13.0, *) {
//            return self.withTintColor(color)
//        } else {
//            let tempImage = self.withRenderingMode(.alwaysTemplate)
//            let imageView = UIImageView(image: tempImage)
//            imageView.tintColor = color
//            return imageView.image ?? UIImage()
//        }
//    }
//}
