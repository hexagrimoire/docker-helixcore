#action test 終わっったら消す
FROM ubuntu:bionic
#Dockerfile内処理で利用するパッケージを一括ダウンロード
RUN apt-get update && apt-get -y install wget gnupg less language-pack-ja-base language-pack-ja tzdata

#サーバーの初期設定
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN echo 'export LANG=ja_JP.UTF-8' >> ~/.bashrc ;\
    echo 'export LANGUAGE="ja_JP:ja"' >> ~/.bashrc

#aptでパッケージをダウンロードできるようになるまでの準備
RUN wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add - ;\
    echo "deb http://package.perforce.com/apt/ubuntu bionic release" >> /etc/apt/sources.list.d/perforce.list

#perforceサーバーで利用するポートを指定
EXPOSE 1666
RUN apt-get update && apt-get -y install helix-p4d

#サーバー利用の際の初期設定 -pは 通信方式:サーバーIP:利用ポート のように記述すること。接続の際もも同じように入力する
ENV server_name hasegawa_perforce

RUN /opt/perforce/sbin/configure-helix-p4d.sh ${server_name} -n -p ssl:1666 -u hasegawa -P ULmon_6fG --unicode --case 0
ADD ["server_run.sh", "server_run.sh"]
CMD ["bash", "-c", "./server_run.sh ${server_name}"]