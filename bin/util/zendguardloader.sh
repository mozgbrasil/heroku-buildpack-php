#!/usr/bin/env bash
# Build Path: /app/.heroku/php/

OUT_PREFIX=$1

# fail hard
set -o pipefail
# fail harder
set -eux

DEFAULT_VERSION="LATEST"
dep_version=${VERSION:-$DEFAULT_VERSION}
dep_url=https://github.com/mozgbrasil/storage/blob/master/php_extensions/zend-loader-php5.6-linux-x86_64_update1.tar.gz?raw=true
dep_dirname=zend-loader-php5.6-linux-x86_64

echo "- Zend Guard Loader installing --> Packaging ext-zend-guard-loader ${DEFAULT_VERSION}..."

curl -L ${dep_url} | tar xz

pushd ${dep_dirname}
ext_dir=/app/.heroku/php/lib/php/extensions/no-debug-non-zts-20131226
echo ext_dir
bin_dir=${OUT_PREFIX}/bin
mkdir -p ${ext_dir}
mkdir -p ${bin_dir}
cp ZendGuardLoader.so ${ext_dir}/ZendGuardLoader.so
cp opcache.so ${ext_dir}/opcache.so
popd

echo "-----> Done."