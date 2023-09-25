//
//  FormPhotoPicker.swift
//  Tombll
//
//  Created by Yusuf Tekin on 21.09.2023.
//

import AVFoundation
import UIKit
import YPImagePicker

// FormPhotoPicker sınıfı
open class FormPhotoPicker: FormInputView {
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            PhotoCollectionCell.registerWithNib(collectionView)
        }
    }

    override public var title: String? {
        get {
            titleLabel?.text
        }
        set {
            titleLabel?.text = newValue
            titleLabel?.isHidden = newValue == nil
        }
    }

    var selectedMediaItems: [YPMediaItem]?
    public var didSelectItem: (_ item: YPMediaItem) -> Void = { _ in }

    override public var value: Any? {
        get {
            return selectedMediaItems
        }
        set {
            guard let newValue = newValue as? [YPMediaItem] else { return }
            selectedMediaItems = newValue
        }
    }

    func startMediaPicker() {
        let picker = YPImagePicker(YPImagePicker.postPickerConfig, preselectedItems: selectedMediaItems ?? [])
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if !cancelled {
                self.selectedMediaItems = items
                self.collectionView.reloadData()
                self.layoutSubviews()
            }
            picker.dismiss(animated: true, completion: nil)
        }
        parentViewController?.present(picker, animated: true)
    }

    open override func getDefaultHeight() -> CGFloat {
        return 136
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        heightConstraint?.constant = getDefaultHeight()
//        superview?.layoutSubviews()
//    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
    }

    open override func showValidation() {
        guard let errorMessage = errorMessage else { return }
    }
}

extension FormPhotoPicker: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 104)
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.className, for: indexPath) as! PhotoCollectionCell
        cell.imageView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        cell.playIcon.tintColor = UIColor(white: 1, alpha: 1)
        if indexPath.row == 0 {
            cell.playIcon.image = UIImage(systemName: "plus.circle")
            cell.playIcon.isHidden = false
            return cell
        }
        cell.imageView.isHidden = false
        if let item = selectedMediaItems?[indexPath.row - 1] {
            switch item {
            case let .photo(photo):
                cell.imageView.image = photo.image
                cell.playIcon.isHidden = true
            case let .video(video):
                cell.imageView.image = video.thumbnail
                cell.playIcon.tintColor = UIColor(white: 1, alpha: 1)
                cell.playIcon.backgroundColor = UIColor(white: 0, alpha: 0.2)
                cell.playIcon.isHidden = false
                print(video)
            }
        }
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            startMediaPicker()
        } else {
            if let item = selectedMediaItems?[indexPath.row - 1] {
                didSelectItem(item)
            }
//            let imagePage = MediaPageViewController(mediaItems: postModel?.selectedMediaItems, initialPageIndex: indexPath.row - 1)
//            imagePage.modalPresentationStyle = .fullScreen
//            parentViewController?.navigationController?.pushViewController(imagePage, animated: true)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (selectedMediaItems?.count ?? 0) + 1
    }
}

extension UICollectionViewCell {
    static func registerWithNib(_ collectionView: UICollectionView) {
        collectionView.register(Self.nib, forCellWithReuseIdentifier: Self.className)
    }
}

// extension YPMediaItem {
//    var ext: String {
//        switch self {
//        case .photo:
//            return "jpg"
//        case .video:
//            return "mp4"
//        }
//    }
//
//    var fileModel: FileModel? {
//        guard let data = contentData else { return nil }
//
//        return FileModel(data: data, ext: ext, size: size)
//    }
//
//    var size: CGSize? {
//        switch self {
//        case let .photo(photo):
//            return photo.image.size
//        case let .video(video):
//            return getVideoResolution(Url: video.url)
//        }
//    }
//
//    var contentData: Data? {
//        switch self {
//        case let .photo(photo):
//            return photo.image.jpegData(compressionQuality: 200)
//        case let .video(video):
//            return try? Data(contentsOf: video.url)
//        }
//    }
//
//    var fileUrl: URL? {
//        switch self {
//        case let .video(video):
//            return video.url
//        default:
//            return nil
//        }
//    }
// }

extension YPImagePicker {
    static var postPickerConfig: YPImagePickerConfiguration {
        var config = YPImagePickerConfiguration()
        config.onlySquareImagesFromCamera = false
        config.albumName = "Tombulling"
        config.startOnScreen = YPPickerScreen.library
        config.screens = [.library, .photo, .video]
        config.targetImageSize = YPImageSize.cappedTo(size: 800)
        config.maxCameraZoomFactor = 10.0

        config.colors.assetViewBackgroundColor = .red

        config.library.isSquareByDefault = false
        config.library.mediaType = YPlibraryMediaType.photoAndVideo
        config.library.maxNumberOfItems = 10
        config.library.preSelectItemOnMultipleSelection = true

        config.video.compression = AVAssetExportPresetMediumQuality
        config.video.fileType = .mp4

        config.gallery.hidesRemoveButton = false
        return config
    }

    convenience init(_ config: YPImagePickerConfiguration, preselectedItems: [YPMediaItem] = []) {
        var tempConfig = config
        tempConfig.library.preselectedItems = preselectedItems
        self.init(configuration: tempConfig)
    }
}

// func fileType(from data: Data) -> String? {
//    if let uti = UTTypeCreatePreferredIdentifierForTag(
//        kUTTagClassMIMEType,
//        "application/octet-stream" as CFString,
//        nil
//    )?.takeRetainedValue() {
//        return uti as String
//    }
//
//    return nil
// }
//
// struct FileModel {
//    var data: Data
//    var ext: String
//    var size: CGSize?
// }
