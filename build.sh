#!/bin/bash
set -e

export PATH="/home/valdikss/mobile-modem-router/e5372/kernel/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabi/bin:$PATH"

mkdir -p installed/huawei/{vfp3,novfp} || true

# Balong Hi6921 V7R11 (E3372h, E5770, E5577, E5573, E8372, E8378, etc) and Hi6930 V7R2 (E3372s, E5373, E5377, E5786, etc)
# softfp, vfpv3-d16 FPU
export CFLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -mthumb -O2 -s"

make clean || true
CHOST=arm-linux-gnueabi ./configure --prefix="$PWD/installed/huawei/vfp3" --static
make "$@"
make install

# Balong Hi6920 V7R1 (E3272, E3276, E5372, etc)
# soft, novfp
export CFLAGS="-march=armv7-a -mfloat-abi=soft -mthumb -O2 -s"

make clean || true
CHOST=arm-linux-gnueabi ./configure --prefix="$PWD/installed/huawei/novfp" --static
make "$@"
make install
