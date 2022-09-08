//
//  MainDatasource.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit

final class MainDatasource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // TODO: - 추후 레포 설정 되면 변경 예정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    // TODO: - 추후 레포 설정 되면 변경 예정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reusableIdentifier,
                                     for: indexPath) as? MainCollectionViewCell
        else { return UICollectionViewCell() }
        
        let dish = DishDTO(
            detailHash: "H72C3",
            image: "http://public.codesquad.kr/jk/storeapp/data/soup/28_ZIP_P_1003_T.jpg",
            alt: "한돈 돼지 김치찌개",
            deliveryType: [.earlyDelivery, .nationalPost],
            title: "한돈 돼지 김치찌개",
            bodyDescription: "김치찌개에는 역시 돼지고기",
            originPrice: "9,300원",
            reducedPrice: "8,370원",
            eventBadge: [.eventSpecialPrice, .luanchingSpecialPrice, .mainSpecialPrice]
        )
        
        cell.setup(dish)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: UIScreen.main.bounds.width, spacing: LayoutConstant.spacing)
        return CGSize(width: width, height: LayoutConstant.cellHeight)
    }
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 1
        let totalSpacing: CGFloat = (2 * spacing) + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return finalWidth - 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = itemWidth(for: UIScreen.main.bounds.width, spacing: LayoutConstant.spacing)
        return CGSize(width: width, height: LayoutConstant.sectionHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView
                .dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: MainCollectionReusableView.reusableIdentifier,
                    for: indexPath) as? MainCollectionReusableView
        else { return UICollectionReusableView() }
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            headerView.setup(by: indexPath.section)
        default:
            assert(false)
        }
        return headerView
    }

}
