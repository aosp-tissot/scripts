#!/usr/bin/env bash
cd build/make
git am ~/aosp/treble_patches/patches/platform_build/*.patch
git apply --whitespace=fix ~/aosp/treble_patches/patches/platform_bionic/001_fix_build_issues.patch
cd -
cd frameworks/av
git am ~/aosp/treble_patches/patches/platform_frameworks_av/*.patch
cd -
cd frameworks/native
git am ~/aosp/treble_patches/patches/platform_frameworks_native/*.patch
cd -
cd system/core
git am ~/aosp/treble_patches/patches/platform_system_core/*.patch

cd -
cd system/bt
git am ~/aosp/treble_patches/patches/platform_system_bt/*.patch
cd -
cd system/libvintf
git am ~/aosp/treble_patches/patches/platform_system_libvintf/*.patch
cd -
cd system/vold
git am ~/aosp/treble_patches/patches/platform_system_vold/*.patch
cd -
cd frameworks/opt/telephony
git am ~/aosp/treble_patches/patches/platform_frameworks_opt_telephony/*.patch
cd -
cd external/selinux
git am ~/aosp/treble_patches/patches/platform_external_selinux/*.patch
cd -
cd frameworks/base
git am ~/aosp/treble_patches/patches/platform_frameworks_base/*.patch
cd -
cd bionic
git apply --whitespace=fix ~/aosp/treble_patches/patches/platform_bionic/*.patch
cd -
cd system/sepolicy
git apply --whitespace=fix ~/aosp/treble_patches/patches/platform_system_sepolicy/*.patch
