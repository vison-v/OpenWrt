#!/bin/bash 
git clone https://github.com/vernesong/OpenClash.git package/luci-app-openclash
./scripts/feeds update -a
./scripts/feeds install -a
