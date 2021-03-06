; hello98.nas
; Intel記法アセンブラ
; TAB=4
[BITS 16]
[INSTRSET "8086"]
		
; 以下は1.23MBフォーマット(通称: NEC PC-98フォーマット)フロッピーディスクのための記述
; 現在の標準的なFAT12フォーマットとは違うので注意
; 参考までにコメント括弧内に ( PC98 : 現代FAT12 ) 形式で比較を書いた
		
		JMP		entry
		DB		0x90
		DB		"HELLO98"		; ブートセクタの名前を自由に書いてよい（8バイト）
		DW		1024			; 1セクタの大きさ（1024 : 512）
		DB		1				; クラスタの大きさ（1セクタ）
		DW		1				; FATがどこから始まるか（普通は1セクタ目からにする）
		DB		2				; FATの個数（2にしなければいけない）
		DW		192				; ルートディレクトリ領域の大きさ（192 : 普通は224エントリにする）
		DW		1440			; このドライブの大きさ（1440セクタ : 2880セクタ）
		DB		0xfe			; メディアのタイプ（0xfe : 0xf0）
		DW		2				; FAT領域の長さ（2セクタ : 9セクタ）
		DW		8				; 1トラックにいくつのセクタがあるか（8セクタ : 18セクタ）
		DW		2				; ヘッドの数（2にしなければいけない）
		DD		0				; パーティションを使ってないのでここは必ず0
		DD		1440			; このドライブ大きさをもう一度書く
		DB		80,0,0x29		; よくわからないけどこの値にしておくといいらしい
		DD		0xffffffff		; たぶんボリュームシリアル番号
		DB		"HELLO98   "	; ディスクの名前（11バイト）
		DB		"FAT12   "		; フォーマットの名前（8バイト）


;/////////////////////////////
; プログラム本体
;/////////////////////////////
section .text
entry:
		XOR		AX,AX		; レジスタ初期化
		MOV		DS,AX
		MOV		ES,AX
		MOV		SS,AX
		
;-------------------------------------------------
;文字列表示
print:
		MOV		SI,msg		; msg の先頭位置を SI レジスタに設定
		
		;テキストVRAMの番地(0xA0000)をセット
		MOV		AX,0xa000
		MOV		ES,AX
		MOV		BX,0x0000
		
;文字列を1文字ずつテキストVRAMにセットするループ
putloop:
		MOV		AL,[CS:SI]	;[CS]がプログラムの読み込み位置、[SI]がプログラム内での文字の位置。
							;プログラムが主記憶の0x1fc00に読み込まれ、文字がFDの0x65にある場合、文字の位置は主記憶0x1fc65となる
		OR		AL,AL
		JZ		beep		;文字書き込み終わり
		MOV		[ES:BX],AL	;[ES:BX]=(ES*16+BX)、ここではテキストVRAM(0xA0000~)に1文字書き込んでいる
		INC		SI			;SIを1進める
		ADD		BX,2		;テキストVRAMを2進める（1文字2byteのため）
		JMP		putloop
		
;-------------------------------------------------
;ビープ音を鳴らす
beep:
		;タイマとシステムポートの機能を使う。
		
		;I/Oポート 3FDFh にコントロールワードを書き込むことで、
		;タイマのモードを設定することができる。
		MOV		AL,0x76		;コントロールワード0x76 (ハード-119)
		OUT		0x3FDF,AL	;タイマモードを設定
		
		MOV		DX,0x3FDB	;DXにアドレスを入れてからOUTを２回書かないと動作がおかしい
		MOV		AL,0x00		;周波数下位バイト
		OUT		DX,AL		;OUT命令での即値はNGです。例）OUT 0x3FDB,AL
		MOV		AL,0x50		;周波数上位バイト
		OUT		DX,AL
		
		;システムポートCに命令を書き込む (ハード-138)
		MOV		AL,0x06		;スピーカON/OFF命令（仕様で決められている）
		OUT		0x0037,AL	;スピーカON
		
		;こっちはCRT BIOSの機能を使う(BIOS-59)
		;MOV		AH, 0x17
		;INT		0x18	; ブザーON
		
;-------------------------------------------------
;終了
fin:
		HLT				; 何かあるまでCPUを停止させる
		JMP		fin		; 無限ループ

;-------------------------------------------------
;データセクション
section .data
msg:
		DB "Hello world!!"
		DB 0x0
;-------------------------------------------------
		RESB	0x400-$		; 0x400までを0x00で埋める命令
