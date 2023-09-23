//
//  File.swift
//
//
//  Created by Yusuf Tekin on 23.09.2023.
//

import UIKit

class TagCollectionView: UICollectionView {
    private var _tagDelegate: TagCollectionViewProtocol?
    var tagDelegate: TagCollectionViewProtocol {
        get {
            guard let tagDelegate = _tagDelegate else {
                _tagDelegate = TagCollectionViewProtocol()
                return _tagDelegate!
            }
            return tagDelegate
        }
        set {
            _tagDelegate = newValue
        }
    }

    var items: [TagItem] {
        get {
            return tagDelegate.items
        }
        set {
            tagDelegate.items = newValue
            // Önce koleksiyon görünümünü veri kaynağınızı güncelleyerek yenileyin
            
            reloadData()
            // Ardından koleksiyon görünümüne animasyon eklemek için bir blok içinde işlem yapın
            UIView.animate(withDuration: 0.09) {
                //self.alpha = 0.0 // Koleksiyon görünümünü gizleyin (isteğe bağlı)
                self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8) // Küçültme efekti (isteğe bağlı)
                self.transform = CGAffineTransform(translationX: 8, y: 0)
                
                // Bu bloğun içinde koleksiyon görünümünü yenileyin ve istediğiniz animasyonları uygulayın
                self.layoutIfNeeded() // Layout güncellemesini animasyonla yapmak için
                self.alpha = 1.0 // Koleksiyon görünümünü yeniden gösterin (isteğe bağlı)
                self.transform = .identity // Önceki transformu sıfırlayın (isteğe bağlı)
            }
            //reloadData()
        }
    }
    override var semanticContentAttribute: UISemanticContentAttribute {
        get {
            tagDelegate.semanticContentAttribute
        }
        set {
            tagDelegate.semanticContentAttribute = newValue
        }
    }

    var controller: UIViewController?

    func commonInit() {
        register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.className)
        delegate = tagDelegate
        dataSource = tagDelegate
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}
