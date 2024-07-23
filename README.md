# 팁 계산기

## UI 구조
<img width="295" alt="스크린샷 2024-07-23 오후 7 25 02" src="https://github.com/user-attachments/assets/8aaa69a6-573c-40ac-b61d-57c9757dfaa8"><img width="281" alt="스크린샷 2024-07-23 오후 7 26 04" src="https://github.com/user-attachments/assets/a6766af4-f04b-4ab0-ad28-f6f9ebc0ebec">

## UI 구현 디테일

### `LabelFactory`
- Label 객체를 생성해서 사용할 일이 많은데, 좀 더 코드 중복을 최소화하고 가독성을 높일 방법이 없을까?
  - -> `LabelFactory`에서 build 타입 메서드를 만들어서 전역적으로 사용
- 장점
  - 필요한 설정만 지정하면 되므로 `코드 중복 감소`
  - `backgroundColor: UIColor = .clear` 처럼 기본값 제공이 가능해져서 코드를 더 간결하게 만들어준다.
  - UILabel의 기본 스타일을 변경해야 할 때 build 메서드만 수정하면 되기 때문에 `유지보수에 용이`하다.
```swift
struct LabelFactory {
    
    static func build(
        text: String?,
        font: UIFont,
        backgroundColor: UIColor = .clear,
        textColor: UIColor = ThemeColor.text,
        textAlignment: NSTextAlignment = .center
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.textAlignment = textAlignment
        return label
    }
}
```

### `CustomView`
<img width="78" alt="스크린샷 2024-07-24 오전 12 07 12" src="https://github.com/user-attachments/assets/820c6ddb-43ca-41cb-91ad-8e8e6b7247f1">
<img width="83" alt="스크린샷 2024-07-24 오전 12 07 18" src="https://github.com/user-attachments/assets/8d0ce355-c911-4cb7-820d-9001d6477543">
<img width="79" alt="스크린샷 2024-07-24 오전 12 07 25" src="https://github.com/user-attachments/assets/24db1836-7467-4666-af28-af2d4ac162fe">

- 위 사진처럼 비슷한 형식의 UI를 반복적으로 만들어야하는데 효율적으로 UI를 짤 방법이 없을까?
-  -> `CustomView`로 따로 HeaderView를 구현해서 재사용하는 방향으로 해결
-  장점
    - 하나의 CustomView를 여러 곳에서 `재사용`이 가능하다.
    - 복잡한 UI를 하나의 커스텀 뷰로 묶어서 사용하기에 `코드가 간결`해진다.
    - 변경 사항이 있을 시 CustomView만 수정하면 되기에 `유지보수에 용이`하다.
```swift
class HeaderView: UIView {
    
    private let topLabel = {
        LabelFactory.build(
            text: nil,
            font: ThemeFont.bold(ofSize: 18)
        )
    }()
    
    private let bottomLabel = {
        LabelFactory.build(
            text: nil,
            font: ThemeFont.regular(ofSize: 16)
        )
    }()
    
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topSpacerView,
            topLabel,
            bottomLabel,
            bottomSpacerView
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = -4
        return stackView
    }()
/* 생략 */
}
```
