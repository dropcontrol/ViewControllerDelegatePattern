# ViewControllerDelegatePattern
View間でのDelegateのパターン。またNavigationLinkを使ったページ遷移のサンプルにもなっている。

## TL;DR

View間で値を渡すパターン。Viewを二つ用意。親から子へ渡すパターンと、子から親へ渡すパターンの2つを実装。値の渡し方は他にもあると思うけど、一番基本的なパターン。

## 親から子へ渡す場合

子であるSecondView.swiftに以下を追加

```
let text: String = "Not Success" //　初期値が必要
```

今回の場合親からNavigation Linkを使って呼び出してるので、destinationに登録したSecondView()の中でtextに文字列を渡している。

```
NavigationLink(
  destination: SecondView(delegate: self, text: "Sucess send message"),
  label: {
    Text("Go to SecondView")
  })
```

delegateについては以下の子から親に渡す場合で説明するが、NavigationLinkのdestination毎に遷移先のViewとそのdelegateを呼び出せる。

## 子から親に値を渡す場合

このパターンはよく使うと思う。delegateパターンで実装している。

1. 子である、SecondView.swiftにdelegateプロトコルを実装する。
```
protocol secondViewDelegate {
    func returnData(text: String)
}
```

```
struct SecondView: View {
    var delegate: secondViewDelegate?
```

2. 親に渡すdelegateプロトコルのファンクションをButtonのaction: で呼び出す。
```
Button(action: {
  self.delegate?.returnData(text: "Success!!")
  self.presentation.wrappedValue.dismiss()
}, label: {
  Text("Try delegate")
})
```

3. 親のContentView.swiftでSecondViewDelegateを追加。またNavigationLinkのdestinationでViewのdelegateをselfに設定する。このタイミングで設定できるのは便利。
```
struct ContentView: View, secondViewDelegate{
```

```
NavigationLink(
  destination: SecondView(delegate: self, text: "Sucess send message"),
```

4. @StateでProperty Wrapperでシステムに状態監視を移譲した変数を登録

```
@State var text: String = "not change yet"
```

5. delegateファンクションでの処理を記述

```
func returnData(text: String) {
  self.text = text
}
```

## NavigationLinkでbackボタンを使わずに戻る

@EnvironmentはSwiftUIの環境変数で、これを使右ことでいろいろと状態の監視や変更ができる。下記をSecondView.swiftに変数を作る。

```
@Environment(\.presentationMode) var presentation
```
これでpresentationModeの環境変数が取得できてるので、

```
Button(action: {
  self.delegate?.returnData(text: "Success!!")
  self.presentation.wrappedValue.dismiss()

```
と言う感じで、`self.presentation.wrappedValue.dismiss()`を呼び出せば画面を閉じることができる。これは他の画面遷移（例えばモーダルビューなど）でも同じ。

といった感じ。

