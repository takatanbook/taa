select *
from employees;

select empno, ename,sal, sal * 12
from employees;

select ename,sal,(sal + 10) * 12
from employees;

SELECT empno     as  Empno,
	   ename     as  "Ename",
	   sal       as  "Sal",
	   sal * 12  as   "Annual Salary"
FROM   employees;

SELECT * from employees;

SELECT empno,ename,deptno
FROM employees
WHERE deptno = 30;


/*
*エラーが発生する
*理由は、文字リテラルが使用されていない
*/


SELECT empno,ename,deptno
FROM employees
WHERE ename = 佐藤;

SELECT empno,ename,deptno
FROM employees
WHERE ename = '佐藤';


/*
* WHERE句の条件に指定した文字リテラルは大文字・小文字が区別される
*
*/
--no data found
SELECT empno,ename,deptno,yomi
FROM employees
WHERE yomi = 'SATO';

SELECT empno,ename,deptno,yomi
FROM employees
WHERE yomi = 'sato';


/*
*WHERE句には列名や定数（リテラル）、値のリスト、式といったいろいろな値を指定できます
*列別名を指定することはできません。
*エラー
*/
SELECT empno 社員番号,ename 社員名,hiredate 入社日
FROM employees
WHERE 入社日 = '07-11-2002';

SELECT empno,ename,sal
FROM employees
WHERE sal >= 300000;

SELECT empno 社員番号, ename 社員名,sal 給与, sal * 12 年収
FROM employees
WHERE sal * 12 < 3000000;

SELECT empno, ename, sal 
FROM employees
WHERE sal BETWEEN 200000 AND 300000;

SELECT empno,ename,sal
FROM employees
WHERE sal NOT BETWEEN 200000 AND 300000;


SELECT empno,ename,deptno
FROM employees
WHERE deptno IN (10,20);

SELECT empno,ename,deptno
FROM employees
WHERE deptno NOT IN(10,20);

SELECT empno,ename,job
FROM employees
WHERE job IN ('社長','部長');

SELECT * FROM products;

SELECT prodno,pname,price
FROM products
WHERE pname LIKE '%ノート';

SELECT prodno,pname,price
FROM products
WHERE pname LIKE '_________';

SELECT prodno,pname,price
FROM products
WHERE pname LIKE '______ノート';

SELECT prodno,pname,price
FROM products
WHERE pname LIKE '%A4%';

SELECT prodno, pname,price
FROM products
WHERE pname LIKE '%_____ノート';

SELECT prodno, pname,price
FROM products
WHERE pname LIKE '100\%%' ESCAPE '\';

';
--上のは関係ない

--100%_で始まる文字列データを取り出したいとき
SELECT prodno,pname,price
FROM products
WHERE pname LIKE '100\%\_%' ESCAPE '\';
';
--上のは関係ない

SELECT empno,ename,sal,comm
FROM employees
WHERE comm IS NULL;

--結果は一件も帰ってこない。
SELECT empno,ename,sal,comm
FROM employees
WHERE comm = NULL;


SELECT empno,ename,sal,deptno
FROM employees
WHERE sal >= 300000 AND deptno = 30;


SELECT empno,ename,sal,deptno
FROM   employees
WHERE sal >= 300000 OR deptno = 30;


SELECT empno,ename,sal,deptno
FROM employees
WHERE NOT sal >= 300000;



SELECT empno,ename,sal,deptno
FROM employees
WHERE deptno = 10
OR    deptno = 30
AND   sal   >= 300000; 


SELECT empno,ename,sal,deptno
FROM   employees
WHERE  (deptno =  10
OR      deptno =  30)
AND     sal    >= 300000; 

--昇順
SELECT empno,ename,sal
FROM employees
ORDER BY sal;
--NULL が一番大きい値として扱われるため、最後に取り出される
SELECT empno,ename,comm
FROM employees
ORDER BY comm;

SELECT empno,ename,sal
FROM   employees
ORDER BY sal DESC;
--nullが最初に取り出される
SELECT empno,ename,comm
FROM employees
ORDER BY comm NULLS FIRST;

--nullが最後に取り出される
SELECT empno,ename,comm
FROM employees
ORDER BY comm NULLS LAST;
/*
*WHERE 句によって絞り込まれた行がORDER BY句によってソートされます
*/
SELECT empno,ename,hiredate,deptno
FROM  employees
WHERE deptno = 30
ORDER BY hiredate;
/*
*ORDER BY句とWHERE句を同時に指定する場合は、必ず先にWHERE句を指定する
*ORDER BY句は、SELECT文の最後に指定する必要があります
*先にORDER BY句を指定すると、エラーになる
**/
SELECT empno,ename,sal,deptno
FROM employees
ORDER BY sal
WHERE deptno = 30;
/*
*ORDER BY句に指定する列は、SELECT句に指定されていない列でもできる
*業務では、分かり難いのであまり使用しない。
*/

SELECT empno,ename,deptno
FROM employees
WHERE deptno = 30
ORDER BY hiredate;


--列別名でもソートできる
SELECT empno,ename,sal * 12 annsal
FROM employees
ORDER BY annsal;


--列の位置を指定してソートできる
SELECT empno,ename,sal
FROM employees
ORDER BY 3;--SELECT句の三番目の列を指定


/*
*ORDER BY句では、複数の列を指定してデータをソートすることもできます。
*複数の列を指定した場合は、左側から指定した列から順番にソート処理が行われます
*/
SELECT empno,ename,sal,deptno
FROM employees
ORDER BY sal DESC ,deptno

/*
* ソートの順番
*1,SAL列の値で降順にソートされる
*２、SAL列の値が等しい行が、DEPTNO列の値で昇順にソートされる
*３、SAL列の値とDEPTNO列値が両方とも等しい行が、EMPNO列の値で降順にソートされる
*/
SELECT empno,ename,sal deptno
FROM employees
ORDER BY sal DESC , deptno,empno DESC;




SELECT empno, ename,sal
FROM  employees
ORDER BY sal DESC;

/*
*先頭から５行をスキップし、６行目から３行文を取り出している
*FETCH句でONLYを指定しているため、SAL列の値が８行目のデータと同じであっても９行目のデータは
*表示されない
*
*/
SELECT empno,ename,sal
FROM employees
ORDER BY sal DESC
OFFSET 5 ROWS
FETCH FIRST 3 ROWS ONLY;

/*
*先頭から５行をスキップし、６行目から３行文を取り出している
*FETCH句でWITH TIESを指定しているため、SAL列の値が８行目のデータと同じであっても９行目のデータは
*表示される
*
*/
SELECT empno,ename,sal
FROM employees
ORDER BY sal DESC
OFFSET 5 ROWS
FETCH FIRST 3 ROWS WITH TIES;
/*
*先頭から５行スキップし、結果セット全体（14行）の50％（７行）のデータを取り出している
*/
SELECT empno,ename,sal
FROM employees
ORDER BY sal DESC
OFFSET 5 ROWS 
FETCH FIRST 50 PERCENT ROWS ONLY;


/*
*OFFSET句を省略しているので、結果セットの先頭から３行分のデータが表示される
*
*/
SELECT empno,ename,sal
FROM  employees
ORDER BY sal DESC
FETCH FIRST 3 ROWS ONLY;

/*
*FETCH句を省略しているので、結果セットの先頭から５行分のデータはスキップされ、
*残りの９行分のデータが表示される
*/

SELECT empno,ename,sal
FROM employees
ORDER BY sal DESC
OFFSET 5 ROWS;

/*
*UPPER関数に引数にYOMI列を指定することで、YOMI列の値を大文字に変換して表示
*/
SELECT yomi , UPPER(yomi) 
FROM employees;
/*
*UPPER関数を使用してYOMI列の値を全て大文字にした上で、大文字と比較すれば、目的の
*データを取り出せます
*/
SELECT empno,ename,yomi
FROM employees
WHERE UPPER(yomi) = 'TAKAHASHI'; --比較条件の左辺で関数を使っている

/*
*関数の引数には列名を指定することが多いのですが、以下のように文字リテラルを
*直接指定することもできます
*/
SELECT 'small characters' AS 小文字, UPPER('lang characters') AS 大文字
FROM dual;

SELECT dname,'small characters' as 小文字,
	   UPPER('lange characters') as 大文字
FROM   departments;
--小文字に変換
SELECT LOWER('SMALL CHARACTERS')
FROM dual;
/*
*INITCAP関数
*『単語の先頭文字』を大文字に、二文字目以降を小文字に変換して戻す関数
*/
SELECT INITCAP('test characters')
FROM dual;

/*
*CONCAT関数は、引数として受け入れた二つの文字列を結合して戻す関数です。
*２章で解説した「連結演算子（||）」を使用して二つの文字列を結合した場合と同じ
*/
SELECT CONCAT('Oracle','Server')
FROM dual;

/*
*SUBSTR関数は、引数として受け入れた文字列のm番目の文字からn文字文の文字列を
*戻す関数です。(部分文字を戻す関数です)。
*nが省略された場合は、m文字目から末尾の文字までを戻します。
*/
SELECT SUBSTR('Oracle Server', 2,3),SUBSTR('Oracle Server',2)
FROM dual;

/*
*二つ目の引数mに負の値を指定すると、文字列の後ろから数えてm文字目からn文字文の
*文字列が戻されます
*二つ目のSUBSTRは、文字列の後ろから６文字目から、最後の文字までを取り出す
*/
SELECT SUBSTR('Oracle Server', -6,3),SUBSTR('Oracle Server',-6)
FROM dual;

/*
*LENGTH関数は、引数として受け入れた文字列の「文字数」を戻す関数です（バイト数）
*では、ありません
*
*/
SELECT LENGTH('Oracle Server')
FROM dual;

--LENGTH関数では、全角の文字や記号も一文字としてカウントします。
SELECT LENGTH('あいうえお')
FROM dual;


/*
*INSTR関数は、「指定した文字パターンが現れる位置」を戻す関数です
*引数として、受け入れた文字列１のm文字目かあら文字列２を検索し、
*ｎ回目に一致した文字列の位置（先頭からの文字数）を戻します。
*m及びnが省略された場合のデファルト値は、(1)です。
*また、文字列の最後まで文字列２がない場合は、
*INSTR関数は(0)を返します。
*/
SELECT INSTR('Oracle Server', 'er', 1, 2),
       INSTR('Oracle Server', 'er')
FROM   dual;

/*
*LPAD関数、RPAD関数は、引数として受け入れた文字列がn文字にになるように、
*「埋め込み文字」を埋め込んで戻す関数です。LPAD関数では文字列の左側に、
*RPAD関数では、右側に「埋込み文字」が埋め込まれます。
*/
SELECT LPAD(yomi, 10, '*'),
       RPAD(yomi, 10, '$')
FROM   employees;


/*
*TRIM関数は、引数として受け入れた文字列の前後にある「削除文字」(任意の１文字)を
*取り除いて戻す関数です。削除文字が省略された場合は、半角スペースが取り除かれます。
*なお、「FROM」は削除位置（LEADING,TRAILING,BOTH）と削除文字の両方を省略した
*場合のみ、省略できます
*LEADING 　文字列の先頭にある削除文字を削除する
*TRAILING　文字列の末尾にある削除文字を削除する
*BOTH　　　 文字列の先頭及び末尾にある文字列を削除する。デファルト値　　
*/
SELECT TRIM(LEADING 'O' FROM 'Oracle Server')
FROM dual;

SELECT '　　　Oracle Server　　　',TRIM('　　　Oracle Server　　　')
FROM dual;

SELECT LENGTH('   Oracle Server   '),
       LENGTH(TRIM('   Oracle Server   '))
FROM dual;

/*
*REPLACE関数は、引数として受け入れた文字列のうち、変更前文字列を変更後文字列に置き換えた
*文字列を戻す関数です
*変更後文字列が省略された場合は、文字列から変更前を削除した文字列を戻します。
*
*/
SELECT REPLACE('Oracle Server', 'Server','Master'),
       REPLACE('Oracle Server', 'Server')
FROM dual;

/*
*ROUND関数は、引数に指定された数値を少数点以下n桁に四捨五入して戻す関数です
*引数nが省略された場合は整数値に四捨五入します。（少数点以下０桁）
*/
SELECT ROUND(12345.678,1),
       ROUND(12345.678,0),
       ROUND(12345.678)
FROM dual;

/*
*また、引数nには負の値を指定することもできます。
*例えば、「-１」を指定した場合は一の位が四捨五入され、「−２」を
*指定した場合は十の位が四捨五入されます
*/
SELECT ROUND(12345.678,-1),ROUND(12345.678, -2)
FROM dual;

/*
*TRUNC関数は、引数に指定された数値を小数点以下n桁に切り捨ててもどす関数です。
*引数nが省略された場合は整数値になるように切り捨てます（小数点以下０桁）。
*また、ROUND関数と同様に引数nには、負の値を指定することもできます。
*
**/
SELECT TRUNC(12345.678,2),
	   TRUNC(12345.678,-1),
	   TRUNC(12345.678)
FROM dual;

--sample
select num, p, TRUNC(num,p) from trunc_sample;

NUM          P TRUNC(NUM,P)
---------- ---------- ------------
   123.456          2       123.45
   123.456          1        123.4
   123.456          0          123
   123.456         -1          120
   123.456         -2          100
   123.456         -3            0
--end

/*
*MOD関数は、引数ｎを引数mで割った余りを戻す関数です
*/
SELECT MOD(10,3)
FROM dual;

/*
*ＭはＭｏｎｔｈ、ＤはＤａｙ、ＹはＹｅａｒ
*MON" にアルファベットの省略形(JAN,FEB,MAR,APRなど)
*日付表示書式
*英語環境では、DD-MON-RR(日ー月ー年)
*日本語環境では、RR-MM-DD（年ー月ー日）
*/
--今の環境では、MM-DD-YYYYで表示される
SELECT ename,hiredate
FROM employees
WHERE deptno = 30;

ALTER SESSION SET lns_date_format = 'DD-MON-RR';
/*
*日付計算
*[日付値＋数値]及び[日付値-数値]
*[日付値+数値/24]及び[日付値-数値/24]
*[日付値-日付値]
*日付値に対して除算や乗算は実行できない
*日付値同士の加算することはできない。
*/
--hiredate列に９０日を加算した値を表示
--hiredate列に30日を減算した値を表示
SELECT ename, hiredate, hiredate + 90, hiredate -30
FROM emp;

/*
*日付値に「数値/24」を加算すると、指定した数値が時間数として加算してくれる
*日付値に「数値/24」を減算すると、指定した数値が時間数として減算されます
*これらの計算結果も日付値になります
*SYSDATE（現在の日付）
*/
--12時間後と１２時間前
SELECT SYSDATE ,SYSDATE + 12/24,SYSDATE - 12/24
FROM dual;

/*
*日付値ー日付値
*日付値から日付値を減算すると、指定した二つの日付値の間に経過した「日数」が
*戻される
*
*/
SELECT empno,SYSDATE,SYSDATE - hiredate
FROM emp
WHERE deptno =30;

--日付値＋日付値　エラー
SELECT empno,SYSDATE,SYSDATE + hiredate
FROM emp
WHERE deptno = 30;
--ORA-00975: 日付と日付の加算はできません。

--現在の日付を（日時）をもどす関数です
SELECT SYSDATE
FROM dual;
/*
*MONTHS_BETWEEN関数は、引数として受け入れた２つの日付間の月数を戻す関数です。
*(一ヶ月以下の値は小数点として戻されます)。
*日付１が日付２よりも前の日付の場合は、負の数値を戻します
*
*/

SELECT ename,
	   MONTHS_BETWEEN(SYSDATE, HIREDATE),
	   TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE))
FROM emp
WHERE deptno = 30;

/*
*ADD_MONTHS関数は、引数に指定した日付のnヶ月後の日付を戻す関数です。
*また、引数nに負の指定すると「nヶ月前の日付」が戻されます。
*
*/
SELECT SYSDATE,ADD_MONTHS(SYSDATE,3),
       ADD_MONTHS(SYSDATE,-1)
FROM dual;
/*
*ADD_MONTHS関数では、月の最終日は特別な値として扱われるので
*注意が必要です。
*引数の日付に月の最終日を指定すると、戻される値も２番目の引数で指定された
*月数後の月の最終日になります。
*/
--自分の環境では、日付型を指定しないといけない。
SELECT ADD_MONTHS('14-02-28'),1)
FROM dual;
--自分の環境では、変換しないといけない。
SELECT ADD_MONTHS(TO_DATE('14-02-28','RR-MM-DD'),1)
FROM dual;

/*
*NEXT_DAY関数は、引数に指定された「日付」の翌月以降に、
*指定された曜日になる最初の日付を戻す関数です。
*なお、曜日の指定形式はSQL分の実行環境の言語環境によって異なります。
*/
SELECT NEXT_DAY('14-01-24','月曜日')
FROM dual;

--自分の環境では、変換しないといけない。
SELECT NEXT_DAY(TO_DATE('14-01-24','RR-MM-DD'),'日曜日')
FROM dual;

/*
*LAST_DAY関数は、引数に指定された日付を含む月の、
*最終日の日付を戻す関数です。
*
*/
SELECT LAST_DAY('12-02-01')
FROM dual;

--自分の環境では、変換しないといけない。
SELECT LAST_DAY(TO_DATE('12-02-01','RR-MM-DD'))
FROM dual;

/*
*ROUND関数は、前節で数値関数としてすでに紹介していますが、引数として
*日付として数値を受け入れることもできます、つまり、ROUND関数は、
*数値関数であり、日付関数でもあります。
*
*ROUND関数(日付関数)は、引数に指定された日付値を四捨五入して戻す関数です。
************************************************************
*　　書式   * 説明                                             *
************************************************************
*   YEAR   　指定した日付が６月30日以前の場合は当年の１月１日午前０時を、
*　　　　　　　7月1日以降の場合は翌年の1月1日午前０時を戻す
************************************************************
*　　MONTH   指定した日付が15日以前の場合は当月の1日午前0時を
*　　　　　　　16日以降の場合は翌月の1日午前0時を戻す
************************************************************
*   DD      指定した日付が正午より前の場合は当月の午前0時を、  
*           正午以降の場合は翌月の午前0時日付を戻す。デファルト値。
************************************************************
*/

SELECT SYSDATE,ROUND(SYSDATE,'YEAR'),ROUND(SYSDATE,'MONTH')
FROM dual;

/*
*TRUNC関数も、前節で数値関数としてすでに紹介していますが、この関数も引数として
*日付値を受け入れることができます。
*
*TRUNC関数（日付関数）は、引数に指定された日付値を切り捨てて戻す関数です。
*どの単位で切り捨てるかは「書式」で指定します。
*****************************************************
* 　書式　　　　　　　　　説明
*****************************************************
*   YEAR    当年の1月１日午前０時を戻す
*****************************************************
*   MONTH   当月の１日午前０時を戻す
*****************************************************
*   DD      当日の午前０時を戻す。デファルト値
*****************************************************
*/
SELECT SYSDATE,TRUNC(SYSDATE, 'YEAR'),TRUNC(SYSDATE,'MONTH')
FROM dual;

/*
*MOD(100,78)は、２２です。
*ROUND(22,-1)は、２０です。
*TROUNC(20, -2)は、０です。
*
**/
SELECT TRUNC(ROUND(MOD(100,78),-1),-2)
FROM dual;

/*
*暗黙的なデータ型変換は、データ型の変換は、データ型の変換が意味の持つ場合にのみ成功します。
*データ型の変換
******************************************************
*  変換方法            説明
******************************************************
*  暗黙的的なデータ変換   Oracleサーバーが自動的に（暗黙的）に
*　　　　　　　　　　　　　実行するデータ型の変換
******************************************************
*  明示的なデータ変換　　　ユーザーが明示的に変換関数を使用して
*　　　　　　　　　　　　　実行するデータ型の変換
*/
--暗黙的なデータ型変換によって、日付値が文字値に変換される
SELECT deptno,ename,hiredate,SUBSTR(hiredate, 4, 5)
FROM   employees
WHERE  deptno = 30;

--暗黙的なデータ変換はWHERE句でも実行される（'10'文字値が数値に変換）
SELECT deptno,ename,hiredate
FROM employees
WHERE deptno = '10';


--暗黙的なデータ変換によって、文字値が日付に変換される。
SELECT ename,hiredate
FROM employees
WHERE hiredate <= '00-12-31';

--日付書式のRR-MM-DDと合っていないため暗黙的なデータ変換をしても意味が無い。
--ERRORとなる。
SELECT * FROM employees
WHERE hiredate <= '12-31-00';

/*
*明示的なデータ型変換と主な変換関数
*
*ユーザーが明示的に変換関数を使用して実行するデータ型の変換を「明示的なデータ型変換」
*と呼びます。
*暗黙的なデータ変換よりも明示的なデータ変換の方がパフォーマンスがわずかですが、向上します。
*
*日付値や数値を文字値に変換するTO_CHAR関数
*文字値を日付値に変換するTO_DATE関数
*文字値を数値に変換するTO_NUMBER関数。
*/

/*
*TO_CHAR関数は指定された「日付書式」を使用して
*日付値を文字値に変換して戻します。
*また「NLSパラメータ」を指定することで、
*日付書式の言語環境を設定をすることもできます。
*
*****/
--[HH24:MI:SS]を指定すると,[24時間形式の時間：分：秒]で表示される。
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
FROM dual;


/*
*[/],[-],[()]などの半角記号は、そのまま結果に表示される。
*[年]や[月],[日]のような漢字やひらがな、カタカナ、アルファベットなどを["]
*(二重引用符)で囲むと、そのまま結果に表示される
*日付書式の要素及び半角記号以外をそのまま指定するとエラーになる。
*/
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD'),
       TO_CHAR(SYSDATE, 'YYYY"年"MM"月"DD"日"(DAY)')--DAY曜日
FROM dual;

--日付書式の要素および半角記号以外を指定する際は二重引用符で囲む必要がある
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD')
       TO_CHAR(SYSDATE,'YYYY年MM月DD日(DAY)')
FROM dual;

SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MONTH:MON:DAY:DY') 日本語環境
       TO_CHAR(SYSDATE, 'MONTH:MON:DAY:DY',
               'nls_date_language = AMERICAN')　英語環境
FROM dual;

/*
*出力
*日本語環境：1月 :1月 :金曜日:金　英語環境　JANUARY :JAN:FRIDAY :FRI
*
*MONTHは、空白埋め込まれた９文字の長さの月の名前。
*MONは、月の名前。三文字省略形
*DAYは、空白の埋め込めれた９文字の長さの月の名前。
*DYは、曜日。三文字省略形。
*/
--なお日付書式の大文字・小文字は区別されます。
SELECT SYSDATE,
       TO_CHAR(SYSDATE,'Month:Mon:Day:Dy') 日本語環境
       TO_CHAR(SYSDATE,'Month:Mon:Day:Dy',
               'nls_date_language = AMERICAN') 先頭大文字
       TO_CHAR(SYSDATE, 'month:mon:day:dy',
               'nls_date_language = AMERICAN') 小文字
FROM dual;

/*
*数値で表示される日付書式の表示形式の変更
*日付書式「DD」のような、数値で表示される日付書式の後ろに[TH]や[SP]などの接頭辞を指定
*すると、これらの表示形式を順序表記やスペル表記に変更することができます。
*
*数値で表示される日付書式に使用できる接頭辞
*******************************************************
*　接頭辞　　　　説明　　　
*******************************************************
*　TH          順序表記（例：DDTH→4TH）日にちにthを表示する
*******************************************************
*  SP          スペル表記（例：DDSP→FOUR）日付を英語のスペルで表示する
*******************************************************
*SPTHまたはTHSP　順序表記+スペル表記（DDSPTH→FOURTH）
*******************************************************
*1日 st
*2日 nd
*3日 rd
*4日～20日 th
*21日 st
*22日 nd
*23日 rd
*24日～30日 th
*31日 st
*/

SELECT ename,
       TO_CHAR(hiredate, 'DDth "of" Month, YYYY',
               'nls_date_language = AMERICAN')
FROM employees
WHERE deptno = 10;

/*
*また、「TH」、「SP」を組み合わせて「SPTH」や「THSP」を指定すると、スペル表記し
*た順序として表示できます（SPTHとTHSPは意味です）。
*以下の例では、日付書式に「Ddthsp」を指定しています。実行結果を見ると２５日が
*[Twenty-Fifth],17日が「Seventeenth」,2日が「Ｓｅｃｏｎｄ」という形式
*で表示されていることが確認できます。
*/
SELECT ename,
       TO_CHAR(hiredate, 'Ddthsp "of" Month, YYYY',
               'nls_date_language = AMERICAN')
FROM employees
WHERE deptno = 10;
/*
*FM要素の指定
*日付書式にFM要素を指定して「埋め込みモード」（デフォルトで有効）を無効にすると
*「数値の先行０」や「文字値の前後に含まれるスペース」が取り除かれて表示されます。
*なお、FM要素を指定すると、FM要素以降のすべての日付書式に対する埋め込みモードが
*無効になるので注意してください。
********/
SELECT ename,
       TO_CHAR(hiredate, 'ddth "of" Month, YYYY',
        'nls_date_language = AMERICAN')
FROM employees
WHERE deptno =10; 

--FebuaryやMaｙの後ろの空白が表示されない。
--また0２nｄの先頭の「０」も表示されない。

SELECT ename,TO_CHAR(hiredate, 'fmddth "of" Month, YYYY',
                    'nls_date_language = AMERICAN')
FROM employees
WHERE deptno = 10;

/*
*TO_CHAR関数（数値　→　文字値）
*引数に数値を指定すると、TO＿CHAR関数は指定された「数値書式」を使用して数値を
*文字値に変換して戻します。また「NLSパラメータ」指定することで、小数点文字や
*桁区切り、各国通貨記号、国際通貨記号を指定することもできます。
*この関数は、連結する場合に使用。
*
*なお、数値書式が省略された場合は受け入れた数値の有効桁数保持するために十分な
*長さの文字値に変換します。またNLSパラメータが省略された場合はセッションの
*デフォルトのパラメータ値が使用されます。
*
*Lは、ローカル通貨記号の表示。日本語環境では、「￥」
*３列目のように指定した桁数（５桁）が実際のデータの桁数（６桁）より少ない場合
*変換出来ない場合「＃」が表示される。
******/

SELECT ename, TO_CHAR(sal, 'L999,990'),TO_CHAR(sal, 'L99,990')
FROM employees
WHERE deptno = 10;


/*
*以下の例では、引数として受け入れた数値を小数点以下４桁になるように四捨五入して
*います。なお、数値書式に一の位に「０」を指定すると先行も0も表示されるが、
*「９」を指定すると先行０は表示されないので注意する。
*/
SELECT TO_CHAR('0.12345','0.9999'),TO_CHAR('0.12345','9.9999')
FROM dual;
--結果　0.1235　.1235

/*
*TO_DATE関数は、引数に指定された文字値を日付値に変換して戻す関数です。
*日付書式やNLSパラメータは先述のTO_CHAR関数と同じ。この関数は、主に、
*デフォルトの日付書式と異なる形式の文字列を日付値に変換する場合に使用
*
*日付書式が省略された場合はセッションのデフォルトの日付書式が使用され、
*NLSパラメータが省略された場合はセッションのデフォルトのパラメータ値が
*使用される。
*
***/

/*
*なお、前述の例のように時刻が指定されなかった場合は「午前0時0分0秒」として
*処理されます。また、日にちが指定されていない場合は、「1日」、月が指定されて
*いない場合は「現在の月」、年が指定されていない場合は「現在の年」として
*処理されます。
*/
SELECT TO_DATE('2014年01月01日','YYYY"年"MM"月"DD"日"')
FROM dual;
--暗黙変換で数値に変換しようとしてえらーが発生。
SELECT SYSDATE - '00-01-01'
FROM dual;
--以下の場合は、TO_DATE関数を使用して明示的にデータ変換を使用
SELECT SYSDATE - TO_DATE('00-01-01')
FROM dual;
--自分の環境だと
SELECT SYSDATE - TO_DATE('09-24-2015')
FROM dual;

--YY要素とRR要素の違い

/*YYの要素が表す値
*****************************************************************************
*                             *受け入れた値（年のした2桁）                       *
*                             　　　*0〜49年                　　 50年〜99年   
*現在の年（下の２桁）０年から４９年  *　　　現在の世紀              ＊  現在の世紀
*                50年から99年  　*　　　現在の世紀             *  　現在の世紀                    
******************************************************************************
*/

/*RRの要素が表す値
*****************************************************************************
*                             *受け入れた値（年のした2桁）                       *
*                             　　　　　*0〜49年                　　 50年〜99年   
*現在の年（下の２桁）０年から４９年  *　　　現在の世紀              　　　＊　現在の一つ前の世紀
*                50年から99年  　*　　現在の一つ後の世紀             *  　現在の世紀                    
******************************************************************************
*現在の年が０年から４９年で受け入れた値が０年から４９年の場合は、現在の世紀
*現在の年が0年から４９年で受け入れた値が50年から99年の場合は、現在の一つ前の世紀
*現在の年が50年から99年で受け入れた値が0年から49年の場合は、現在の一つ後の世紀
*現在の年が50年から99年で受け入れた値が50年から99年の場合は、現在の世紀
*/

/*
****現在の年******受け入れた年****RRの要素*******YYの要素
1995             95-10-10    1995-10-10    1995-10-10
                 20-10-10    2020-10-10    1920-10-10 
****************************************************
2010             95-10-10    1995-10-10    2095-10-10
                 20-10-10    2020-10-10    2020-10-10
*/

SELECT TO_CHAR(TO_DATE('20-10-10','YY-MM-DD'), 'YYYY') YY20,
       TO_CHAR(TO_DATE('20-10-10','RR-MM-DD'), 'YYYY') RR20,
       TO_CHAR(TO_DATE('95-10-10','YY-MM-DD'), 'YYYY') YY95,
       TO_CHAR(TO_DATE('95-10-10','RR-MM-DD'), 'YYYY') RR95
FROM dual;
--2016
--結果　2020 2020  2095  1995

SELECT ename,hiredate
FROM   employees
WHERE hiredate >= TO_DATE('2003-JANUARY-01', 'RR-MON-DD',
                         'nls_date_language = AMERICAN');
/*
*MM書式要素は'MM'書式要素は'MON'や'MONTH'書式要素に書き換えられて
*試行されます。
*'MON'書式要素は、'MM'書式要素には書き換えれません。
*/
SELECT ename,hiredate 
FROM employees 
WHERE hiredate >= TO_DATE('2003-01-01', 'RR-MON-DD',
                          'nls_date_language = AMERICAN');
/*
*文字列の区切り文字には「.」、日付書式の区切り文字には「-」が指定されていますが、
*英数字以外の任意の１文字を使用して書式文字列の句読点（くとうてん）記号に
*一致させることができるため、エラーにならず実行できている点に注意してください。
*/
SELECT ename,hiredate
FROM   employees
WHERE  hiredate >= TO_DATE('2003.01.01','RR-MON-DD',
                          'nls_date_language = AMERICAN');

/*
*TO_NUMBER関数は、引数に指定された文字値を数値に変換して戻す関数です。
*********/

SELECT '￥5,000,000' * 2
FROM dual;
--自分の環境下では、実行できない。
SELECT TO_NUMBER('$5,000,000','L9,999,999',
                'nls_date_language = AMERICAN') * 2
FROM dual;



/*
*ここでは、「汎用関数」と、SQL分の中にIF-THEN-ELSEロジックを記述する方法を解説
*/

/*
*NVL関数は、引数の「式１」に指定された値がNULL値以外の場合は「式１」を、
*NULL値の場合は「式２」を戻す関数です。戻り値のデータ型(数値、文字値、日付値)は
*式１のデータ型と同じになります。（必要に応じて暗黙的なデータ型変換が行われます。
*また変換出来ない場合はエラーになります。）
*(先述の通りNULL値を含む計算式は結果もNULL値になります)
*/

SELECT ename,sal,comm,sal + comm ,sal + NVL(comm,0)
FROM employees
WHERE deptno = 30;

/*
*NVL2関数は、引数の「式１」に指定された値がNULL値以外の場合は「式２」を、
*NULL値の場合は「式３」を戻す関数です。戻り値のデータ型(数値、文字値、日付値)は
*常に式２にデータ型ち同じになります（必要に応じて暗黙的なデータ型変換が行われます。
*また変換出来ない場合はエラーになります。）
**/
SELECT ename,sal,comm,NVL2(comm,sal+comm,sal)
FROM employees
WHERE deptno = 30;

/*　
*NULLIF関数は、引数に指定された２つの値を比較して、等しい場合は「NULL値」を戻し、
*等しくない場合は「式１」を戻す関数です。なお、式１にはリテラルのNULL値以外を
*指定する必要があります。
***/
SELECT ename,sal,comm,NULLIF(comm,sal/10)
FROM employees
WHERE comm IS NOT NULL;

/*
*COALESCE関数は、引数に指定された式リストを先頭（左側）からチェックし「最初に
*見つかったNULL値以外の値」を戻す関数です。（すべての式がNULL値の場合、
*NULL値を戻します）。
*
*なお、式リストに指定するデータは、すべての同じデータ型(数値、文字値、日付値)にする
*必要があります(数値、文字、日付をまたがる暗黙的なデータ変換は行われません)。
*
*次の例のように、COALESCE関数の引数にデータ型の異なるデータを指定するとエラー
*になります。(COMM列とMGR列は数値ですが、ENAME列は文字値です)。
*/
SELECT comm,mgr,ename,COALESCE(comm,mgr,ename)
FROM employees
WHERE deptno IN(10,30);

SELECT comm,mgr,ename,COALESCE(TO_CHAR(comm), TO_CHAR(mgr),ename)
FROM employees
WHERE deptno IN(10,30);

/*
*条件式とDECODE関数
*単一行関数に関する解説の最後に、分岐処理を行う「DECODE関数」を紹介します。
*この関数は、これまでに紹介してきた関数とは目的や使用方法が少し異なりますが、
*主要な関数の1っです。
*
*また、同時にSQL文の中に「IF-THEN-ELSEロジック」(いくつかの条件に基づいて
*異なる値を戻す処理)を指定する方法についても習得が必要。
*「CASE式」または「DECODE関数」を使用するとIF-THEN-ELSEロジックを簡単に実装できます。
*
*
*CASE式に使用すると、SQL文の中にIF-THEN-ELSEロジックを実装できます。CASE式はANSI　SQL
*に準拠している。
*CASE式は、「式」の値と条件式の値を「条件式１」から順番に比較し、最初に一致した
*条件式に対応した「戻り値」を戻します。また、どの条件とも一致しなかった場合は
*「デフォルトの戻り値」を戻します。なお一致する条件がなく、ELSE句が省略されている
*場合は「NULL値」を戻します。
*
*/

SELECT deptno,ename,sal,
       CASE deptno WHEN 10 THEN sal * 1.1
                   WHEN 20 THEN sal * 1.2
                   ELSE sal * 1.5
       END NEW_SAL
FROM   employees
WHERE  sal >= 300000
ORDER BY deptno;
/*
*この例のように、CASE式の中でリスト化された条件を順番に評価し、最初にTRUEを
*戻す条件に対応したデータを戻すCASE式のことを「検索CASE式」と呼びます。
*/
SELECT ename,sal,
       (CASE WHEN sal < 230000 THEN 'A'
             WHEN sal < 380000 THEN 'B'
             WHEN sal < 480000 THEN 'C'
             ELSE 'D'
        END) SAL_LEVEL
FROM employees
ORDER BY sal_level;

/*
*DECODE関数は、CASE式と同様にSQL文の中にIF-THEN-ELSEロジックを実装する、
*ORACLEデータベース固有の関数です。処理手順や戻り値の値は、CASE式と同じです。
*「式」の値と条件式の値を「条件式１」から順番に比較し、最初に一致した条件式に
*対応した「戻り値」を戻します。また、どの条件式とも一致しなかった場合は「デフォルトの戻り値」
*を戻します。なお、一致する条件がなく、デフォルトの戻り値が省略されている場合は「NULL値」を
*戻します。
*/
SELECT deptno,ename,sal,
       DECODE(deptno, 10 , sal * 1.1
                    , 20 , sal * 1.2
                    , sal * 1.5) NEW_SAL
FROM employees
WHERE sal >= 300000
ORDER BY deptno;

SELECT TO_CHAR(999999.99,'$9,999,999,000')
FROM dual;

/*
*曜日を表示する日付書式には「DAY」「DY」、「D」がありますが、問題文の表示結果のように「日曜日」、
*「月曜日」、「火曜日」・・・と表示する場合はDAY要素を指定します。
*DY要素は日」、「月」、「火」・・のように、D要素は日曜日を{1},月曜日「２」、火曜日「３」・・
*のように表示します。そのため、D要素でソートすると日曜日はじまりでソートそれますが
*[HIREDATE -1]を指定することで月曜日はじまりのソートで変換できます。
*/
SELECT empno,ename,TO_CHAR(hiredate, 'YYYY-MM-DD(DAY)')
FROM employees
ORDER BY TO_CHAR(hiredate - 1, 'D');

--グループ関数（複数行関数）
/*
*グループ関数は、「複数件の入力データをグループ化して、集計処理を行った結果を１っだけ戻す関数」です
*グループ関数には数値の平均値を求める関数や合計値を求める関数などがあります。なお、グループ関数は
*「複数行関数」や「集計関数」と呼ばれることもある。
*
*グループ関数の基本構文は以下のとおりです。SELECT句、ORDER　BY句、及び後述するHAVING句で使用できます。
*WHERE句では使用できません。
*
*グループ関数は、グループごとに集計した結果を１つだけ戻します。
*
*DISTNCT　重複した値を１回だけ処理
*ALL　　　 重複した値を含む、すべての値を処理する。デフォルト値
*/

/*
*COUNT関数は、取り出さされた件数を戻す関数です。引数には、数値型、文字型、
*日付型を戻す式または列を指定できます、また、列名、式に加えて「＊」を
*指定できます。
*/
SELECT COUNT(*) ,COUNT(comm) ,COUNT(job) ,COUNT(DISTINCT job)
FROM employees;
/*
*MAX関数は最大値を、MIN関数は最小値を戻す関数です。
*引数には、数値型、文字型、日付型を戻す式または列を指定できます。
*/
SELECT MAX(sal), MIN(sal)
FROM emp;
/*
*AVG関数は平均値を、SUM関数は合計値を戻す関数です。引数には、数値型を戻す式
*または列のみ指定できます。
*/
SELECT AVG(sal),SUM(sal)
FROM emp;
/*
*Oracleサーバーでは、計算式に中にNULL値が含まれると、その結果も
*NULL値になります。グループ関数では、COUCN関数の引数に「*」
*指定した場合を除き、NULL値を無視して集計処理を行います。
*/
SELECT ename,comm
FROM   employees;
/*
*グループ関数は、NULL値を無視そて集計処理を行う
*ここではNULL値以外の４件のデータが集計対処になる
*/
SELECT AVG(comm),SUM(comm)
FROM employees;
/*
*SELECT文にGROUP　BY句を指定すると、行をグループ化することができます。
*なおGROUP BY句は、必ずWHERE句の後ろ、かつORDER BY句の前に指定します
*（WHERE句やORDER BY句が指定される場合）
*
*GROUP BY句には、１っ以上の列を指定する必要がある
*列別名は指定できない。
*SELECT句の選択リストには「GROUP BY句で指定した列」と「グループ関数」のみ指定できる
*
*ORDER BY句とGROUP BY句を併用する場合、ORDER BYには「GROUP BY句で指定した列」と
*「グループ関数」のみ指定できる。
*/
SELECT deptno, COUNT(*),AVG(sal)
FROM employees
GROUP BY deptno;

SELECT deptno,job,COUNT(*),AVG(sal)
FROM employees
GROUP BY deptno, job;

--グループ関数のネストとGROUP句
/*
*SELECT文にGROUP句の指定がある場合は、グループ関数は２レベルまでネストすることができます。
*（グループ関数の引数に別のグループ関数を指定することができます）。
*/
SELECT MAX(AVG(sal))
FROM employees
GROUP BY deptno;

/*
*グループ関数を条件を使用したい場合は、HAVING句を使用します。
*SELECT文にHAVING句を指定すると、取り出すグループ制限することができます。
*なおGROUP BY句を指定せずに、HAVING句のみ指定した場合は、選択された
*行全体が１っのグループとして処理されます。
*/


SELECT empno,ename,dname
FROM employees, departments;

--err
SELECT empno,ename,dname,deptno
FROM employees,departments;

SELECT empno,ename,dname,employees.deptno
FROM employees,departments;

SELECT employees.empno,employees.ename,
       departments.dname,employees.deptno
FROM   employees, departments;

SELECT e.empno,e.ename,d.dname,d.deptno
FROM   employees e, departments d;



SELECT empno,ename,dname
FROM employees NATURAL JOIN departments;
--err
SELECT e.empno,e.ename,d.deptno,d.dname
FROM employees NATURAL JOIN departments;

SELECT e.empno,e.ename,deptno,d.dname
FROM employees NATURAL JOIN departments;
--err
SELECT e.empno,e.ename,d.dname
FROM employees e NATURAL JOIN departments d
WHERE e.deptno IN(10,20);

SELECT e.empno,e.ename,d.dname
FROM employees e NATURAL JOIN departments d
WHERE deptno IN (10,20);

SELECT empno,ename,dname
FROM employees JOIN departments USING(deptno);

--err
SELECT e.empno,e.ename,d.dname
FROM employees e JOIN departments d USING(deptno)
WHERE e.deptno IN(10,20);

SELECT e.empno,e.ename,d.dname
FROM employees e JOIN departments d USING(deptno)
WHERE deptno IN(10,20);

--err
SELECT e.empno,e.ename,d.dname
FROM employees e NATURAL JOIN departments d USING(deptno); 

SELECT empno,ename,dname
FROM employees JOIN departments
ON employees.deptno = departments.deptno;

--err
SELECT e.empno,e.ename,d.dname
FROM employees e JOIN departments d
ON   e.deptno = d.deptno 
WHERE deptno IN(10,20);

SELECT e.empno,e.ename,d.dname,e.deptno
FROM employees e JOIN departments d
ON   e.deptno = d.deptno
WHERE  e.deptno IN (10,20);

SELECT e.empno,e.ename,d.dname
FROM employees e, departments deptno
WHERE e.deptno = d.deptno
AND   d.deptno IN (10,20);

SELECT o.ordno, o.date_ordered,e.ename
FROM orders o
JOIN customers c ON o.custno = c.custno
JOIN employees e ON o.salesman_no = e.empno
ORDER BY o.ordno;

SELECT ordno,o.date_ordered,custno,c.cname,
       prodno,p.pname,od.quantity
FROM customers c
NATURAL JOIN orders o 
NATURAL JOIN ord_details od
NATURAL JOIN products p
ORDER BY ordno,prodno;

SELECT ordno,o.date_ordered,custno,c.cname,
       prodno,p.pname,od.quantity
FROM customers c
JOIN orders o USING(custno)
JOIN ord_details od USING(ordno)
JOIN products p USING(prodno)
ORDER BY ordno,prodno;

SELECT ordno,o.date_ordered,custno,c.cname,
       od.prodno,p.pname,od.quantity
FROM customers c
NATURAL JOIN orders o
JOIN ord_details od USING(ordno)
JOIN products p ON od.prodno = p.prodno
ORDER BY ordno,od.prodno;

SELECT * FROM salgrades;

SELECT e.empno,e.ename,e.sal,sg.grade
FROM employees e JOIN salgrades sg
ON  e.sal BETWEEN sg.losal AND sg.hisal;

SELECT w.empno,w.ename,m.empno,m.ename
FROM employees w JOIN employees m
ON    w.mgr = m.empno
ORDER BY w.empno;

SELECT empno ename,sal
FROM employees
WHERE sal >=  ( SELECT sal
              FROM employees
              WHERE empno = 1003);