#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "LeapC++::LeapC++" for configuration "Release"
set_property(TARGET LeapC++::LeapC++ APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(LeapC++::LeapC++ PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX;RC"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/LeapC++.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS LeapC++::LeapC++ )
list(APPEND _IMPORT_CHECK_FILES_FOR_LeapC++::LeapC++ "${_IMPORT_PREFIX}/lib/LeapC++.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
