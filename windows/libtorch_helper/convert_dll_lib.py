import os
import sys
import glob
import filecmp

"""
완전히 똑같으면 외부 dll임

1. 구성이 다른 dll의 집합을 가져온다.
2. 의존성을 파악한다.( 1번에 포함되는 dll 중에서)
3. 의존성 트리를 구성한다.

4. 이름을 변경한다.
"""


def intersection(path1, path2):
    """
    find intersection of two path list by base filename
    """
    dirs = list(map(lambda x: os.path.split(x)[0], [path1[0], path2[0]]))
    path2base = list(map(os.path.basename, path2))
    ret = [tuple(map(os.path.join, dirs, [os.path.basename(value)] * 2))
           for value in path1 if os.path.basename(value) in path2base]
    return ret


def replace_dll(filename, alphabet):
    """
    replace first underscore with R(release) or D(debug)
    change last character to R or D if string doesn't have underscore
    """
    dirname, filename = os.path.split(filename)
    if filename.find('_') != -1:
        filename = filename.replace('_', alphabet, 1)
    else:
        name, ext = filename.split('.')
        filename = name[:-1] + alphabet + "." + ext
    return os.path.join(dirname, filename)


def fild_dll_dependencies(dll_list):
    ret = [[] for _ in dll_list]
    for i, e in enumerate(dll_list):
        with open(e[0], "rb") as f:
            buf = f.read()
            for d in dll_list:
                if d == e:
                    continue
                file = os.path.basename(d[0])
                if buf.find(str.encode(file)) != -1:
                    ret[i].append(file)
    return ret


def main():
    r_dll = glob.glob("lib-release/*.dll")
    d_dll = glob.glob("lib-debug/*.dll")
    dlls = intersection(d_dll, r_dll)
    dlls = list(filter(lambda x: not filecmp.cmp(*x), dlls))

    dlls_dependencies = fild_dll_dependencies(dlls)

    for i, e in enumerate(dlls):
        alphabet = ['D', 'R']
        for j in range(2):
            with open(e[j], "rb+") as f:
                buf = f.read()
                for dpd in dlls_dependencies[i]:
                    buf = buf.replace(str.encode(dpd), str.encode(replace_dll(dpd, alphabet[j])))
                f.seek(0)
                f.write(buf)
            os.rename(e[j], replace_dll(e[j], alphabet[j]))
            libname = os.path.splitext(e[j])[0] + ".lib"
            if os.path.exists(libname):
                with open(libname, "rb+") as f:
                    buf = f.read()
                    pos = buf.find(str.encode('Microsoft (R) LINK'))
                    name = os.path.basename(e[j])
                    newbuf = buf[:pos] + buf[pos:].replace(str.encode(name), str.encode(replace_dll(name, alphabet[j])), 1)
                    f.seek(0)
                    f.write(newbuf)
                os.rename(libname, replace_dll(libname, alphabet[j]))


if __name__ == "__main__":
    main()
