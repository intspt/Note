INSERT INTO `notes` (`nid`, `title`, `content`, `time_`, `is_visible`) VALUES
('20150415195953', '【挖个坑】快速排序', '<p>RT</p>', '2015-04-15 19:59:53', 1),
('20150416201813', '【挖个坑】暂时去掉了删除功能', '<p>感觉直接删除了有点可惜</p><p>还是加个字段设为隐藏吧</p><p>【写完综述再填坑</p><p>话说两条post之间的间距也有点问题</p><p>是按钮引起的</p><p>【写完综述再说</p>', '2015-04-16 20:20:09', 0),
('20150213222639', 'win7的引号一打就是两个，不能一次打一个', '<p>不管单引号还是双引号，打一次打不出来，打两次出来一对</p><p>原来是输入法的问题，选择为English(United States) US键盘就可以了</p>', '2015-02-13 22:26:39', 1),
('20150420001419', '【挖个坑】导航栏加一个todolist', '<p>RT</p>', '2015-04-20 00:14:19', 0),
('20150324113602', 'BeautifulSoup解析器的使用过程中出现的一些问题', '<p>今天写爬虫爬小说的时候用BeautifulSoup解析网页出现了一些问题</p><p>一开始解析章节总是错误然后很费解</p><p>后来发现是在生成BeautifulSoup对象时丢失了后边一大部分数据</p><p>卧槽尼玛这TM是什么情况</p><p>我一开始以为有长度限制</p><p>不过文档里没说也没google到</p><p>再说长度限制什么的有点扯。。。</p><p>后来google到一个相似的问题</p><p><a href="http://stackoverflow.com/questions/16029442/beautifulsoup-lxml-are-there-problems-with-large-elements" target="_blank">http://stackoverflow.com/questions/16029442/beautifulsoup-lxml-are-there-problems-with-large-elements</a><br></p><p>根据回答里的建议把lxml改成了html.parser就好了</p><p>当然只是解决问题我肯定是不满足的</p><p>后来继续寻找原因</p><p>发现是编码的问题</p><p>我一开始是把网页用utf-8解码之后才生成BeautifulSoup对象</p><p>于是这里出现了一些问题</p><p>解码之后的文件中出现了很多反斜杠【utf-8编码带来的</p><p>然后这使得网页格式出现了一些问题【有些标签未闭合</p><p>后来发现文档里有这么一句</p><blockquote><p>首先,文档被转换成Unicode,并且HTML的实例都被转换成Unicode编码<br></p></blockquote><p>因此对于utf-8格式的网页不需要解码编码直接传入即可</p>', '2015-03-24 11:36:02', 1),
('20150420230056', '【再挖个坑】添加一个备忘录的链接', '<p>记录一些常用的东西</p>', '2015-04-20 23:00:56', 0),
('20150427193938', '【填完个坑】搞一个提供打印的网页出来', '<p>原来的已经不能用了</p><p>完工</p>', '2015-05-08 23:45:21', 0),
('20150510132925', '战网新密码', '<p>spt94227<br></p>', '2015-05-10 13:29:25', 0),
('20150205235255', '终于搞定MySQL server has gone away错误了', '<p>原来是MySQL连接超时的问题<br></p><p>据sae官方的说明（附链接：<a href="http://sae.sina.com.cn/doc/python/faq.html" target="_blank">常见问题-SAE文档中心</a>）<br></p><blockquote><p>MySQL连接超时时间为30s，不是默认的8小时，所以你需要在代码中检查是否超时，是否需要重连。对于使用sqlalchemy的用户，需要在请求处理结束时调用 db.session.close() ，关闭当前session，将mysql连接还给连接池，并且将连接池的连接recyle时间设的小一点（推荐为10s）.</p></blockquote><p>于是在app config里添加了超时自动重连的参数<br></p><pre class="lang-python" data-lang="python">SQLALCHEMY_POOL_RECYCLE = 10<br></pre><p>并且在请求结束后调用了db.session.close()<br></p><p>目前为止没有再发生这种状况哈哈哈<br></p><p>至于这个神奇的参数是我google到的（MD他们是怎么知道的。。。文档里似乎没有啊。。。我回去在仔细看看）<br></p><p>【好吧还真有。。。附链接：<a href="http://pythonhosted.org/Flask-SQLAlchemy/config.html" target="_blank">Flask-SQLAlchemy Configuration Keys</a>】<br></p><p>总之问题解决了<br></p><p>可喜可贺，可口可乐<br></p><p>（恭喜恭喜 (((o(*ﾟ▽ﾟ*)o))) by wendy）<br></p>', '2015-02-05 23:52:55', 1),
('20150206205108', 'ubuntu终端的默认背景色', '<p>#290021<br></p>', '2015-02-06 20:51:08', 1),
('20150206205422', '一些好用的网站', '<p>图床：<a href="http://img.vim-cn.com/" target="_blank">http://img.vim-cn.com/</a></p><p>在线编译：<a href="http://codepad.org/" target="_blank">http://codepad.org/</a>（其实我一般用来分享代码哈哈哈）</p><p>分享代码：<a href="http://paste.ubuntu.com/" target="_blank">http://paste.ubuntu.com/</a>（好吧这个才是用来分享代码的）</p><p>pdf转其他格式：<a href="http://www.extractpdf.com/" target="_blank">http://www.extractpdf.com/</a>（非常好用）</p>', '2015-04-01 13:55:21', 0),
('20150206234058', '用python从贴吧扒连载小说', '<pre class="lang-python" data-lang="python">#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-

import codecs
import urllib2
import re
from bs4 import BeautifulSoup

def get_html_content(url = None):
    return urllib2.urlopen(url).read()

def get_page_content(chapter_link = None):
    page_content = get_html_content(chapter_link)
    bs = BeautifulSoup(page_content)
    content = bs.find_all(attrs = {''class'' : ''d_post_content j_d_post_content ''})
    result = u''''
    for it in content[1:]:
        result += it.get_text()

    return result

def main():
    serial_url = ''http://tieba.baidu.com/f/good?kw=%E6%8B%A9%E5%A4%A9%E8%AE%B0&amp;ie=utf-8&amp;cid=5&amp;pn=''
    tieba_url = ''http://tieba.baidu.com/''
    only_see_lz = ''?see_lz=1''

    fout = codecs.open(''zetianji.txt'', ''w'', ''utf-8'')
    chapter_list = []
    for pn in xrange(300, -1, -50):
        page_content = get_html_content(serial_url + str(pn))
        bs = BeautifulSoup(page_content, ''lxml'')
        title_list = bs.find_all(attrs = {''class'' : ''threadlist_text threadlist_title j_th_tit  ''})
        tmp = []
        for title in title_list:
            tmp.append([title.a[''title''], title.a[''href'']])

        chapter_list += reversed(tmp)

    for chapter_name, chapter_num in chapter_list:
        if u''【择天记】'' in chapter_name:
            print chapter_name
            print &gt;&gt; fout, get_page_content(tieba_url + chapter_num + only_see_lz)

if __name__ == ''__main__'':
    main()

</pre>', '2015-08-18 18:27:54', 1),
('20150206234314', '用python模拟登录百度', '<pre class="lang-python" data-lang="python">#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import re
import urllib
import urllib2
import cookielib

def main():
    host_url = ''http://www.baidu.com/''
    post_url = ''https://passport.baidu.com/v2/api/?login''
    get_token_url = ''https://passport.baidu.com/v2/api/?getapi&amp;class=login&amp;tpl=mn&amp;tangram=true''
    username = ''********''
    password = ''********''

    cookie_jar = cookielib.CookieJar()
    opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cookie_jar))

    #get cookie
    opener.open(host_url)

    #get token value
    token_value = re.search(r''\\w{32}'', opener.open(get_token_url).read()).group()

    #make post data
    post_data = {
        ''username''  : username,
        ''password''  : password,
        ''token''     : token_value,
        ''tpl''       : ''mn''
    }
    post_data = urllib.urlencode(post_data)

    #build request
    request = urllib2.Request(post_url, post_data)

    #login
    opener.open(request).read()
    for cookie in cookie_jar:
        print cookie

if __name__ == ''__main__'':
    main()
</pre>', '2015-02-06 23:43:14', 1),
('20150206234417', '用python自动玩QQ连连看', '<pre class="lang-python" data-lang="python"># -*- coding:utf-8 -*-

import win32api
import win32con
import time
from PIL import ImageGrab

left = 300
top = 248
img_w = 589
img_h = 385
w = 31
h = 35
rows = 11
cols = 19
diff = 0.996
blank = [0 for i in xrange(768)]

def hist_similar(lh, rh):
    return sum(1 - (0 if l == r else float(abs(l - r)) / max(l, r)) for l, r in zip(lh, rh)) / len(lh)

def get_id(i, j):
    return i * cols + j

def is_direct_connected(images, i1, j1, i2, j2):
    if i1 == i2:
        if j1 &gt; j2:
            j1, j2 = j2, j1
        for j in xrange(j1 + 1, j2):
            if images[i1][j]:
                return False
        return True
    else:
        if i1 &gt; i2:
            i1, i2 = i2, i1
        for i in xrange(i1 + 1, i2):
            if images[i][j1]:
                return False
        return True

def is_connected(images, i1, j1, i2, j2):
    if j1 &gt; j2:
        i1, i2 = i2, i1
        j1, j2 = j2, j1

    if i1 == i2 or j1 == j2:
        if is_direct_connected(images, i1, j1, i2, j2):
            return True

    for i in xrange(0, rows):
        if i == i1:
            if not images[i][j2] and is_direct_connected(images, i1, j1, i, j2) and is_direct_connected(images, i, j2, i2, j2):
                return True
        elif i == i2:
            if not images[i][j1] and is_direct_connected(images, i1, j1, i, j1) and is_direct_connected(images, i, j1, i2, j2):
                return True
        else:
            if not images[i][j1] and not images[i][j2] and is_direct_connected(images, i1, j1, i, j1) and is_direct_connected(images, i, j1, i, j2) and is_direct_connected(images, i, j2, i2, j2):
                return True

    for j in xrange(0, cols):
        if j == j1:
            if not images[i2][j] and is_direct_connected(images, i1, j1, i2, j) and is_direct_connected(images, i2, j, i2, j2):
                return True
        elif j == j2:
            if not images[i1][j] and is_direct_connected(images, i1, j1, i1, j) and is_direct_connected(images, i1, j, i2, j2):
                return True
        else:
            if not images[i1][j] and not images[i2][j] and is_direct_connected(images, i1, j1, i1, j) and is_direct_connected(images, i1, j, i2, j) and is_direct_connected(images, i2, j, i2, j2):
                return True

    return False

def click(x, y):
    win32api.SetCursorPos((x, y))
    win32api.mouse_event(win32con.MOUSEEVENTF_LEFTDOWN, x, y, 0, 0)
    win32api.mouse_event(win32con.MOUSEEVENTF_LEFTUP, x, y, 0, 0)
    time.sleep(0.5)

def connect(i1, j1, i2, j2):
    click(left + j1 * w + 10, top + i1 * h + 10)
    click(left + j2 * w + 10, top + i2 * h + 10)

def main():
    img = ImageGrab.grab((left, top, left + img_w, top + img_h))
    images = []
    g = [[False for j in xrange(rows * cols)] for i in xrange(rows * cols)]
    cnt = rows * cols
    for i in xrange(rows):
        tmp = []
        for j in xrange(cols):
            tmp.append(img.crop((j * w + 3, i * h + 2, (j + 1) * w - 7, (i + 1) * h - 4)).histogram())
        images.append(tmp)

    for i in xrange(rows):
        for j in xrange(cols):
            if hist_similar(images[i][j], blank) &gt; diff:
                images[i][j] = None
                cnt -= 1

    for i1 in xrange(rows):
        for j1 in xrange(cols):
            for i2 in xrange(rows):
                for j2 in xrange(cols):
                    if images[i1][j1] and images[i2][j2] and hist_similar(images[i1][j1], images[i2][j2]) &gt; diff:
                        g[get_id(i1, j1)][get_id(i2, j2)] = True

    while cnt:
        for i1 in xrange(rows):
            for j1 in xrange(cols):
                for i2 in xrange(rows):
                    for j2 in xrange(cols):
                        if not (i1 == i2 and j1 == j2) and images[i1][j1] and images[i2][j2] and g[get_id(i1, j1)][get_id(i2, j2)] and is_connected(images, i1, j1, i2, j2):
                            connect(i1, j1, i2, j2)
                            images[i1][j1] = images[i2][j2] = None
                            cnt -= 2

if __name__ == ''__main__'':
    main()
</pre>', '2015-02-06 23:44:17', 1),
('20150414092324', '【备忘】字体改成方正准圆', '<p>感觉这字体显示效果好萌<br></p><p>我没觉得萌，博神就会卖萌～～</p>', '2015-04-14 20:36:35', 0),
('20150209000759', '用最短的代码求大于且最接近给定数字的回文素数', '<pre class="lang-python" data-lang="python">def golf(x):
    while 1:
        x+=1
        if `x`==`x`[::-1]and~-2**x%x&lt;2:
            return x
</pre><p>判断素数那块的代码是google来的</p><p>没看懂到底是啥意思</p><p>终于弄懂了</p><p>基于费马小定理的一个假设（虽然这个假设是错的）</p><p>通过这个判断的可能会有伪素数（比如341）</p><p>不过目前发现的伪素数似乎都不是回文</p><p>于是排除了这一种情况</p>', '2015-02-10 13:06:40', 1),
('20150206142859', 'simditor以及highlight.js', '<p>首先是simditor的使用</p><p>这个很容易（附链接：<a href="http://simditor.tower.im/tours/tour-usage.html" target="_blank">Simditor使用方法</a>）</p><p>然后就是搭配simditor实现代码高亮的效果</p><p>首先simditor编辑的内容都要放到pre标签里</p><p>代码部分的格式是这样的：</p><pre class="lang-html" data-lang="html">&lt;div class="lang-c++ selected" data-lang="c++"&gt;</pre><p>而highlight.js提供的高亮的功能</p><p>我们只要把对应代码位置的class类型改成hightlight.js要求的格式就好了</p><p>这是google到的一份实现以上功能的js代码（附链接：<a href="http://ninan.sinaapp.com/note/show/use-simditor-as-django-WYSIWYG-editor/" target="_blank">使用simditor作为django的富文本编辑器</a>）：</p><pre class="lang-html" data-lang="html">&lt;script type="text/javascript" src="/static/js/highlight.js"&gt;&lt;/script&gt;
&lt;script&gt;
$(document).ready(function(){
        $("pre[class^=''lang'']").each(function(i, block){
            hljs.highlightBlock(block);    
        });
        hljs.initHighlightingOnLoad();  // 加这句是为了兼容之前的。
});
&lt;/script&gt;
</pre><p>就酱</p>', '2015-04-05 10:09:47', 1),
('20150212141839', '素数与素性测试', '<p>&nbsp; &nbsp; 一个数是素数（也叫质数），当且仅当它的约数只有两个——1和它本身。规定这两个约数不能相同，因此1不是素数。对素数的研究属于数论范畴，你可以看到许多数学家没事就想出一些符合某种性质的素数并称它为某某某素数。整个数论几乎就围绕着整除和素数之类的词转过去转过来。对于写代码的人来说，素数比想像中的更重要，Google一下BigPrime或者big_prime你总会发现大堆大堆用到了素数常量的程序代码。平时没事时可以记一些素数下来以备急用。我会选一些好记的素数，比如4567, 124567, 3214567, 23456789, 55566677, 1234567894987654321, 11111111111111111111111 (23个1)。我的手机号前10位是个素数。我的网站域名的ASCII码连起来(77 97 116 114 105 120 54 55 46 99 111 109)也是个素数。还有，我的某个MM的八位生日也是一个素数。每次写Hash函数之类的东西需要一个BigPrime常量时我就取她的生日，希望她能给我带来好运。偶尔我叫她素MM，没人知道是啥意思，她自己也不知道。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;素数有很多神奇的性质。我写5个在下面供大家欣赏。</p><p><strong>1. 素数的个数无限多（不存在最大的素数）</strong></p><p>&nbsp; &nbsp; 证明：反证法，假设存在最大的素数P，那么我们可以构造一个新的数2 * 3 * 5 * 7 * … * P + 1（所有的素数乘起来加1）。显然这个数不能被任一素数整除（所有素数除它都余1），这说明我们找到了一个更大的素数。</p><p><strong>2. 存在任意长的一段连续数，其中的所有数都是合数（相邻素数之间的间隔任意大）</strong></p><p>&nbsp; &nbsp; 证明：当0&lt;a&lt;=n时，n!+a能被a整除。长度为n-1的数列n!+2, n!+3, n!+4, …, n!+n中，所有的数都是合数。这个结论对所有大于1的整数n都成立，而n可以取到任意大。</p><p><strong>3. 所有大于2的素数都可以唯一地表示成两个平方数之差。</strong></p><p>&nbsp; &nbsp; 证明：大于2的素数都是奇数。假设这个数是2n+1。由于(n+1)^2=n^2+2n+1，(n+1)^2和n^2就是我们要找的两个平方数。下面证明这个方案是唯一的。如果素数p能表示成a^2-b^2，则p=a^2-b^2=(a+b)(a-b)。由于p是素数，那么只可能a+b=p且a-b=1，这给出了a和b的唯一解。</p><p><strong>4. 当n为大于2的整数时，2^n+1和2^n-1两个数中，如果其中一个数是素数，那么另一个数一定是合数。</strong></p><p>&nbsp; &nbsp; 证明：2^n不能被3整除。如果它被3除余1，那么2^n-1就能被3整除；如果被3除余2，那么2^n+1就能被3整除。总之，2^n+1和2^n-1中至少有一个是合数。</p><p><strong>5. 如果p是素数，a是小于p的正整数，那么a^(p-1) mod p = 1。</strong></p><p>&nbsp; &nbsp; 这个证明就有点麻烦了。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;首先我们证明这样一个结论：如果p是一个素数的话，那么对任意一个小于p的正整数a，a, 2a, 3a, …, (p-1)a除以p的余数正好是一个1到p-1的排列。例如，5是素数，3, 6, 9, 12除以5的余数分别为3, 1, 4, 2，正好就是1到4这四个数。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;反证法，假如结论不成立的话，那么就是说有两个小于p的正整数m和n使得na和ma除以p的余数相同。不妨假设n&gt;m，则p可以整除a(n-m)。但p是素数，那么a和n-m中至少有一个含有因子p。这显然是不可能的，因为a和n-m都比p小。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;用同余式表述，我们证明了：</p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (p-1)! ≡ a * 2a * 3a * … * (p-1)a (mod p)</p><p>&nbsp;&nbsp;&nbsp;&nbsp;也即：</p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (p-1)! ≡ (p-1)! * a^(p-1) (mod p)</p><p>&nbsp;&nbsp;&nbsp;&nbsp;两边同时除以(p-1)!，就得到了我们的最终结论：</p><p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1 ≡ a^(p-1) (mod p)</p><p>&nbsp;&nbsp;&nbsp;&nbsp;可惜最后这个定理最初不是我证明的。这是大数学家Fermat证明的，叫做Fermat小定理(Fermat''s Little Theorem)。Euler对这个定理进行了推广，叫做Euler定理。Euler一生的定理太多了，为了和其它的“Euler定理”区别开来，有些地方叫做Fermat小定理的Euler推广。Euler定理中需要用一个函数f(m)，它表示小于m的正整数中有多少个数和m互素（两个数只有公约数1称为互素）。为了方便，我们通常用记号φ(m)来表示这个函数（称作Euler函数）。Euler指出，如果a和m互素，那么a^φ(m) ≡ 1 (mod m)。可以看到，当m为素数时，φ(m)就等于m-1（所有小于m的正整数都与m互素），因此它是Fermat小定理的推广。定理的证明和Fermat小定理几乎相同，只是要考虑的式子变成了所有与m互素的数的乘积：m_1 * m_2 … m_φ(m) ≡ (a * m_1)(a * m_2) … (a * m_φ(m)) (mod m)。我为什么要顺便说一下Euler定理呢？因为下面一句话可以增加我网站的PV：这个定理出现在了The Hundred Greatest Theorems里。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;谈到Fermat小定理，数学历史上有很多误解。很长一段时间里，人们都认为Fermat小定理的逆命题是正确的，并且有人亲自验证了a=2, p&lt;300的所有情况。国外甚至流传着一种说法，认为中国在孔子时代就证明了这样的定理：如果n整除2^(n-1)-1，则n就是素数。后来某个英国学者进行考证后才发现那是因为他们翻译中国古文时出了错。1819年有人发现了Fermat小定理逆命题的第一个反例：虽然2的340次方除以341余1，但341=11*31。后来，人们又发现了561, 645, 1105等数都表明a=2时Fermat小定理的逆命题不成立。虽然这样的数不多，但不能忽视它们的存在。于是，人们把所有能整除2^(n-1)-1的合数n叫做伪素数(pseudoprime)，意思就是告诉人们这个素数是假的。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;不满足2^(n-1) mod n = 1的n一定不是素数；如果满足的话则多半是素数。这样，一个比试除法效率更高的素性判断方法出现了：制作一张伪素数表，记录某个范围内的所有伪素数，那么所有满足2^(n-1) mod n = 1且不在伪素数表中的n就是素数。之所以这种方法更快，是因为我们可以使用二分法快速计算2^(n-1) mod n 的值，这在计算机的帮助下变得非常容易；在计算机中也可以用二分查找有序数列、Hash表开散列、构建Trie树等方法使得查找伪素数表效率更高。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;有人自然会关心这样一个问题：伪素数的个数到底有多少？换句话说，如果我只计算2^(n-1) mod n的值，事先不准备伪素数表，那么素性判断出错的概率有多少？研究这个问题是很有价值的，毕竟我们是OIer，不可能背一个长度上千的常量数组带上考场。统计表明，在前10亿个自然数中共有50847534个素数，而满足2^(n-1) mod n = 1的合数n有5597个。这样算下来，算法出错的可能性约为0.00011。这个概率太高了，如果想免去建立伪素数表的工作，我们需要改进素性判断的算法。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;最简单的想法就是，我们刚才只考虑了a=2的情况。对于式子a^(n-1) mod n，取不同的a可能导致不同的结果。一个合数可能在a=2时通过了测试，但a=3时的计算结果却排除了素数的可能。于是，人们扩展了伪素数的定义，称满足a^(n-1) mod n = 1的合数n叫做以a为底的伪素数(pseudoprime to base a)。前10亿个自然数中同时以2和3为底的伪素数只有1272个，这个数目不到刚才的1/4。这告诉我们如果同时验证a=2和a=3两种情况，算法出错的概率降到了0.000025。容易想到，选择用来测试的a越多，算法越准确。通常我们的做法是，随机选择若干个小于待测数的正整数作为底数a进行若干次测试，只要有一次没有通过测试就立即把</p><p>这个数扔回合数的世界。这就是Fermat素性测试。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;人们自然会想，如果考虑了所有小于n的底数a，出错的概率是否就可以降到0呢？没想到的是，居然就有这样的合数，它可以通过所有a的测试（这个说法不准确，详见我在地核楼层的回复）。Carmichael第一个发现这样极端的伪素数，他把它们称作Carmichael数。你一定会以为这样的数一定很大。错。第一个Carmichael数小得惊人，仅仅是一个三位数，561。前10亿个自然数中Carmichael数也有600个之多。Carmichael数的存在说明，我们还需要继续加强素性判断的算法。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;Miller和Rabin两个人的工作让Fermat素性测试迈出了革命性的一步，建立了传说中的Miller-Rabin素性测试算法。新的测试基于下面的定理：如果p是素数，x是小于p的正整数，且x^2 mod p = 1，那么要么x=1，要么x=p-1。这是显然的，因为x^2 mod p = 1相当于p能整除x^2-1，也即p能整除(x+1)(x-1)。由于p是素数，那么只可能是x-1能被p整除(此时x=1)或x+1能被p整除(此时x=p-1)。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;我们下面来演示一下上面的定理如何应用在Fermat素性测试上。前面说过341可以通过以2为底的Fermat测试，因为2^340 mod 341=1。如果341真是素数的话，那么2^170 mod 341只可能是1或340；当算得2^170 mod 341确实等于1时，我们可以继续查看2^85除以341的结果。我们发现，2^85 mod 341=32，这一结果摘掉了341头上的素数皇冠，面具后面真实的嘴脸显现了出来，想假扮素数和我的素MM交往的企图暴露了出来。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;这就是Miller-Rabin素性测试的方法。不断地提取指数n-1中的因子2，把n-1表示成d*2^r（其中d是一个奇数）。那么我们需要计算的东西就变成了a的d*2^r次方除以n的余数。于是，a^(d * 2^(r-1))要么等于1，要么等于n-1。如果a^(d * 2^(r-1))等于1，定理继续适用于a^(d * 2^(r-2))，这样不断开方开下去，直到对于某个i满足a^(d * 2^i) mod n = n-1或者最后指数中的2用完了得到的a^d mod n=1或n-1。这样，Fermat小定理加强为如下形式：</p><p>&nbsp;&nbsp;&nbsp;&nbsp;尽可能提取因子2，把n-1表示成d*2^r，如果n是一个素数，那么或者a^d mod n=1，或者存在某个i使得a^(d*2^i) mod n=n-1 ( 0&lt;=i&lt;r ) （注意i可以等于0，这就把a^d mod n=n-1的情况统一到后面去了）</p><p>&nbsp;&nbsp;&nbsp;&nbsp;Miller-Rabin素性测试同样是不确定算法，我们把可以通过以a为底的Miller-Rabin测试的合数称作以a为底的强伪素数(strong pseudoprime)。第一个以2为底的强伪素数为2047。第一个以2和3为底的强伪素数则大到1 373 653。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;对于大数的素性判断，目前Miller-Rabin算法应用最广泛。一般底数仍然是随机选取，但当待测数不太大时，选择测试底数就有一些技巧了。比如，如果被测数小于4 759 123 141，那么只需要测试三个底数2, 7和61就足够了。当然，你测试的越多，正确的范围肯定也越大。如果你每次都用前7个素数(2, 3, 5, 7, 11, 13和17)进行测试，所有不超过341 550 071 728 320的数都是正确的。如果选用2, 3, 7, 61和24251作为底数，那么10^16内唯一的强伪素数为46 856 248 255 981。这样的一些结论使得Miller-Rabin算法在OI中非常实用。通常认为，Miller-Rabin素性测试的正确率可以令人接受，随机选取k个底数进行测试算法的失误率大概为4^(-k)。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;Miller-Rabin算法是一个RP算法。RP是时间复杂度的一种，主要针对判定性问题。一个算法是RP算法表明它可以在多项式的时间里完成，对于答案为否定的情形能够准确做出判断，但同时它也有可能把对的判成错的（错误概率不能超过1/2）。RP算法是基于随机化的，因此多次运行该算法可以降低错误率。还有其它的素性测试算法也是概率型的，比如Solovay-Strassen算法。另外一些素性测试算法则需要预先知道一些辅助信息（比如n-1的质因子），或者需要待测数满足一些条件（比如待测数必须是2^n-1的形式）。前几年AKS算法轰动世界，它是第一个多项式的、确定的、无需其它条件的素性判断算法。当时一篇论文发表出来，题目就叫PRIMES is in P，然后整个世界都疯了，我们班有几个MM那天还来了初潮。算法主要基于下面的事实：n是一个素数当且仅当(x-a)^n≡(x^n-a) (mod n)。注意这个x是多项式中的未知数，等式两边各是一个多项式。举个例子来说，当a=1时命题等价于如下结论：当n是素数时，杨辉三角的第n+1行除两头的1以外其它的数都能被n整除。</p><p><b><i><u><font color="#e33737">Matrix67原创</font></u></i></b></p><p><b><i><u><font color="#e33737">转贴请注明出处</font></u></i></b></p><p><a href="http://www.matrix67.com/blog/archives/234" target="_blank">原文链接</a></p>', '2015-02-12 14:28:04', 1),
('20150212170444', '【挖个坑】RSA算法', '<p><a href="http://www.matrix67.com/blog/archives/5100">http://www.matrix67.com/blog/archives/5100</a><br></p>', '2015-04-16 20:17:03', 1),
('20150819110032', '[CheckiO]Determine the order', '<p>这题显然是个拓扑排序<br></p><p>不过用Python写拓扑排序实在是太麻烦了</p><p>后来看了一下高手的解法</p><pre class="lang-python" data-lang="python">def checkio(data):
    distinct_letters = sorted(set("".join(data)))
    print distinct_letters
    #We just get couples of letters (a, b) such that a must be before b
    constraints = [(word[i], word[i + 1]) for word in data for i in range(len(word) - 1)]
    
    solution_found = False
    while not solution_found:
        solution_found = True
        for (a, b) in constraints:
            ia = distinct_letters.index(a)
            ib = distinct_letters.index(b)
            if ia &gt; ib:
                #We swap the letters
                distinct_letters[ia] = b
                distinct_letters[ib] = a
                solution_found = False
    return "".join(distinct_letters)
</pre><p>发现自己的思路太僵化了</p><p>这毕竟不是ACM的题目</p><p>没有时间复杂度的限制</p><p>解决问题的时候完全可以采取一些时间复杂度高但容易实现的解法</p>', '2015-08-19 11:00:32', 1),
('20150619211355', '[CheckiO]Solution', '<p>挺有意思的</p><p>要求返回值与任何值比较的结果均为真</p><p>一开始完全没头绪</p><p>后来看了一下评论里的提示</p><p>发现只要重载运算符就好了</p>', '2015-08-19 10:54:56', 1),
('20150720150958', 'python求最长公共前缀', '<p>利用os模块中求最长公共路径的函数</p><p>os.path.commonprefix</p><p>参数为字符串列表</p>', '2015-07-20 15:09:58', 1),
('20151103145752', '在Mac下开机启动vsftpd', '<p>vsftpd的搭建就不多说了</p><p>随便搜一下一大堆</p><p>但是Mac下开机启动vsftpd这个比较难搜到【我没搜到</p><p>一开始搞了好久没成功</p><p>后来发现主要原因是</p><p>vsftpd必须要以root身份启动</p><p>所以不能放在家目录下的Library/LaunchAgents/路径下</p><p>必须要放在系统的/Library/LaunchDaemons/路径下才行</p><p>当然权限也必须要对</p>', '2015-11-03 14:57:52', 1),
('20151212143924', 'Xcode，cocoapods，other linker flags', '<h2>背景</h2><p>在ios开发过程中，有时候会用到第三方的静态库(.a文件)，然后导入后发现编译正常但运行时会出现selector not recognized的错误，从而导致app闪退。接着仔细阅读库文件的说明文档，你可能会在文档中发现诸如在Other Linker Flags中加入-ObjC或者-all_load这样的解决方法。</p><p>那么，Other Linker Flags到底是用来干什么的呢？还有-ObjC和-all_load到底发挥了什么作用呢？</p><h2>链接器</h2><p>首先，要说明一下Other Linker Flags到底是用来干嘛的。说白了，就是ld命令除了默认参数外的其他参数。ld命令实现的是链接器的工作，详细说明可以在终端man ld查看。</p><p>如果有人不清楚链接器是什么东西的话，我可以作个简单的说明。</p><p>一个程序从简单易读的代码到可执行文件往往要经历以下步骤：</p><blockquote><p>源代码 &gt; 预处理器 &gt; 编译器 &gt; 汇编器 &gt; 机器码 &gt; 链接器 &gt; 可执行文件</p></blockquote><p>源文件经过一系列处理以后，会生成对应的.obj文件，然后一个项目必然会有许多.obj文件，并且这些文件之间会有各种各样的联系，例如函数调用。链接器做的事就是把这些目标文件和所用的一些库链接在一起形成一个完整的可执行文件。</p><p>可能我描述的比较肤浅，因为我自己了解的也不是很深，建议大家读一下这篇文章，可以对链接器做的事情有个大概的了解：<a target="_blank" href="http://www.dutor.net/index.php/2012/02/what-linkers-do/">链接器做了什么</a></p><h2>为什么会闪退</h2><p>苹果官方Q&amp;A上有这么一段话：</p><blockquote><p>The "selector not recognized" runtime exception occurs due to an issue between the implementation of standard UNIX static libraries, the linker and the dynamic nature of Objective-C. Objective-C does not define linker symbols for each function (or method, in Objective-C) - instead, linker symbols are only generated for each class. If you extend a pre-existing class with categories, the linker does not know to associate the object code of the core class implementation and the category implementation. This prevents objects created in the resulting application from responding to a selector that is defined in the category.</p></blockquote><p>翻译过来，大概意思就是Objective-C的链接器并不会为每个方法建立符号表，而是仅仅为类建立了符号表。这样的话，如果静态库中定义了已存在的一个类的分类，链接器就会以为这个类已经存在，不会把分类和核心类的代码合起来。这样的话，在最后的可执行文件中，就会缺少分类里的代码，这样函数调用就失败了。</p><h2>解决方法</h2><p>解决方法在背景那块我就提到了，就是在Other Linker Flags里加上所需的参数，用到的参数一般有以下3个：</p><ul><li>-ObjC</li><li>-all_load</li><li>-force_load</li></ul><p>下面来说说每个参数存在的意义和具体做的事情。</p><p>首先是-ObjC，一般这个参数足够解决前面提到的问题，苹果官方说明如下：</p><blockquote><p>This flag causes the linker to load every object file in the library that defines an Objective-C class or category. While this option will typically result in a larger executable (due to additional object code loaded into the application), it will allow the successful creation of effective Objective-C static libraries that contain categories on existing classes.</p></blockquote><p>简单说来，加了这个参数后，链接器就会把静态库中所有的Objective-C类和分类都加载到最后的可执行文件中，虽然这样可能会因为加载了很多不必要的文件而导致可执行文件变大，但是这个参数很好地解决了我们所遇到的问题。但是事实真的是这样的吗？</p><p>如果-ObjC参数真的这么有效，那么事情就会简单多了。</p><blockquote><p>Important: For 64-bit and iPhone OS applications, there is a linker bug that prevents -ObjC from loading objects files from static libraries that contain only categories and no classes. The workaround is to use the -allload or -forceload flags.</p></blockquote><p>当静态库中只有分类而没有类的时候，-ObjC参数就会失效了。这时候，就需要使用-all_load或者-force_load了。</p><p>-all_load会让链接器把所有找到的目标文件都加载到可执行文件中，但是千万不要随便使用这个参数！假如你使用了不止一个静态库文件，然后又使用了这个参数，那么你很有可能会遇到ld: duplicate symbol错误，因为不同的库文件里面可能会有相同的目标文件，所以建议在遇到-ObjC失效的情况下使用-force_load参数。</p><p>-force_load所做的事情跟-all_load其实是一样的，但是-force_load需要指定要进行全部加载的库文件的路径，这样的话，你就只是完全加载了一个库文件，不影响其余库文件的按需加载。</p>', '2016-01-19 11:29:53', 1),
('20160520175145', '关于PS1长度计算的一些问题', '<p>首先不需要计算到总长度里的内容需要用\\[跟\\]包起来</p><p>这个教程里基本都能搜到</p><p>还有一个就是一些比较特殊的字符</p><p>比如这个【</p><p>也会造成长度计算不对</p><p>所以后来我换成了&lt;</p><p>可能对于中文的符号支持不够吧</p><p>以上</p>', '2016-05-20 17:51:45', 1),
('20160524184148', '卧槽新增这块居然没做登陆限制', '<p>rt</p>', '2016-05-24 18:42:24', 0);


INSERT INTO `reminder` (`rid`, `time_`, `content`, `deadline`, `is_visible`) VALUES
(1, '2015-06-11 15:59:07', '假装把坑填完了hhh', '2015-06-11', 1),
(2, '2015-06-17 18:57:18', '生源地贷款网站密码与常用密码一致（仅字母与数字）', '2015-06-17', 1),
(3, '2015-07-15 15:19:27', '添加一个小功能：去掉字符串中的空格', '2015-07-15', 1),
(4, '2015-07-20 09:07:32', 'erp密码：spt12345', '2015-07-20', 1),
(5, '2015-10-12 18:46:47', 'erp新密码:spt54321', '2015-10-12', 1),
(6, '2015-12-05 12:51:07', 'fphx-98an-hbyk-h2ap-9ck6', '2015-12-05', 1),
(7, '2016-05-29 11:29:22', 'http://www.pornhub.com/', '2016-05-29', 1),
(8, '2016-05-29 11:29:30', 'http://www.xvideos.com/', '2016-05-29', 1),
(9, '2016-05-29 11:30:04', 'https://cn.bongacams.com/', '2016-05-29', 1),
(10, '2016-06-20 14:11:33', 'http://www.wnacg.com/albums.html', '2016-06-20', 1);

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`uid`, `name`, `password`) VALUES
(1, 'rikka', 'yuta');
