# ViewControllerDelegatePattern
ViewControllerでのDelegateのパターン

## TL;DR

ViewController間で値を渡すパターン。Viewを二つ用意。親から子へ渡すパターンと、子から親へ渡すパターンの2つを実装。値の渡し方は他にもあると思うけど、一番基本的なパターン。

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

delegateについては以下の子から親に渡す場合で説明する。

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

3. 親のContentView.swiftでSecondViewDelegateを追加
```
struct ContentView: View, secondViewDelegate{
```

4. @StateでWrapした変数をUIKitに登録

```
@State var text: String = "not change yet"
```

5. delegateファンクションでの処理を記述

```
func returnData(text: String) {
  self.text = text
}
```

といった感じ。

