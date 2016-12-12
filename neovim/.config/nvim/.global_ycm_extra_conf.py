# YCM extra conf intended to be used globally. FlagsForFile will attempt to figure out flags in
# two different ways in the following order:
#
#     * from a clang compilation database found in ['compile_commands.json', 'build/compile_commands.json',
#       '_build/compile_commands.json'] somewhere along the parent path of the file being edited
#     * from a .clang_complete file found somewhere along the path of the file being edited
#
# If both method fail then we assume we start with an empty list of flags. In the end, regardless of
# success or failure of the above methods, we'll append our base flags.
#
# Note that while compilation flags for a specific file are cached inside ycmd, this script will
# attempt to read the compilation database and .clang_complete file every time a new file is opened.
# This is a trade-off between speed and usability. If this is too slow for you then you should write
# a project specific .ycm_extra_conf.py for your project or, if you have the time submit a pull
# request that implements some form of caching that avoids rereads. :)
import os
import re
import subprocess
import ycm_core


# We won't get suggestions for standard C++ includes unless we explicitly add them to our list of
# flags.
RE_CLANG_CAPTURE_INCLUDES = \
    re.compile(r'.*?^#include <\.\.\.> search starts here:\s(?P<paths>.*\s)End of search list.$',
               re.MULTILINE | re.DOTALL)


def GetStandardIncludes():
    call_result = subprocess.run(['clang', '-v', '-E', '-x', 'c++', '-'],
                                 stdin=subprocess.DEVNULL,
                                 stdout=subprocess.DEVNULL,
                                 stderr=subprocess.PIPE)
    if call_result.returncode == 0:
        match = RE_CLANG_CAPTURE_INCLUDES.match(call_result.stderr.decode())
        if match:
            raw_paths = match.group('paths').split()
            return [''.join(['-isystem', os.path.realpath(path)]) for path in raw_paths]
    return []


# Tweakable values
PATH_FLAGS = ['-isystem', '-I', '-iquote', '--sysroot=']
BUILD_DIRECTORIES = ['build', '_build']
SOURCE_EXTENSIONS = ['.cpp', '.cxx', '.cc', '.c', '.m', '.mm', '.C']
HEADER_EXTENSIONS = ['.h', '.hxx', '.hpp', '.hh']
BASE_FLAGS = [
    '-Wall',
    '-Wextra',
    '-Werror',
    '-Wno-long-long',
    '-Wno-variadic-macros',
    '-fexceptions',
    '-ferror-limit=10000',
    '-DNDEBUG',
    '-std=c++14',
    '-xc++',
] + GetStandardIncludes()


def IsHeaderFile(filename):
    extension = os.path.splitext(filename)[1]
    return extension in HEADER_EXTENSIONS


def MakeRelativePathsInFlagsAbsolute(flags, working_directory):
    new_flags = []
    make_next_absolute = False
    for flag in flags:
        if make_next_absolute and not os.path.isabs(flag):
            new_flags.append(os.path.join(working_directory, flag))
            make_next_absolute = False
            continue

        make_next_absolute = flag in PATH_FLAGS
        if make_next_absolute:
            new_flags.append(flag)
            continue

        for path_flag in PATH_FLAGS:
            if flag.startswith(path_flag):
                path = flag[len(path_flag):].strip()
                if not os.path.isabs(path):
                    new_flags.append(''.join([path_flag, os.path.join(working_directory, path)]))
                break
        new_flags.append(flag)
    return new_flags


def FindFileUpwards(file_name, start_path, additional_folders=[]):
    candidates = [file_name] + [os.path.join(folder, file_name) for folder in additional_folders]

    current_root = os.path.realpath(start_path)
    while current_root != '/':
        candidate_paths = [os.path.join(current_root, candidate) for candidate in candidates]
        for candidate_path in candidate_paths:
            if os.path.exists(candidate_path):
                return candidate_path
        current_root = os.path.dirname(current_root)
    return None


def GetCompilationInfoForFile(compilation_database, filename):
    if IsHeaderFile(filename):
        basename = os.path.splitext(filename)[0]
        for extension in SOURCE_EXTENSIONS:
            replacement_file = basename + extension
            if os.path.exists(replacement_file):
                compilation_info = compilation_database.GetCompilationInfoForFile(replacement_file)
                if compilation_info.compiler_flags_:
                    return compilation_info
        return []
    return compilation_database.GetCompilationInfoForFile(filename)


def FlagsFromCompilationDatabase(root, filename):
    try:
        compilation_db_path = FindFileUpwards('compile_commands.json', root, BUILD_DIRECTORIES)
        compilation_db_dir = os.path.dirname(compilation_db_path)
        compilation_db = ycm_core.CompilationDatabase(compilation_db_dir)

        compilation_info = GetCompilationInfoForFile(compilation_db, filename)
        if not compilation_info:
            return []

        return MakeRelativePathsInFlagsAbsolute(
            compilation_info.compiler_flags_,
            compilation_info.compiler_working_dir_)
    except:
        return []


def FlagsFromClangCompleteFile(root):
    try:
        clang_complete_file = FindFileUpwards('.clang_complete', root)

        with open(clang_complete_file, 'r') as fd:
            flags = fd.read().splitlines()

        return MakeRelativePathsInFlagsAbsolute(flags, os.path.dirname(clang_complete_file))
    except:
        return []


def FlagsForFile(filename, **kwargs):
    root_path = os.path.dirname(os.path.realpath(filename))

    # Try to lookup flags in the compilation database
    flags = FlagsFromCompilationDatabase(root_path, filename)

    # Try to lookup flags in .clang_complete file
    if not flags:
        flags = FlagsFromClangCompleteFile(root_path)

    # Finally, also add our base flags
    flags.extend(BASE_FLAGS)

    return {'flags': flags, 'do_cache': True}
