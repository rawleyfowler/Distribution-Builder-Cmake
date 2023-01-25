Distribution::Builder::Cmake
====
A dead simple way to run FFI with a language that supports CMake (C/C++)

SYNOPSIS
========

INSTALLATION
=========
```shell
zef install Distribution::Builder::Cmake
```

USAGE
=========
Assuming your Raku project has a folder in it called `my-cmake-project`, and your exported lib is `my-lib`. 
In your `"build"` section of `META6.json` you'll add the following:
```json
{ ...
    "builder": "Distribution::Builder::Cmake",
    "build": {
        "lib": "my-lib",
        "src-dir": "my-cmake-project"
    }
  ...
}
```

The typical CMake project will look like (assuming your lib is `my-lib`):
```cmake
cmake_minimum_required(VERSION 3.9)
project(my-lib VERSION 1.0.0 DESCRIPTION "My lib!")
add_library(my-lib SHARED my-lib.cc)
set_target_properties(my-lib PROPERTIES VERSION ${PROJECT_VERSION})
set_target_properties(my-lib PROPERTIES SOVERSION 1)
set_target_properties(my-lib PROPERTIES PUBLIC_HEADER my-lib.hh)
target_include_directories(my-lib PRIVATE .)
install(TARGETS my-lib
	LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
	PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
```

You can see an example of this in action in [this repo](https://github.com/rawleyfowler/Raku-Cpp-Example)

(Obviously, you'll need Make and CMake installed)

AUTHOR
======

    <Rawley Fowler>

COPYRIGHT AND LICENSE
=====================

Copyright 2023 

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

