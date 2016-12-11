# YCM extra conf intended to be used globally. FlagsForFile will attempt to figure out flags in
# three different ways in the following order:
#
#     * from a clang compilation database found in ['build/compile_commands.json',
#       '_build/compile_commands.json'] somewhere along the parent path of the file being edited
#     * from a .clang_complete file found somewhere along the path of the file being edited
#     * if none of the above succeeded then return a set of fall-back flags defined bellow
#
# Note that while compilation flags for a specific file are cached inside ycmd, this script will
# attempt to read the compilation database and .clang_complete file every time a new file is opened.
# This is a trade-off between speed and usability. If this is too slow for you then consider writing
# a project specific .ycm_extra_conf.py for your project.
#
# TODO: standard c++ includes
#
import os
import ycm_core


PATH_FLAGS = ['-isystem', '-I', '-iquote', '--sysroot=']
BUILD_DIRECTORIES = ['build', '_build']
SOURCE_EXTENSIONS = ['.cpp', '.cxx', '.cc', '.c', '.m', '.mm', '.C']
HEADER_EXTENSIONS = ['.h', '.hxx', '.hpp', '.hh']
FALLBACK_FLAGS = [
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
    '-I/usr/include/'
]


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
        return None
    return compilation_database.GetCompilationInfoForFile(filename)


def FlagsFromCompilationDatabase(root, filename):
    try:
        compilation_db_path = FindFileUpwards('compile_commands.json', root, BUILD_DIRECTORIES)
        compilation_db_dir = os.path.dirname(compilation_db_path)
        compilation_db = ycm_core.CompilationDatabase(compilation_db_dir)

        compilation_info = GetCompilationInfoForFile(compilation_db, filename)
        if not compilation_info:
            return None

        return MakeRelativePathsInFlagsAbsolute(
            compilation_info.compiler_flags_,
            compilation_info.compiler_working_dir_)
    except:
        return None


def FlagsFromClangCompleteFile(root):
    try:
        clang_complete_file = FindFileUpwards('.clang_complete', root)

        with open(clang_complete_file, 'r') as fd:
            flags = fd.read().splitlines()

        return MakeRelativePathsInFlagsAbsolute(flags, os.path.dirname(clang_complete_file))
    except:
        return None


def FlagsForFile(filename, **kwargs):
    real_path = os.path.realpath(filename)

    # Try to lookup flags in the compilation database
    flags = FlagsFromCompilationDatabase(real_path, filename)

    # Try to lookup flags in .clang_complete file
    if not flags:
        flags = FlagsFromClangCompleteFile(real_path)

    # if all else fail, use fall-back flags
    if not flags:
        flags = FALLBACK_FLAGS

    return {'flags': flags, 'do_cache': True}
