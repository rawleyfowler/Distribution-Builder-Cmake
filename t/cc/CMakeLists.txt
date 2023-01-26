cmake_minimum_required(VERSION 3.9)
project(test VERSION 1.0.0 DESCRIPTION "My lib!")
add_library(test SHARED test.cpp)
set_target_properties(test PROPERTIES VERSION ${PROJECT_VERSION})
set_target_properties(test PROPERTIES SOVERSION 1)
target_include_directories(test PRIVATE .)
install(TARGETS test
	LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
	PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
