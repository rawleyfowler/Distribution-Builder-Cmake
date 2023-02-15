use v6.d;

unit class Distribution::Builder::Cmake;

has %.meta;

method build(IO() $work-dir = $*CWD) {
    my %meta = %!meta<build>;
    die 'You need CMake to install this package!' unless shell 'which cmake';
    die 'You need Make to install this package!' unless shell 'which make';

    # Prepare to build
    my $src-dir = %meta<src-dir> // 'cc';
    my $cmake-src-dir = "$work-dir/$src-dir";
    die "$cmake-src-dir is not a directory." unless $cmake-src-dir.IO.e && $cmake-src-dir.IO.d;

    # Build
    my $build-dir = "$cmake-src-dir/build";
    mkdir $build-dir;
    die 'Failed to run cmake, or compile this package.' unless shell "cd $build-dir && cmake .. && make";

    # Prepare library target
    my $library = "lib{ %meta<lib> }.so"; # If your cmake is setup properly, then it should start with 'lib'
    unlink "$work-dir/$library" if "$work-dir/$library".IO.e;

    # Prepare install location
    my $install = %meta<install> // 'resources/libraries';
    $install ~= '/';
    my $install-location = "$work-dir/$install";
    mkdir $install-location;

    # Install
    die "Failed to install lib: $library" unless copy "$build-dir/$library", "$install-location/$library";

    True;
}
