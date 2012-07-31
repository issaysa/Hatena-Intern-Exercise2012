package TemplateEngine;

use strict;

sub new {
  my $class = shift;
	my $f = { @_ };
	open my $fh, $f->{file} or die;
	bless \$fh, $class;
}

sub render {
	my $self = shift;
	my $var = shift;
	my $fh = $$self;
	foreach ( keys %$var ) {
		$var->{$_} =~ s/&/&amp;/go;
		$var->{$_} =~ s/</&lt;/go;
		$var->{$_} =~ s/>/&gt;/go;
		$var->{$_} =~ s/"/&quot;/go;
		$var->{$_} =~ s/'/&#39;/go;
	}
	my $text;
	while ( <$fh> ) {
		chomp;
		s/{%\s(\w+)\s%}/$var->{$1}/g;
		$text .= "$_\n";
	}
	chomp $text;
	return $text;
}

1;

__END__			