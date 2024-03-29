set(PACKAGE_VERSION "0.1.0")

if(LeapC++_DEBUG)
  message(STATUS "Debug mode on")
  message(STATUS "Installed LeapC++_VERSION: ${PACKAGE_VERSION}")

  message(STATUS "Installed LeapC++_BUILD_ARCHITECTURES: x64")
  message(STATUS "Configured LeapC++_BUILD_ARCHITECTURES: ${LeapC++_BUILD_ARCHITECTURES}")

  message(STATUS "Installed CMAKE_SIZEOF_VOID_P: 8")
  message(STATUS "Configured CMAKE_SIZEOF_VOID_P: ${CMAKE_SIZEOF_VOID_P}")
endif()

# If the customer has an override architecture requirement, use that
if(DEFINED LeapC++_ARCHITECTURE)
  foreach(_arch IN LISTS LeapC++_ARCHITECTURE)
    if(_arch MATCHES "amd64|x86_64|x64")
      list(APPEND LeapC++_ARCHITECTURES x64)
    elseif(_arch MATCHES "i386|x86")
      list(APPEND LeapC++_ARCHITECTURES x86)
    elseif(_arch MATCHES "armeabi-v7a")
      list(APPEND LeapC++_ARCHITECTURES armeabi-v7a)
    elseif(_arch MATCHES "armeabi")
      list(APPEND LeapC++_ARCHITECTURES armeabi)
    elseif(_arch MATCHES "^arm")
      list(APPEND LeapC++_ARCHITECTURES arm)
    elseif(_arch MATCHES "arm64|aarch64")
      list(APPEND LeapC++_ARCHITECTURES aarch64)
    else()
      message(WARNING "Unrecognized architecture ${i}")
    endif()
  endforeach()
else()
  # Try to infer what the user wants
  if(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64" OR CMAKE_SYSTEM_PROCESSOR STREQUAL "arm64")
    set(LeapC++_ARCHITECTURES aarch64)
  elseif(CMAKE_SYSTEM_NAME MATCHES "Android")
    set(LeapC++_ARCHITECTURES "${CMAKE_ANDROID_ARCH_ABI}") #prevent mixing armeabi & armeabi-v7a
  elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^arm")
    set(LeapC++_ARCHITECTURES arm)
  elseif(CMAKE_SIZEOF_VOID_P EQUAL "8")
    set(LeapC++_ARCHITECTURES x64)
  else()
    set(LeapC++_ARCHITECTURES x86)
  endif()
endif()

if(LeapC++_DEBUG)
  message(STATUS "LeapC++_ARCHITECTURE: ${LeapC++_ARCHITECTURE}")
  message(STATUS "LeapC++_ARCHITECTURES: ${LeapC++_ARCHITECTURES}")
endif()

# Architectures we were built with
set(LeapC++_BUILD_ARCHITECTURES x64)
if(LeapC++_DEBUG)
  message(STATUS "LeapC++_BUILD_ARCHITECTURES: ${LeapC++_BUILD_ARCHITECTURES}")
endif()

# Verify that we match all of the architectures requested by the customer
foreach(i IN LISTS LeapC++_ARCHITECTURES)
  list(FIND LeapC++_BUILD_ARCHITECTURES ${i} found)
  if(found EQUAL -1)
    set(PACKAGE_VERSION_COMPATIBLE FALSE)
    set(PACKAGE_VERSION_UNSUITABLE TRUE)
    if(LeapC++_DEBUG)
      message(STATUS "Requested architecture of ${LeapC++_ARCHITECTURE} not compatible with x64")
    endif()
    return()
  endif()
endforeach()

# Determine whether the user's request (either implied or explicit) for libstdc++ can
# be met by this verison of LeapC++
if(CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang")
  if(LeapC++_DEBUG)
    message(STATUS "Installed LeapC++_USE_LIBCXX: ")
    message(STATUS "Configured LeapC++_USE_LIBCXX: ${LeapC++_USE_LIBCXX}")
  endif()
endif()

if(NOT  STREQUAL "") # handle prerelease versions
  set(PACKAGE_FIND_VERSION_PRERELEASE "${LeapC++_FIND_VERSION_PRERELEASE}")
  if(NOT PACKAGE_FIND_VERSION_PRERELEASE)
    set(PACKAGE_VERSION_COMPATIBLE FALSE)
    message(AUTHOR_WARNING "To use this prerelease version of LeapC++, set LeapC++_FIND_VERSION_PRERELEASE to ''.")
  endif()

  if(NOT "${PACKAGE_FIND_VERSION}-${PACKAGE_FIND_VERSION_PRERELEASE}" STREQUAL "${PACKAGE_VERSION}")
    set(PACKAGE_VERSION_COMPATIBLE FALSE)
  else()
    set(PACKAGE_VERSION_EXACT TRUE)
  endif()
elseif(PACKAGE_VERSION VERSION_LESS PACKAGE_FIND_VERSION)
  if(LeapC++_DEBUG)
    message(STATUS "Our version is less than the requested one, trivially incompatible")
  endif()
  set(PACKAGE_VERSION_COMPATIBLE FALSE)
elseif(NOT PACKAGE_FIND_VERSION_MINOR EQUAL "1")
  if(LeapC++_DEBUG)
    message(STATUS "Minor version mismatch, requested minor is ${PACKAGE_FIND_VERSION_MINOR}, this version is ${PACKAGE_VERSION_MINOR}")
  endif()
  set(PACKAGE_VERSION_COMPATIBLE FALSE)
elseif(NOT PACKAGE_FIND_VERSION_MAJOR EQUAL "0")
  if(LeapC++_DEBUG)
    message(STATUS "Major version mismatch, failure.")
  endif()
  set(PACKAGE_VERSION_COMPATIBLE FALSE)
else()
  set(PACKAGE_VERSION_COMPATIBLE TRUE)
  if (PACKAGE_VERSION VERSION_EQUAL PACKAGE_FIND_VERSION)
    set(PACKAGE_VERSION_EXACT TRUE)
  endif()

  if(LeapC++_DEBUG)
    message(STATUS "Using LeapC++ in ${CMAKE_CURRENT_SOURCE_DIR}")
  endif()
  set(LeapC++_VERSION_PRERELEASE "")
endif()
