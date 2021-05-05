# =============================================================================
# >> REQUIREMENTS & PROJECT
# =============================================================================
CMake_Minimum_Required(VERSION 2.8)
Project(Tests)

SET(ASMJIT_STATIC 1)

# =============================================================================
# >> MACROS
# =============================================================================
# Create a new macro to easily add test executables
macro (create_dynamic_hooks_test name)

    add_executable(${ARGV})
    if (TARGET ${name})
        If(WIN32)
            #Target_Link_Libraries(${name} "../vs2010-x86/$(Configuration)/DynamicHooks")
            #Target_Link_Libraries(${name} ../../src/thirdparty/AsmJit/lib/AsmJit)
            target_link_libraries(${name} DynamicHooks asmjit)

            target_include_directories(
  "${name}" PUBLIC
  ../../asmjit/src/asmjit
  ../src
  )
        Endif()
    endif()
endmacro()


#add_subdirectory(../../asmjit build)

# =============================================================================
# >> LINK LIBRARIES
# =============================================================================

# =============================================================================
# >> COMPILER FLAGS
# =============================================================================
# Disable optimization in release mode
If(WIN32)
    Set(CMAKE_CXX_FLAGS_RELEASE "/Od /Ob0")
Endif()

Set(CMAKE_CXX_FLAGS "-m32")


# =============================================================================
# >> INCLUDES
# =============================================================================
#
#


add_subdirectory(../src dynanmichooks_build)
add_subdirectory(../../asmjit asmjit_build)

# =============================================================================
# >> TESTS
# =============================================================================
If(WIN32)
    create_dynamic_hooks_test(test_ms_cdecl1 ms_cdecl1.cpp)
    create_dynamic_hooks_test(test_ms_cdecl2 ms_cdecl2.cpp)
    create_dynamic_hooks_test(test_ms_thiscall1 ms_thiscall1.cpp)
    create_dynamic_hooks_test(test_ms_thiscall2 ms_thiscall2.cpp)
    create_dynamic_hooks_test(test_ms_stdcall1 ms_stdcall1.cpp)
    create_dynamic_hooks_test(test_ms_stdcall2 ms_stdcall2.cpp)
    create_dynamic_hooks_test(test_ms_fastcall1 ms_fastcall1.cpp)
    create_dynamic_hooks_test(test_ms_fastcall2 ms_fastcall2.cpp)
Else()
    create_dynamic_hooks_test(test_gcc_cdecl1 gcc_cdecl1.cpp)
    create_dynamic_hooks_test(test_gcc_cdecl2 gcc_cdecl2.cpp)
    create_dynamic_hooks_test(test_gcc_thiscall1 gcc_thiscall1.cpp)
    create_dynamic_hooks_test(test_gcc_thiscall2 gcc_thiscall2.cpp)
  Endif()

  target_link_libraries(DynamicHooks)
