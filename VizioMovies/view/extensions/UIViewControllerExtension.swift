//
//  UIViewControllerExtension.swift
//  VizioMovies
//
//  Created by Noah Bragg on 8/15/19.
//  Copyright © 2019 Noah Bragg. All rights reserved.
//

import UIKit

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: collectionView.frame.width , height: height + 16 + 68)
    }
}
