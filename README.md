# music_ABC-notation-translator
Use flex and bison to create a translator that translates a tune written in a simple music notation (call it S, for Simple) into the popular ABC notation.

For example: 
**Happy Bithday:**
 !s>slsDt- !s>slsRD- !s>sSMDtl !F>FMDRD-- 
 
can be translated into:
D3/4D1/4 E D G F2 D3/4D1/4 E D A G2 D3/4D1/4 d B G F E c3/4c1/4 B G A G3 in ABC notation.


Enter the following commands in the terminal to get started:
* bison –d s.y
* flex s.l
* gcc –o abc –ll s.tab.c lex.yy.c
* abc

see more about ABC notation:http://trillian.mit.edu/~jc/music/abc/doc/ABCtutorial.html
