use strict;
use warnings;
use Data::Dumper;
use List::Util qw(min);
use List::Util qw(max);
use JSON;
# first star
open(my $in,  "<",  "measurements_a.txt")  or die "Can't open input.txt: $!";

my %answer ;
my %count;

while (my $line = <$in>) {
  chomp($line);z
  my @break = split(";",$line);
  my $name=$break[0];
  my $value=$break[1];

  if (exists $answer{$name}){
    my $old_count = $count{$name};
    my $new_count = $old_count+1;
    my $new_min = min($value,$answer{$name}[0]);
    my $new_avg = sprintf("%.1f",($answer{$name}[0]*$old_count+$value)/($new_count));
    my $new_high = max($value,$answer{$name}[0]);
    $count{$name} = $new_count;
    $answer{$name} = [$new_min,$new_avg,$new_high];
  }else{
    $count{$name}=1;
    $answer{$name} = [$value,$value,$value];
  }
}
my %ans;

my $key;
foreach $key (keys %answer)
{
  $ans{$key}= $answer{$key}[0]."/".$answer{$key}[1]."/".$answer{$key}[2];
}

# print Dumper(\%ans);
my $json = encode_json \%ans;
print $json