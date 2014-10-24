package ST01;
use strict;

my @menu=
(
"1.Add object.",
"2.Change.",
"3.Delete.",
"4.Print all elements.",
"5.Save as file.",
"6.Read file.",
"7.Exit."
);

my @option_func=
(
\&add,
\&change,
\&delete,
\&printall,
\&tofile,
\&fromfile,
);
my @students;

sub add
{
		print "press name\n";
		chomp(my $name=<STDIN>);
		print "press surname\n";
		chomp(my $surname=<STDIN>);
		print "press group\n";
		chomp(my $group=<STDIN>);
		print "press age\n";
		chomp(my $age=<STDIN>);
	my $sthash=
		{
			name=>$name,
			surname=>$surname,
			group=>$group,
			age=>$age
		};
	push(@students,$sthash);
}

sub delete
{
	print "press number of deleted object\n";
	my $k=<STDIN>;
	if (defined $students[$k-1])
	{ 
		splice(@students,$k-1,1);
		print "object $k deleted\n";}
	else {
		print "object $k is undefed\n"
	}
}

sub change
{
	print "press number of changed object\n";
	my $k=<STDIN>;
	if (defined $students[$k-1])
	{ 
		my $hashref=$students[$k-1];
		foreach my $key ( sort keys %$hashref){
			print "$key\n";
			chomp(my $hash=<STDIN>);
			$hashref->{$key}=$hash;
		}
		print "object $k changed\n";}
	else {
		print "object $k is undefed\n"
	}
}

sub printall
{
	my $i=0;
	if(defined @students)
		{
			foreach	my $item (@students)
				{	
					$i++;	
					print "Student $i:\n";
					print "Name: $item->{name}\n"."Surname: $item->{surname}\n". "Group:$item->{group}\n"."Age: $item->{age}\n------------------------------\n";
				}
		}
	else {
			print "List is clear\n";
		}
}

sub menu
{
	print "\n------------------------------\n";
	foreach my $s(@menu)
	{
		print "$s\n";
	}
	print "------------------------------\n";
	my $ch = <STDIN>;
	return ($ch-1);
}

sub tofile
{
	dbmopen(my %hash, "AbramovData",0644);
	my $i=0;
	my $s;
	if(defined @students)
	{
	foreach my $item(@students)
		{
		my @a=("name",$item->{name},"surname",$item->{surname},"group",$item->{group},"age",$item->{age});	
		chomp($s=join(",",@a));
		$hash{$i}=$s;
		$i++;
		}
		print "file saved\n";
	}
	else {
			print "List is clear\n";
		}
	dbmclose(%hash);	
}
sub fromfile
{
	dbmopen(my %hash, "AbramovData",0644);
		while (( my $key,my $value) = each(%hash))
	{
		my @st=split(/,/,$hash{$key});
		$students[$key]={@st};
	}
	dbmclose(%hash);
}

Sub 1
{
while(1)
{
	my $ch = menu();
	if(defined $option_func[$ch])
	{
		print "\n".$menu[$ch]." launching...\n\n";
		$option_func[$ch]->();
	}
	else
	{
		return;
	}
}
}
return 1;
