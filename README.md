# OnlineBanchan App

- 소개
    - 온라인 반찬 어플리케이션을 가정한 토이 프로젝트
    - 네트워크 리퀘스트에 중점
    - UIScrollView 작업
    - RxSwift 를 통한 비동기 작업
    - MVVM + Clean Architect(을 염두에 둠)

- 작업 기간
    - 2022.09.07~2022.09.21(2주)

- 사용 라이브러리
    - SnapKit
    - RxSwift ...
    - Toaster


## 데모 

### MainView 

https://user-images.githubusercontent.com/50472122/191678132-d13170d0-a1a3-4499-937c-b893703fcd3b.mov

### DetailView 

https://user-images.githubusercontent.com/50472122/191678177-4dc93a0f-ac41-4fb5-997d-3730e6add3cb.mov

### Payment

https://user-images.githubusercontent.com/50472122/191678229-ff830a20-8e92-4d53-a035-470b96311d6e.mov


![](https://i.imgur.com/1CPIuxh.png)
- SlackAPI 사용
- POST 메서드

## 고민과 해결 

### 1. Section 별로 뷰를 업데이트
- 처음에 시스템을 모든 item이 업데이트 되면 `collectionView.reloadData` 를 하였으나, 섹션별 업데이트가 요구사항이여서 변경
- 섹션별로 Request Api 가 달라서, 섹션별 업데이트가 합당한 상황이였음.
- 문제는 Request의 결과로 온 result가 어떤 섹션을 대표하는지에 대한 정보를 얻을 수 가 없었음
- **찾은 방법은 섹션을 대표할 타입을 만들어서, 해당 타입을 바탕으로 RequestAPI를 만들어내게끔 수정하였음**
```swift
enum CategoryType: Int, CaseIterable {
    case main
    case soup
    case side
    
    var api: OnbanAPI {
        switch self {
        case .main:
            return .requestMainDish
        case .soup:
            return .requestSoup
        case .side:
            return .requestSideDish
        }
    }
    
    var index: Int { self.rawValue }
}

```

### 2. Coordinator 패턴 적용을 꾀함 
- 뷰 컨트롤러가 화면 전환 역할을 맡는 것을 피하고자 
Coordinator 가 화면 전환을 담당하고 DIContainer 가 객체 생성을 담당
    - 기존 직접 생성 방식으로 전환하였을 때는 발생하지 않던 오류가 생겼음
- Rx 코드와 MVVM 구조에서 발생하는 오류들을 디버깅하는데에 어려움이 있었다. 
- 문제 해결을 위해 천천히 화면전환이 트리거되는 메서드부터 Coordinator 까지 오기의 흐름을 정리해보았다. 
- 문제는 MainViewModel이 FlowCoordinator를 알수가 없다는 것이다.(싱글톤 제외)
- 이 때 등장한 개념이 **`함수는 일급객체`** 이다. 
- CollectionView(didSelectedItemAt) 
    - ->MainViewController
    - -> MainViewModel 
    - -> MainViewModelAction 
    - -> VM 생성시 FlowCoordinator에서 주입받은 Action 메서드 실행
- **뷰모델에게 Action을 전달하면서 함수도 일급객체여서 변수처럼 전달할 수 있다는 말의 위력을 실감하였다. **
    - `() -> Void` 를 전달하는데 이를 어떻게 Rx 코드로 변환할 수 있을지 고민이다. 

### 3. Cell을 표시하는 DataSource가 ViewModel을 소유하고 있어도 되는가에 대한 문제
- 뷰 모델을 VC에 놓아야할지, 실질적으로 Cell 이 그려지는 DataSource에 두어야할지 확신이 없었다. 
- 그러던차에 동료의 권유로 MVVM 과 Clean Architect 를 적용한 프로젝트를 참고하였다. 
- 여기선 VC 가 VM을 소유하고, Cell 마다 CellViewModel을 소유했다. 
