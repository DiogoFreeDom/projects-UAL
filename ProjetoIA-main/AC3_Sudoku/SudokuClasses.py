
class Csp:

    quadro = []

    restrictions = []

    def __init__ (self, quadro, defaultDomain: list):       #quadro é uma matriz que é a entrada do programa, default domain é o domínio base para cada variável
        defaultDomain = set(defaultDomain)
        for linha in range(len(quadro)):
            aux = []
            for celula in range(len(quadro[linha])):
                valorAtualMatriz = quadro[linha][celula]
                posicao = str(linha) + str(celula)

                if valorAtualMatriz in defaultDomain:
                    aux.append(CspVariable(valorAtualMatriz, posicao))
                else:
                    aux.append(CspVariable(defaultDomain, posicao))
            self.quadro.append(aux)

class CspVariable:

    position = ""
    absoluteValue = None
    domain = []
    restrictions = []

    def __init__ (self, domain, position):
        if isinstance(domain, int):
            self.absoluteValue = domain
            self.domain = [domain]
        else:
            self.domain = list(domain)
        self.position = position
        self.restrictions = self.criarRestricoes()
    
    def removeDomainValue(self, index):
        self.domain.pop(index)
    
    def setValue(self, value):
        self.absoluteValue = value

    def removeRestriction(self, index):
        self.restrictions.pop(index)

    def setPosition(self, pos):
        self.position = pos

    def criarRestricoes(self):
        restricoesLC = set()
        for linhaOuColuna in range(0, 9):
            if not self.position[1] == str(linhaOuColuna):
                restricoesLC.add((self.position, self.position[0] + str(linhaOuColuna)))
            if not self.position[0] == str(linhaOuColuna):
                restricoesLC.add((self.position, str(linhaOuColuna) + self.position[1]))

        restricoesQ = set()
        switchCase = {0: [0, 0], 1: [0, 3], 2: [0, 6], 3: [3, 0], 4: [3, 3], 5: [3, 6], 6: [6, 0], 7: [6, 3], 8: [6, 6]}
        posicaoQuadrado = switchCase.get(int(int(self.position[1]) / 3) + int(int(self.position[0]) / 3) * 3)
        for linha in range(3):
            for coluna in range(3):
                restricao = str(posicaoQuadrado[0] + linha) + str(posicaoQuadrado[1] + coluna)
                if not restricao == self.position:
                    restricoesQ.add((self.position, restricao))

        return restricoesQ.union(restricoesLC)