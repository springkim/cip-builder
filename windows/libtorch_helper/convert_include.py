import fileinput
import os

path = 'include'
def GetFileList(dirName):
    listOfFile = os.listdir(dirName)
    allFiles = list()
    for entry in listOfFile:
        fullPath = os.path.join(dirName, entry)
        if os.path.isdir(fullPath):
            allFiles = allFiles + GetFileList(fullPath)
        else:
            allFiles.append(fullPath)
    return allFiles

files=GetFileList(path)

for file in files:
    file=file.replace('\\','/')
    print(file)
    with open(file,encoding='ansi',errors='ignore') as f:
        newText=f.read()
        newText=newText.replace('::std::', 'std::')
        newText=newText.replace('std::', '::std::')
        newText=newText.replace('torch/csrc/api/include/', '')
    with open(file, "w",encoding='ansi') as f:
        f.write(newText)