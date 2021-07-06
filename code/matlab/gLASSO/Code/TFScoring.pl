my @sparsity = (1,2,3,4,5,6,7,8,9,10,12,14,16,18,20);
my $method = $ARGV[0];
open OUTPUT, ">$ARGV[0]"."_TFranking.txt" || die "Can not open output file $!";
my %x;
    foreach my $s (@sparsity){
        my $sparsity = $s;
        my $folder = join "", "s", $sparsity;
        my $file = join "", "$folder/", "X", $method, ".txt.name.tf";
        open MX, $file || die "Can not open $file file $!";
        my @TF;
        while (<MX>){
            chomp;
            my @line = split "\t";
            if ($line[0] eq "Target"){
                foreach my $TF (@line[1..$#line]){
                    $x{$TF}= 0 unless defined $x{$TF};
                    push @TF, $TF;
                }
            }else{
                foreach my $index (1..$#line){
                    my $x_value = ($line[$index] == 0 ? 0 : 1);
                    my $score = $x_value/$sparsity;
                    my $TF = $TF[$index-1];
                    $x{$TF} = $score if $x{$TF} < $score;
                }
				last;
            }
        }
    }
    foreach my $TF (sort { $x{$b} <=> $x{$a} } keys %x){
		print OUTPUT join ("\t", $TF, $x{$TF}), "\n" if $x{$TF} != 0;
    }
close OUTPUT;
