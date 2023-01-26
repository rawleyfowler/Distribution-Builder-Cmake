use v6.d;

unit class Distribution::Builder::Cmake;

has %.meta;

method build(IO() $work-dir = $*CWD) {
	my %meta = %!meta<build>;
	die 'You need CMake to install this package!' unless shell 'which cmake';
	die 'You need Make to install this package!' unless shell 'which make';

	my $src-dir = %meta<src-dir> // 'cc';
	my $cmake-src-dir = "$work-dir/$src-dir";
	die "$cmake-src-dir is not a directory." unless $cmake-src-dir.IO.e && $cmake-src-dir.IO.d;

	my $build-dir = "$cmake-src-dir/build";
	mkdir $build-dir;
	die 'Failed to run cmake, or compile this package.' unless shell "cd $build-dir && cmake .. && make";

	my $library = "lib{ %meta<lib> }.so"; # If your cmake is setup properly, then it should start with 'lib'
	unlink "$work-dir/$library" if "$work-dir/$library".IO.e;
	my $install = %!meta<install> // '';
	$install ~= '/';
	my $install-location = "$work-dir/$install$library";
	die "Failed to install lib: $library" unless shell "ln -sf $build-dir/$library $install-location";
	True;
}
