import time

from AC3_Sudoku.SudokuClasses import *

quadrosudoku = [
    [0, 0, 3, 0, 2, 0, 6, 0, 0],
    [9, 0, 0, 3, 0, 5, 0, 0, 1],
    [0, 0, 1, 8, 0, 6, 4, 0, 0],
    [0, 0, 8, 1, 0, 2, 9, 0, 0],
    [7, 0, 0, 0, 0, 0, 0, 0, 8],
    [0, 0, 6, 7, 0, 8, 2, 0, 0],
    [0, 0, 2, 6, 0, 9, 5, 0, 0],
    [8, 0, 0, 2, 0, 3, 0, 0, 9],
    [0, 0, 5, 0, 1, 0, 3, 0, 0]
]

sudoku = [
    [5, 3, 0, 0, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9]
]


def ac3(csp):
    queue = []
    for line in csp.quadro:
        for variable in line:
            for restriction in variable.restrictions:
                queue.append(restriction)

    while queue:
        (curVarString, compVarString) = queue.pop(0)
        (curVar, compVar) = (csp.quadro[int(curVarString[0])][int(curVarString[1])],
                             csp.quadro[int(compVarString[0])][int(compVarString[1])])
        if revise(curVar, compVar):
            if not curVar.domain:
                return False
            if len(curVar.domain) == 1:
                curVar.setValue(curVar.domain[0])
            for i in curVar.restrictions:
                if not i[1] == compVarString:
                    queue.append((i[1], i[0]))
    return True


def revise(curVar, compVar):
    revised = False
    currentValue = 0
    while currentValue < len(curVar.domain):
        found = False
        for counter in range(len(compVar.domain)):
            if curVar.domain[currentValue] != compVar.domain[counter]:
                found = True
                break
        if not found:
            curVar.removeDomainValue(currentValue)
            currentValue -= 1
            revised = True
        currentValue += 1
    return revised


def mostraQuadro(q):
    for y in range(len(q)):
        if y % 3 == 0 and not y == 0: print(" ")
        for conta, x in enumerate(q[y]):
            if conta % 3 == 0 and not conta == 0: print(" ", end="")
            if x.absoluteValue is None:
                print("_" + " ", end="")
            else:
                print(str(x.absoluteValue) + " ", end="")
        print("")
    print("")


if __name__ == '__main__':
    defaultDomain = [1, 2, 3, 4, 5, 6, 7, 8, 9]

    tempo_i = time.time()
    sudo = Csp(quadrosudoku, defaultDomain)
    tempo_f = time.time() - tempo_i
    print("Tempo de execução das satisfações de restrições: " + str(tempo_f) + "s")
    print("Estado inicial do sudoku: \n")
    mostraQuadro(sudo.quadro)

    tempo_i = time.time()
    ac3(sudo)
    tempo_f = time.time() - tempo_i
    print("Tempo de execução do AC-3: " + str(tempo_f) + "s")
    print("Estado final do sudoku: \n")
    mostraQuadro(sudo.quadro)



