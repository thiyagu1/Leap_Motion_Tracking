# - Config file for the LeapC++ package
# It defines the following variables
#  LeapC++_FOUND - indicates that the module was found
#  LeapC++_INCLUDE_DIR - include directories

# Check if local build
if ("C:/Varjo_software/Leap/LeapCxx-master/build" STREQUAL CMAKE_CURRENT_LIST_DIR)
  set(LeapC++_INCLUDE_DIR "C:/Varjo_software/Leap/LeapCxx-master")
  include("${CMAKE_CURRENT_LIST_DIR}/LeapC++Targets.cmake")
else()
  set(LeapC++_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}/include")
  include("${CMAKE_CURRENT_LIST_DIR}/cmake/LeapC++Targets.cmake")
endif()

set(LeapC++_FOUND TRUE)
