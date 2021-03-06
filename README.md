# HelloWorld-PC9801
OSなしのPC-98シリーズ(以下PC98)で実行できるHelloWorldブートローダです。  
ついでにBeepを鳴らすおまけ付きです。  
<img src="https://i.imgur.com/bCJ6Ma6.jpg" width="300">

## 実行するには
***hello98.TFD*** をフロッピーに書き込めばPC98で使えます。  
しかし、ほとんどの人がPC98本体を持っていないと思うので、エミュレータをおすすめします。  
例えば、
[「Neko Project II」](https://www.yui.ne.jp/np2/)
であれば、フロッピードライブに ***hello98.TFD*** を設定して起動すればHelloWorld出来ます。
>「Neko Project II」の導入についてはこちら  
[インストールガイド [導入編]](http://www.retropc.net/yui/np2inst/install.html)

### 実機で実行するなら
PC98実機を持っている酔狂な方は以下の手順で実行できます。
まず、フロッピーディスク(以下FD)をPC98でフォーマットします。  
次に、[「Read/Write FD」](https://www.vector.co.jp/soft/win95/util/se130037.html)などで ***hello98.TFD*** をFDにバイナリ書き込みします。  
この時注意しなければいけないのが、書き込みを行うFDドライブは[「3モードフロッピーディスクドライブ」](https://ja.wikipedia.org/wiki/3%E3%83%A2%E3%83%BC%E3%83%89%E3%83%95%E3%83%AD%E3%83%83%E3%83%94%E3%83%BC%E3%83%87%E3%82%A3%E3%82%B9%E3%82%AF%E3%83%89%E3%83%A9%E3%82%A4%E3%83%96)というものでなければなりません。  
手に入りやすいものであれば以下のようなものがあります。
>Amazon  
[BUFFALO FD-USB(USB接続3.5インチフロッピーディスクドライブ)](https://www.amazon.co.jp/%E3%83%90%E3%83%83%E3%83%95%E3%82%A1%E3%83%AD%E3%83%BC-FD-USB-BUFFALO-USB%E6%8E%A5%E7%B6%9A3-5%E3%82%A4%E3%83%B3%E3%83%81%E3%83%95%E3%83%AD%E3%83%83%E3%83%94%E3%83%BC%E3%83%87%E3%82%A3%E3%82%B9%E3%82%AF%E3%83%89%E3%83%A9%E3%82%A4%E3%83%96/dp/B00008B49H)

あとはそのFDをPC98に差し込んで起動するとHelloWorld出来ます。

___
## ビルド方法
***make.bat*** を実行するとビルドされます。  
※この時、***nask.exe*** を常に管理者権限で実行するように設定していないとエラーになります。　　
### ビルドの流れ
・***nask.exe*** はNASM風のアセンブラです。  
・***hood*** は今回のプログラムにはあまり関係ないFAT12フォーマットのおまじない（論理ボリューム）バイナリです。  

やってることは以下のことだけです。  
1. ***hello98.nas*** を ***hello98.sys*** に ***nask.exe*** でアセンブリします。  
1. ***hello98.sys*** と ***hood*** をバイナリ結合して ***hello98.TFD*** とします。
___
## プログラムについて
プログラムのソースは ***hello98.nas*** のみです。  
中身の具体的な説明はほとんどソースコードのコメントに書いています。  
コメントについている *(ハード-001)* , *(BIOS-001)* などは、「PC‐9800シリーズ テクニカルデータブック」の参照ページです。  
>Amazon  
[PC‐9800シリーズ テクニカルデータブック](http://amzn.asia/fC1ne7L)  
[PC‐9800シリーズ テクニカルデータブック〈HARDWARE編〉](http://amzn.asia/1qIUpad)  
[PC‐9800シリーズ テクニカルデータブック〈BIOS編〉](http://amzn.asia/cNXzYsc)

<font size="1" color="#c0c0c0">「興味はあるけど本を買うのはなぁ・・・」って人は書籍名でググるといいことがあるかもしれません。</font>
___
## 謝辞
アセンブラの ***NASK*** は、[「OSASK」](http://wiki.osask.jp/)OSの開発や「30日でできる！ OS自作入門」の著書を行なっている **川合秀実 様** が公開しているものです。  
改変・再配布自由ということでしたのでリポジトリに含ませて頂きました。  
ここに感謝の意を表します。
