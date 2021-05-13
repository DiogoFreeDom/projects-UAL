import numpy
import pandas
import time


def Perceptron(modo, data, label, epocasN): # Algortmo do Perceptron com base no Pseudocódigo
    ritmo = 0 # Se o Ritmo for 0 o algoritmo não treina, apenas classifica
    if modo == "treino":  ritmo = 0.01
    resultado = numpy.zeros(data.shape[0])
    for n in range(epocasN): # Número de vezes de classificação
        for contador, (msg, tipo_Msg) in enumerate(zip(data, label)): # (tipo_Msg refere -1 é não spam e 1 é spam)
            # Pesquisa onde durante a multiplcação da vetor msg e scalar é superior a 0, se for verdade é atribuindo 1 como spam se for falso é -1 como não spam
            Resultado_Previsao = numpy.where(numpy.dot(msg, scalar[1:]) + scalar[0] >= 0.0, 1, -1)
            vetorTeta = ritmo * (tipo_Msg - Resultado_Previsao)
            if vetorTeta != 0:
                scalar[1:] += vetorTeta * msg
                scalar[0] += vetorTeta
            resultado[contador] = Resultado_Previsao
    return resultado


# Preparação dos Emails
print("# A Preparar Mails")
mails = pandas.read_csv('spam.csv', encoding='latin-1')
mails.drop(['Unnamed: 2', 'Unnamed: 3', 'Unnamed: 4'], axis=1, inplace=True)
mails = mails.rename(columns={'v1': 'TIPO', 'v2': 'TEXTO'})  # Modifica os nomes das colunas
mails['TEXTO'] = mails['TEXTO'].str.replace('\W', ' ').str.lower()  # Remove pontuação nos mails
mails = mails[["TEXTO", 'TIPO']]  # reorganiza tabela
mails = mails.replace({'TIPO': {"spam": 0, "ham": 1}})  # coloca valorer tabela para indiciar se é spam em vez de string

mails = mails.sample(frac=1, random_state=1) # Ordena os mails aleatoriamente
mails_Treino = mails[:int(len(mails) * 0.70)].reset_index(drop=True) # retira 70%
mails_Restantes = mails[int(len(mails) * 0.70):].reset_index(drop=True) # Retira 30%

mails_Teste = mails_Restantes[int(len(mails_Restantes) * 0.50):].reset_index(drop=True) # Retira 15 dos 30%
mails_Valida = mails_Restantes[int(len(mails_Restantes) * 0.50):].reset_index(drop=True) # Retira 15 dos 30%


# Saco de palavras, contem todas as palavras utilizadas nos mails
print("# A Preparar Bag of Words")
saco_de_palavras = {}
for i in range(mails_Treino.shape[0]):
    for palavra in mails_Treino.iloc[i, 0].split(): # Obtem mensagem e corta palavra em palavra
        if palavra not in saco_de_palavras: # para não repetir a palavra caso esteja no saco
            saco_de_palavras[palavra] = len(saco_de_palavras) # coloca como valor na chave da palavra a sua posição

# TREINO ===================================================================
time_s = time.time()
# Mails processados para treinar
print("# A Preparar Grupo de Treino")
dadosMails = numpy.zeros((mails_Treino.shape[0], len(saco_de_palavras))) # Cria a array em zeros do tamanho msg x saco

# Dados dos mails para verificação
labelMails = numpy.zeros(mails_Treino.shape[0])
for i in range(mails_Treino.shape[0]):
    for palavra in mails_Treino.iloc[i, 0].split(): # Verifica cada palavra no texto do mail
        if palavra in saco_de_palavras:  # verifica se essa palavra está presente no bag of words
            dadosMails[i, saco_de_palavras[palavra]] += 1 # Aumenta o seu valor na posição correspondente
            if mails_Treino.iloc[i, 1] == 1: labelMails[i] = 1  # Spam
            else: labelMails[i] = -1  # Não é spam

# Treina
scalar = numpy.zeros(1 + dadosMails.shape[1])
Perceptron("treino", dadosMails, labelMails, 50)
time_e = time.time() - time_s
print("Treino demorou: " + str(time_e) + "s")

# VALIDAÇÃO ==========================================
print("# A Preparar Grupo de Validação")
# Mails processados para testar
dadosMails = numpy.zeros((mails_Valida.shape[0], len(saco_de_palavras)))

# Dados dos mails para verificação
labelMails = numpy.zeros(mails_Valida.shape[0])
for i in range(mails_Valida.shape[0]):
    for palavra in mails_Valida.iloc[i, 0].split(): # Verifica cada palavra no texto do mail
        if palavra in saco_de_palavras: # verifica se essa palavra está presente no bag of words
            dadosMails[i, saco_de_palavras[palavra]] += 1 # Aumenta o seu valor na posição correspondente
            if mails_Valida.iloc[i, 1] == 1: labelMails[i] = 1  # Spam
            else: labelMails[i] = -1  # Não é spam

epocas = 1
resultadosValida = {}
for i in range(20): # experencia de 20 vezes, aumenta o valor de epocas e obtem a precisão de classificação
    resultados = Perceptron("", dadosMails, labelMails, epocas)
    resultadosValida[epocas] = sum(resultados == labelMails)/dadosMails.shape[0]*100
    epocas += 1
epocas = max(resultadosValida, key=resultadosValida.get) # Obtem o melhoor valor para epocas baseado na sua classificação
print("# Número de Épocas escolhido: " + str(epocas))

# CLASSIFICAÇÃO DE EMAILS - TESTES ==========================================
print("# A Preparar Grupo de Classificação")
# Mails processados para testar
dadosMails = numpy.zeros((mails_Teste.shape[0], len(saco_de_palavras)))

# Dados dos mails para verificação
labelMails = numpy.zeros(mails_Teste.shape[0])
for i in range(mails_Teste.shape[0]):
    for palavra in mails_Teste.iloc[i, 0].split(): # Verifica cada palavra no texto do mail
        if palavra in saco_de_palavras: # verifica se essa palavra está presente no bag of words
            dadosMails[i, saco_de_palavras[palavra]] += 1 # Aumenta o seu valor na posição correspondente
            if mails_Teste.iloc[i, 1] == 1: labelMails[i] = 1  # Spam
            else: labelMails[i] = -1  # Não é spam

# Classifica os mails
print("# A Iniciar classificação do grupo de testes")
tempo_i = time.time()
resultados = Perceptron("", dadosMails, labelMails, epocas)
tempo_f = time.time() - tempo_i
print("<> Precisão - " + str((sum(resultados == labelMails) / dadosMails.shape[0] * 100)))
print("<> Tempo Total de classficação do grupo de teste: " + str(tempo_f) + "s - Média de " + str(tempo_f/dadosMails.shape[0]) + "s por cada mail")
print("<> Nº Spam detetados - " + str(sum(resultados == 1)))
print("<> Nº Ham detetados - " + str(sum(resultados == -1)))

print("\nValores Reais:") # Obtem quantos mails há de cada tipo no conjunto de testes na relidade
print("Quantidade SPAM: " + str(len(mails_Teste[mails_Teste['TIPO'] == 1])))
print("Quantidade HAM: " + str(len(mails_Teste[mails_Teste['TIPO'] == 0])))
