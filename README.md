# collectd

collectd インストール

```sh
yum -y install epel-release

yum -y install \
  collectd \
  collectd-curl \
  collectd-ping \
  collectd-rrdtool \
  collectd-snmp \
  collectd-web \
  collectd-write_prometheus
```

設定ファイルを撒く

```sh
/vagrant/diff.sh
/vagrant/copyto.sh
```

collectd 開始

```sh
systemctl enable collectd
systemctl start  collectd
systemctl status collectd
```

Apache のアクセス許可設定


```sh
sed -i /etc/httpd/conf.d/collectd.conf -e 's/Require local/Require all granted/'
```

Apache 開始

```sh
systemctl enable httpd
systemctl start  httpd
systemctl status httpd
```

Prometheus インストール

```sh
wget https://github.com/prometheus/prometheus/releases/download/v1.5.2/prometheus-1.5.2.linux-amd64.tar.gz
tar xvzf prometheus-1.5.2.linux-amd64.tar.gz
mv prometheus-1.5.2.linux-amd64/prometheus /usr/local/bin
```

Prometheus の設定ファイル

```sh
cat <<'EOS'> /etc/prometheus.yml
global:
scrape_configs:
  - job_name: collectd
    honor_labels: true
    static_configs:
      - targets:
          - localhost:9103
EOS
```

Prometheus のデータディレクトリを作成

```sh
mkdir -p /var/lib/prometheus/data
```

Prometheus 開始

```sh
systemd-run --unit=prometheus prometheus \
  -config.file /etc/prometheus.yml \
  -storage.local.path /var/lib/prometheus/data

systemctl status prometheus
```

## 参考

- https://collectd.org/
- http://qiita.com/28tomono/items/33d3520e81f39fe2f96f
