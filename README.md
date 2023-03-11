
# SwiftAnimation_Tuist

기존 SwiftAnimation에 Tuist를 도입한 프로젝트 입니다.  
프로젝트 도입기는 https://sm-ios-story.tistory.com/36 에 써 있습니다. 

Jenkins를 통한CI 적용기도 추가되었습니다.   
Jenkins 도입기는 https://sm-ios-story.tistory.com/47에 기술되어 있습니다.   


프로젝트 구조 
=======
![Alt text](https://user-images.githubusercontent.com/39114237/218329029-8f19ad21-baa7-4865-a879-d23f88ecf852.png)


Loadings
=======
|SpinningLoading|SpiralLoading|
|---|---|
|<img src="https://user-images.githubusercontent.com/39114237/216038550-0430140f-a648-478d-98a6-f5e635bd203d.gif" width="200" height="400"/>|<img src="https://user-images.githubusercontent.com/39114237/216038311-4b7ed79c-cefa-4b7a-aead-e99e53e1fae7.gif" width="200" height="400"/>|

CALayers와 CAAnimations를 이용하여 만들어 봤습니다.


CardTransition
=======
<img src="https://user-images.githubusercontent.com/39114237/216034848-4febc1e7-730f-48b7-a957-177fc484517d.gif" width="200" height="400"/>

앱스토어 clone 앱입니다.  
UIViewControllerAnimatedTransitioning와 UIViewControllerTransitioningDelegate를 이용하여 만들었습니다.



OverLappingCollectionView
=======
<img src="https://user-images.githubusercontent.com/39114237/216813529-edb2b57e-437b-474f-8f33-15fa9296235b.gif" width="200" height="400"/>

29CM 앱 메인 화면에 있는 배너 클론앱입니다.  
화면중앙에 나오는 셀의 이미지를 CollectionViewBackgroundView로 옮기고 해당 셀의 UIImageView는 isHidden=true로 하는 형태로 구현하였습니다.  
CGAffineTransform을 활용하여 라벨 애니메이션 효과를 주었습니다.



FluidSwipeBackView
=======
<img src="https://user-images.githubusercontent.com/39114237/223111348-208513a7-bce3-4adb-a532-281dddb8d627.gif" width="200" height="400"/>

PanGesture와 UIBezierPath 사용하여 애니메이션효과를 주었으며, UINavigationControllerDelegate와 UIAnimationTransitionDelegate   
등을 사용하여 Custom Transition Animation을 만들어 보았습니다.   

