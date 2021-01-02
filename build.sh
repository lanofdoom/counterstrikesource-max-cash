#!/bin/bash -ue

tools=https://sm.alliedmods.net/smdrop/1.10/sourcemod-1.10.0-git6502-linux.tar.gz

tmp_dir=$(mktemp -d)
echo using temporary folder: $tmp_dir >&2
clean () {
    rm -rf $tmp_dir
    echo deleted temporary folder >&2
}
trap clean EXIT

curl $tools -o $tmp_dir/tools.tar.gz
tar -xf $tmp_dir/tools.tar.gz -C $tmp_dir
$tmp_dir/addons/sourcemod/scripting/spcomp max_cash.sp

mkdir build
mv max_cash.smx build/max_cash.smx
tar -czvf build/max_cash_source.tar.gz build.sh max_cash.sp LICENSE README.md

echo created build/max_cash.smx