# 👍🏻 GoodJob Toy Project

## 개요

이 시대를 살아가는 청년들을 위한 채용 구직 관리 시스템을 iOS 앱으로 개발해보았습니다. 구직자가 마음에 드는 채용 공고를 스크랩하고 채용 프로세스의 진행 과정에서 경험을 회고할 수 있도록 구현되었습니다. 취준생의 가벼운 주머니 사정을 고려해 앱 스토어에서 무료로 배포하고 있습니다.

<p align="center">
    <img src="https://github.com/smart8612/GoodJob/assets/25794814/783e5732-6a0e-40ad-8499-4a797083e14c" height="150" alt="GoodJob Logo Image"/>
</p>


## 프로모션

![GoodJob features describe image](https://github.com/smart8612/GoodJob/assets/25794814/260d965a-670e-4eee-bd79-d0242ddb61cc)

### 주요기능
* 채용공고 스크랩

  > 지원하고 싶은 채용 공고를 스크랩 해보세요. 스크랩한 공고의 진행 상태도 한눈에 확인 가능합니다.

* 채용지원 현황 관리

  > 채용 공고와 연계하여 지원 이력을 관리해보세요. 전형별 진척도와 경험 회고를 한번에 기록 가능합니다.

* 채용 전형별 경험 기록

  > 전형별 세부 경험과 합격 여부를 기록해보세요. 회고하며 앞으로의 구직 활동을 계획 가능합니다.



## 사용방법

### 다운로드
최소 요구사양을 충족하는 단말기에서 다음의 QR 코드를 스캔하거나 "App Store에서 다운로드 하기" 버튼을 클릭하여 서비스 이용이 가능합니다.

<p align="center">
  <img src="https://github.com/smart8612/GoodJob/assets/25794814/50c15bac-e2e2-41df-873d-2746ab0ce997" height="100" alt="AppStore Download qr-code" />
  
  <a href="https://apps.apple.com/kr/app/goodjob-%ED%94%8C%EB%9E%98%EB%84%88-%EC%B1%84%EC%9A%A9%EC%A7%80%EC%9B%90%EA%B4%80%EB%A6%AC/id6477273615?l=en-GB"> 
    <img src="https://github.com/smart8612/GoodJob/assets/25794814/e12726cb-0e09-499b-ad33-12bcc9d5c054" height="100" alt="Download_on_the_App_Store_Badge"/>
  </a>
</p>

### 최소 요구사양

* iPhone

  > Requires iOS 16.0 or later

* iPad

  > Requires iPadOS 16.0 or later

* Mac

  > Requires macOS 13.0 or later and a Mac with Apple M1 chip or later

* Apple Vision

  > Requires visionOS 1.0 or later



## ⚒️ 기술

기술 블로그 [singularis7's Life Note](https://singularis7.tistory.com/)에서 ｢3주만에 앱스토어에 앱 출시하기｣를 연재하며 GoodJob 프로젝트의 개발 과정을 문서화하여 관리하고 있습니다. 참조 링크를 클릭하시어 개별 개발 단계에서 세부 경험의 확인이 가능합니다.

### 1️⃣ 기획과 디자인

* 주요 기술: `#객체지향설계` `#관계형데이터모델링` `#UX디자인` `#Figma`
* 🔗 참조: [｢3주만에 앱스토어에 앱 출시하기 - 1부 기획과 디자인｣](https://singularis7.tistory.com/116)

> 취업 준비의 어려움을 해결해보자는 목표로 애플 개발자 포럼의 Develop in Swift App Design Workbook을 활용해 신규 앱을 기획합니다. 디자인 도구 Figma를 활용해 관계형 데이터 모델을 설계하고 앱의 탐색 구조 등의 사용자 경험을 설계합니다. 이로써 객체 지향 데이터 모델과 GUI 설계를 도출합니다.



### 2️⃣ 작업 관리

* 주요 기술: `#Git` `#GitHub` `#프로젝트 통합 관리`
* 🔗 참조: [｢3주만에 앱스토어에 앱 출시하기 - 2부 작업 관리｣](https://singularis7.tistory.com/117)

> GitHub로 프로젝트의 개발 흐름을 관리하는 방식을 소개합니다. 프로젝트에서 생성한 작업을 이슈로 전환하여 개발 브랜치를 따온 뒤에 신규 개발 내용을 PR을 통해 Main 브랜치에 병합하는 내용을 담았습니다. 이로써 작업 흐름 간의 통합된 관리 경험을 구축합니다.



### 3️⃣ 프로토타이핑

* 주요 기술: `#애자일개발` `#HIG` `#UIKit` `#Xcode` `#Interface Builder` `#Storyboard`
* 🔗 참조: [｢3주만에 앱스토어에 앱 출시하기 - 3부 프로토타이핑｣](https://singularis7.tistory.com/118)

> 애자일 개발 철학을 지향하며 빠른 프로토타이핑과 디자인 검증을 시도합니다. 기획과 디자인 단계에서 산출한 객체지향 모델을 활용하여 화면 구조를 도출합니다. Xcode의 인터페이스 빌더와 스토리보드로 화면을 배치하고 실제 단말기에서 실행하며 디자인을 평가합니다. HIG를 준수하도록 사용자 경험 개선 과정을 반복합니다. 이로써 익숙한 사용자 경험을 가진 인터페이스 설계를 도출합니다.



### 4️⃣ 모델 설계 및 개발

* 주요 기술: `#Swift` `#Core Data` `#Clean Architecture`
* 🔗 참조: [｢3주만에 앱스토어에 앱 출시하기 - 4부 설계 및 데이터 모델 개발｣](https://singularis7.tistory.com/119)

> 기획과 디자인 단계에서 도출한 관계형 데이터 모델로 Core Data 프레임워크의 엔티티 모델을 구축합니다. 전단부 도메인과 후단부 영속성 엔티티 모델의 변동사항 유지관리 편의성을 고려하고자 클린 아키텍처를 도입하고 Swift로 구현 및 검증해봅니다. 이로써 관계형 데이터 모델 규칙에 기반한 사용자 데이터의 영속성 관리 기능을 도입합니다.



###  5️⃣ 사용자 인터페이스 개발

* 주요 기술: `#Swift` `#SwiftUI` `#MVVM` `#UIKit 상호운용성` `#Localization`
* 🔗 참조: [｢3주만에 앱스토어에 앱 출시하기 - 5부 사용자 인터페이스 개발｣](https://singularis7.tistory.com/120)

> SwiftUI View와 데이터 바인딩 기술을 활용하여 MVVM 구조로 사용자 인터페이스를 구현합니다. Swift로 앱 Navigation 구조를 열거형 추상화합니다. 데이터 CRUD 등 자주 사용되는 View를 템플릿으로 분리합니다. Shape 프로토콜로 커스텀 View를 구현합니다. UIKit 상호운용성으로 피드백 기능을 구현하고 앱내 스트링 자원을 국제화합니다. 이로써 손쉽게 사용자 인터페이스를 구현하고 다양한 배경의 사용자가 이용가능한 앱을 개발합니다.



### 6️⃣ 코드 아키텍처 설계

* 주요 기술: `#Swift` `#Middleware` `#Clean Architecture` `#단방향데이터흐름` `#Delegation`
* 🔗 참조: [｢3주만에 앱스토어에 앱 출시하기 - 6부 Business 계층 개발｣](https://singularis7.tistory.com/121)

> 하나의 거대한 컨트롤러 구조에서 문제점을 도출하여 리팩토링을 통해 개선합니다. 코어 데이터와 유즈 케이스의 독립적인 병행 개발이 가능하도록 Repository 패턴을 도입하여 비즈니스 규칙을 관리하는 미들웨어를 개발합니다. 코어 데이터의 옵저버 객체를 Delegation 패턴으로 View와 연동하여 단방향 데이터 흐름을 구현합니다. 이로써 유지관리성을 높여가며 코어데이터와 사용자 인터페이스를 연동합니다.



### 7️⃣ 앱 스토어 배포

* 주요 기술: `#Appstore Connect` `#Keynote` `#TestFlight` `#Distribute` `#Xcode Cloud`
* 🔗 참조: [｢3주만에 앱스토어에 앱 출시하기 - 7부 앱스토어 배포｣](https://singularis7.tistory.com/122)

> 애플 배포 가이드와 사용자 인터페이스 가이드라인을 참조하여 배포에 필요한 아이콘 등의 에셋를 키노트로 디자인 합니다. 앱스토어 커넥트에서 앱을 등록하기위한 홍보문구와 개인정보 관리 정책을 세워봅니다. Xcode에서 앱 바이너리를 직접 배포하거나 Xcode Cloud로 CI/CD 파이프라인을 구축하여 봅니다. 이 때 제3자 라이브러리의 토큰 정보를 Private하게 관리하는 방법을 전파합니다.



## ⓒ 저작권

Copyright ©️ 2024. Han Jeong Taek all rights reserved. \<smart8612@gmail.com>

Distributed under the `MIT License`. See `LICENSE.txt` for more information.
