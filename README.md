はじめに
========

これは Windows 上に chef-solo と knife-solo の環境を構築するバッチファイルです。

chef-solo を利用するとローカルの Windows 環境が 1 コマンドで構築できます。

knife-solo を利用するとリモートの Unix 環境が 1 コマンドで構築できます。

インストール
------------

バッチファイルをインストールするディレクトリ（推奨は C:\chef）に
[install.bat](https://github.com/HirotakaKato/windows-chef/blob/master/install.bat) を
[ダウンロード](https://raw.github.com/HirotakaKato/windows-chef/master/install.bat)
して「管理者として実行」してください。

次の処理が行われます。

1. C:\git\bin に
   [7za.exe](https://github.com/HirotakaKato/windows-chef/tree/master/7za920)
   がダウンロードされます。

2. C:\git\bin に
   [ANSICON](https://github.com/adoxa/ansicon/releases)
   が展開されます。

3. C:\git に
   [PortableGit](http://code.google.com/p/msysgit/downloads/list?q=PortableGit)
   が展開されます。

4. システム環境変数 Path に C:\git\bin が追加されます。

5. C:\opscode に
   [Chef](http://www.getchef.com/chef/install/)
   がインストールされます。

6. install.bat と同じディレクトリに nodes と nodes\prepare ディレクトリが作成されます。

7. install.bat と同じディレクトリに次のファイルがダウンロードされます（ファイルが存在しない場合）。
   1. [solo.bat](https://github.com/HirotakaKato/windows-chef/blob/master/solo.bat)
   2. [solo.json](https://github.com/HirotakaKato/windows-chef/blob/master/solo.json)
   3. [solo.rb](https://github.com/HirotakaKato/windows-chef/blob/master/solo.rb)
   4. [knife-solo-cook.bat](https://github.com/HirotakaKato/windows-chef/blob/master/knife-solo-cook.bat)
   5. [knife-solo-prepare.bat](https://github.com/HirotakaKato/windows-chef/blob/master/knife-solo-prepare.bat)

8. install.bat と同じディレクトリに
   [cookbooks](https://github.com/HirotakaKato/cookbooks)
   が git clone されます（ディレクトリが存在しない場合）。

chef-solo の設定
----------------

solo.json の run_list にインストールするプログラムを追加してください。

chef-solo の実行
----------------

solo.bat を「管理者として実行」してください。

knife-solo の設定
-----------------

1. solo.bat を「管理者として実行」して knife-solo をインストールしてください。

2. nodes ディレクトリに **HOSTNAME**.json を作成してください（**HOSTNAME** は knife-solo の接続先ホスト名）。

3. knife-solo-cook.bat を nodes\\**HOSTNAME**.bat にリネームもしくはコピーしてください。

4. knife-solo-prepare.bat を nodes\prepare\\**HOSTNAME**.bat にリネームもしくはコピーしてください。

knife-solo の実行
-----------------

最初に nodes\prepare\\**HOSTNAME**.bat を実行してください。

次の処理が行われます。

1. ssh 鍵が作成されます（ホームディレクトリに .ssh\\**HOSTNAME** が存在しない場合）。

2. **HOSTNAME** にユーザ root で ssh 接続が行われるので **root のパスワードを入力してください**。

3. **HOSTNAME** にユーザ chef が作成され ssh 公開鍵認証と sudo の設定が行われます。

4. **HOSTNAME** に対して knife solo prepare が実行されます。

5. **HOSTNAME** に対して knife solo cook -o prepare が実行されます。

以降は nodes\\**HOSTNAME**.bat を実行してください。

参照
----

1. [Chef](http://www.getchef.com/chef/)
2. [Git for Windows](http://msysgit.github.io/)
3. [ANSICON](https://github.com/adoxa/ansicon)
4. [7-Zip](http://sourceforge.jp/projects/sevenzip/)

License
-------

Copyright (c) 2014 Hirotaka Kato

This software is released under the [MIT License](http://opensource.org/licenses/mit-license.php).
