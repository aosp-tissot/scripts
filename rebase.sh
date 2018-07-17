#!/usr/bin/env bash

#COLORS -
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
end=$'\e[0m'


# Assumes source is in users home in a directory called "aosp"
export CAFPATH="${HOME}/aosp"

# Set the tag you want to merge
export TAG="android-8.1.0_r39"

# Set the branch you want to merge it into
export BRANCH="oreo-mr1"

do_not_merge="
aosp-tissot
vendor/xiaomi/tissot
device/phh/treble
SnapdragonCamera
hardware/interfaces
"

cd ${CAFPATH}

for filess in failed success
do
rm $filess 2> /dev/null
touch $filess
done
# CAF manifest is setup with path first, then repo name, so the path attribute is after 2 spaces, and the name within "" in it
for repos in $(grep 'aosp-tissot' ${CAFPATH}/.repo/local_manifest.xml  | awk '{print $2}' | cut -d '"' -f2)
do
echo -e ""
if [[ "${do_not_merge}" =~ "${repos}" ]];
then
echo -e "${repos} is not to be merged";
else
echo "$blu Merging $repos $end"
echo -e ""
cd $repos;
git checkout -b $BRANCH
git remote add upstream https://android.googlesource.com/platform/$repos
git fetch --tags upstream
git merge $TAG
if [ $? -ne 0 ];
then
echo "$repos" >> ${CAFPATH}/failed
echo "$red $repos failed :( $end"
else
echo "$repos" >> ${CAFPATH}/success
echo "$grn $repos succeeded $end"
fi
echo -e ""
cd ${CAFPATH};
fi
done

echo -e ""
echo -e "$red These repos failed $end"
cat ./failed
echo -e ""
echo -e "$grn These succeeded $end"
cat ./success


