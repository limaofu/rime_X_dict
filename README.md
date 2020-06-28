# rime_X_dict
rime extention dictionarys &amp; schema

# ① cof_punctuator
符号输入方案，输入日文时不用切换大小写字母，按读音输入，每输入一个音节时供选择的都是平假名在上，片假名在下，<br>
可按分号键选择第二个候选字上屏，跟五笔的习惯一样。

# ② cof_network
网络ip地址转换方案，IP地址转换成十六进制数，ip地址转二进制数，十六进制转10进制，二进制转十进制<br>
dec.→hex <br>
dec,→bin <br>
hex/→dec. <br>
bin-→dec. <br>
![net](./pic/cof_network.gif) <br>


# ③ wubi86_cof
### 五笔86版的cof扩展方案 ，扩展内容如下：
1. 在五笔86的基础上增加了cof符号输入法，直接按下大写字母开头的编码即可打出符号，含日文等其他符号<br>
![demo4](./pic/watashi.gif) <br>

2. 按下Control+f 可以切换简体与繁体（是指输简得繁）的开关。<br>
![demo8](./pic/s2trad.gif) <br>
3. 按下/键后，输入单个小写字母可列出该字母对应的五笔字根部件<br>
![demo4](./pic/zigen.gif) <br>
4. 增加了繁体部件字根，按大写字母即可输入特定繁体部件字根，实现了繁体字的直接输入；<br>
增加的词库文件wubi86_cof_cap.dict.yaml<br>
增加的繁体部件字根如下：<br>
![zigen](./pic/zigen2.jpg) <br>
  Q		釒<br>
 W		興字头/飠<br>
 E		學字头<br>
 R		鳥，鳥字头/烏<br>
 T		與字頭<br>
 Y		訁<br>
 U		門<br>
 I		齊字头<br>
 O		爲去爫头/為无左上角的点<br>
 P		龍<br>
 A		帶字头<br>
 S		𡸸擊的左上角<br>
 D		豐字头<br>
 F		臣<br>
 G		冓字头/，穀字左上角部件<br>
 H		鹵<br>
 J		𢇇字底/肅字下面无竖，淵的右边<br>
 K		黽/𠀐，贵字头<br>
 L		車<br>
 M		貝<br>
 N		韋<br>
 B		爿<br>
 V		⺻/書字头<br>
 C		馬<br>
 X		糹<br>
  繁体字根打字示范： <br>
 ![demo1](./pic/fanzigen.gif) <br>
 
 5. 增加颜文字滤镜功能，按Control+e开启，当有颜文字提示时，按下Enter键输入颜文字，按下空格键则是<br>候选颜文字上屏
  , 滤镜文件：cof_trans.json 和 cof_trans.txt <br>
 ![demo1](./pic/emoji3.gif) <br>
 
 6. 增加字符编码（16进制）提示，按下control+g提示单字gbk编码，按下control+u提示单字unicode编码<br>
 滤镜文件：gbk_code.json 和 gbk_code.txt ; Utf16_code.json 和 Utf16_code.txt<br>
 默认已提示cjk字符的分区，以及unicode的10进制编码<br>
 ![code](./pic/gucode.gif)
 
 7. 增加单字 现代汉语拼音提示，按下Control+p开启<br>
 滤镜文件：pinyin.json 和 pinyin.txt <br>
![code](./pic/pinyin.gif)
 
 8. 增加实时日期及时间星期的提示（直接打 日期，时间，星期）<br>
![date](./pic/date.gif)
 
 ## 五笔86版字根
  ![dexxx](./pic/5b86.jpg) <br>

