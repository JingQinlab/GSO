##Author: Dr. Jing QIN, School of Life Sciences, The Chinese University of Hong Kong
##Email: qinjing@cuhk.edu.hk

##It should be run in the output folder of GSO or gLASSO, in which output matrices XHard.txt or XSoft.txt should be in a list of folders, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s12, s14, s16, s18, s20.

for d in s*
do
cd $d
for f in X*.txt; do paste ../../../Input/DEGlist.txt $f > $f.name; done
for f in X*.txt.name; do perl -pi -e 's/[\t ]+/\t/g' $f; done
for f in X*.txt.name ; do cat ../../../Input/TFlistL.txt $f > $f.tf; done
rm X*.txt.name
cd ../
done

perl ../../Code/TFScoring.pl $1
