# dotfiles

コマンド/アプリケーションインストールをbrewでやってしまう  

### usage
    % git clone https://github.com/chanshige/dotfiles.git
    % cd dotfiles
    $ sh lib/dotfiles.sh

### memo
    Virtualboxなど、「カーネル機能拡張」を許可しなければならないアプリの場合はインストールがコケる。  
    その場合、環境設定で一度"許可"の処理を行ってから brew cask install 'app_name' 等で対応すれば問題ない。
