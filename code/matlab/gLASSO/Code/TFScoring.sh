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
