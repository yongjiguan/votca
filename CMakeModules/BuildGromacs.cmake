include(ExternalProject)
include(GNUInstallDirs)
# ftp://ftp.gromacs.org/pub/gromacs/gromacs-XXX.tar.gz is too unstable for CI, so use Gentoo Mirror
ExternalProject_Add(Gromacs_build
  URL http://distfiles.gentoo.org/distfiles/gromacs-2018.4.tar.gz
  URL_MD5 7bede4c1a656531fc43b95805e9a5a94
  PREFIX gromacs INSTALL_DIR gromacs/install
  CMAKE_ARGS 
    -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
    -DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}
    -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
    -DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}
    -DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS}
    -DGMX_MPI:BOOL=OFF
    -DGMX_THREAD_MPI:BOOL=ON 
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
)
ExternalProject_get_property(Gromacs_build INSTALL_DIR)
set(GROMACS_LIBRARY "${INSTALL_DIR}/${CMAKE_INSTALL_LIBDIR}/libgromacs.so" CACHE STRING "gromacs library")
set(GROMACS_INCLUDE_DIR "${INSTALL_DIR}/${CMAKE_INSTALL_INCLUDEDIR}" CACHE PATH "gromacs inclde dir")
set(GROMACS_VERSION 20180004)
set(FOUND_GROMACS_VERSION_CXX TRUE)
set(FOUND_GMX_IS_SINGLE_PRECISION TRUE)
set(GROMACS_PATH "${INSTALL_DIR}/${CMAKE_INSTALL_BINDIR}")

install(DIRECTORY ${INSTALL_DIR}/ DESTINATION ${CMAKE_INSTALL_PREFIX} USE_SOURCE_PERMISSIONS) 
