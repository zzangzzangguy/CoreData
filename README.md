
# CoreData

### CoreData를 사용하기 위해서는 프로젝트 생성시에 Use Core Data를 체크하면 되지만 Userdefaults 로 작업한 프로젝트를 CoreData 로 변환하는 과정을 담고자 중간에 추가해 주었다.

## 코어데이터란 ?

<img width="692" alt="Coredata 공문" src="https://github.com/zzangzzangguy/codingclub/assets/122965360/6458798b-9953-43f1-9942-ba86384e8c5e">


이전에 진행한 과제에서는 데이터 저장방식을 Userdefaults 를 줄곧 사용했다
CoreData 를 사용해보긴 했지만.. 이해하는과정에 있어 힘들어 놔두고 있던 네놈.. 오늘에서야 **박살** 내준다

## Userdefaults Vs CoreData

### Userdafaults

- UserDefaults는 앱의 설정과 같은 간단한 데이터를 저장하기에 적합한 반면, 코어데이터는 복잡하고 큰 데이터를 저장하기에 적합하다.
- 간단하고 가볍다! 주로 설정 값이나 간단한 사용자 정보와 같이 작은 양의 데이터를 저장하는 데 적합.
- 작은 양의 데이터만 저장할 수 있으며 복잡한 데이터 구조를 저장하기에는 부적합 하다

### CoreData

- 
- 복잡한 데이터 구조를 저장할수 있음, 관계형 데이터베이스 모델을 사용하여 데이터를 구성할수 있다
- 데이터를 검색하고 필터링하는데 효율적!
- 데이터를 영구적으로 저장하고 관리
- 대규모 데이터베이스 및 복잡한 데이터 모델에 적합

### **언제 어떤 것을 사용해야 할까요?**

- **UserDefaults를 사용해야 하는 경우:** 간단한 설정 값, 사용자 기본 설정 및 작은 양의 데이터를 저장할 때 유용. 예를 들어 사용자 언어 설정, 푸시 알림 설정 등이 이에 해당한다.
- **CoreData를 사용해야 하는 경우:** 복잡한 데이터 구조를 관리하거나 대규모 데이터베이스를 저장하고 검색해야 할 때 CoreData를 사용해야 한다. 예를 들어 앱의 데이터베이스, 사용자가 생성한 콘텐츠, 오프라인 데이터 동기화 및 복잡한 쿼리를 실행해야 하는 경우에 적합.

또한 CoreData는 데이터를 관리하고 영구 저장하는 데 중요한 역할을 합니다. UserDefaults는 주로 간단한 설정 및 사용자 기본 설정을 처리하는 데 사용됩니다. 앱의 요구 사항과 데이터 크기에 따라 두 가지 방법 중 하나를 선택하게 됩니다.

https://github.com/zzangzzangguy/codingclub/assets/122965360/f2b65cf1-1b87-489b-9806-edb339f4c240

[command] + [n] 또는 [file] - > [new] - > [File..] 로 CoreData 의 Model 생성

<img width="242" alt="스크린샷 2023-09-18 오후 7 35 27" src="https://github.com/zzangzzangguy/codingclub/assets/122965360/3f35b760-71c9-4537-a12c-0a190e82bcab">

- 확장자에 파일이 추가되었음을 확인!
    
    ![스크린샷 2023-09-20 오후 4.57.29.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/79fc6158-622f-41df-b4d6-d39b49b45424/4a5e46d7-a715-4fd1-827f-bf2a9362ad88/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-09-20_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_4.57.29.png)
    

~~Relation ship 을 맺음으로서~~ 

Entities랑 Attributes 입력 해주면 NSManagedObject subclass를 생성해줘야 한다 하지만 
 그 전에 inspector에서 설정할 부분이 있다.

클래스를 설정하기 전에 Codegen 이란 ? 

→ Codegen은 **Entity에 대한 Class 선언을 자동으로 만들어주는 옵션을 설정하게 해준다**.

먼저 

1. **Manual/None (수동 또는 없음)**:
    - 이 옵션을 선택하면 Xcode는 Core Data 엔터티와 관련된 클래스를 자동으로 생성하지 않는다
    - 개발자가 직접 엔터티와 관련된 클래스를 작성해야 함...
    - 주로 Objective-C 환경에서 사용하며, Swift에서는 거의 사용하지 않습니다.
2. **Class Definition (클래스 정의)**:
    - 이 옵션을 선택하면 Xcode가 Core Data 엔터티마다 관리 객체 클래스를 자동으로 생성합니다.
    - 이 클래스들은 엔터티의 속성을 반영하고 데이터에 쉽게 접근하고 수정할 수 있는 메서드를 제공합니다.
    - Swift 애플리케이션에서 일반적으로 사용됩니다.
3. **Category/Extension (카테고리/확장)**:
    - 이 옵션을 선택하면 Xcode가 클래스 정의를 생성하지 않고, 대신 Core Data 엔터티에 대한 확장(extension)을 생성합니다.
    - 기존 클래스에 추가 메서드 및 속성을 확장하여 Core Data 관리 객체를 사용합니다.
    - 기존 클래스를 확장하는 방식으로 Core Data 관리 객체를 사용할 때 유용합니다.

**가장 중요한 것은 "Class Definition" 옵션입니다.** 이 옵션을 선택하면 Xcode가 Core Data 엔터티와 관련된 클래스를 자동으로 생성해주어, 엔터티와 관련된 데이터를 처리하기 훨씬 쉽게 만들어줍니다. 이 방식은 Swift 애플리케이션에서 가장 많이 사용되며, 대부분의 상황에서 추천됩니다.

![스크린샷 2023-09-20 오후 5.34.19.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/79fc6158-622f-41df-b4d6-d39b49b45424/cf454c97-1bde-45cc-a633-9a7d87fbeb5d/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-09-20_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_5.34.19.png)

**NSManagedObject 클래스 생성**:


- 엔터티에 대한 관리 객체 클래스를 생성한다 Editor 메뉴에서 "Create NSManagedObject Subclass"를 선택하여 클래스를 자동으로 생성 할수 있음

## MVC Vs MVVM 비교

MVC와 MVVM은 다음과 같은 차이점이 있습니다.

### MVC (Model-View-Controller):

- **Model**: 데이터와 비즈니스 로직을 담당합니다.
- **View**: 사용자 인터페이스를 표시하고 사용자 입력을 처리합니다.
- **Controller**: Model과 View 사이의 중재 역할을 수행하며 사용자 입력을 처리하고 Model을 업데이트합니다.

### MVVM (Model-View-ViewModel):

- **Model**: 데이터를 나타내는 모델 및 비즈니스 로직을 포함합니다.
- **View**: 사용자 인터페이스를 구성하며 ViewModel과 데이터 바인딩을 통해 표시 내용을 업데이트합니다.
- **ViewModel**: View에 필요한 데이터를 제공하고 사용자 입력을 처리합니다.

MVVM은 View와 ViewModel 간의 느슨한 결합을 통해 테스트 및 유지보수를 더 쉽게 만들 수 있습니다.

