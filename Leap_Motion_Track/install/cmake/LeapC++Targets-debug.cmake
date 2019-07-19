#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "LeapC++::LeapC++" for configuration "Debug"
set_property(TARGET LeapC++::LeapC++ APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(LeapC++::LeapC++ PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX;RC"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/LeapC++.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS LeapC++::LeapC++ )
list(APPEND _IMPORT_CHECK_FILES_FOR_LeapC++::LeapC++ "${_IMPORT_PREFIX}/lib/LeapC++.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
