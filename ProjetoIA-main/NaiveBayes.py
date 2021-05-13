import math
import time

import numpy
import pandas
import CSV_Organiza

CSV_Organiza.cortaFicheiro()


def train(nomeFicheiro):
    num_mails = 0
    num_mails_spam = 0
    num_mails_ham = 0
    mails = []
    ficheiroMails = pandas.read_csv(nomeFicheiro, encoding='latin-1') # Carrega o ficheiro em alvo
    ficheiroMails.drop(['Unnamed: 2', 'Unnamed: 3', 'Unnamed: 4'], axis=1, inplace=True) # remove as 3 tabelas vazias que existem no ficheiro no final

    for row in ficheiroMails.values:
        if row[0] == "ham":
            num_mails_ham += 1
        else:
            num_mails_spam += 1
        current_dict = dict()
        for word in row[1].replace('\W', " ").lower().split():

            if word not in saco_palavras:
                saco_palavras.append(word)
            if word not in current_dict:
                current_dict[word] = 1
            else:
                current_dict[word] += 1
        mails.append([row[0], current_dict])
        num_mails += 1

    global p
    p = [[1] * 2 for i in range(len(saco_palavras))]
    spam_words = len(saco_palavras)
    ham_words = spam_words

    for mail in mails:
        if mail[0] == "spam":
            for word in mail[1]:
                p[saco_palavras.index(word)][0] += mail[1].get(word)
                spam_words += mail[1].get(word)
        else:
            for word in mail[1]:
                p[saco_palavras.index(word)][1] += mail[1].get(word)
                ham_words += mail[1].get(word)

    for j in p:
        j[0] /= spam_words
        j[1] /= ham_words

    print("percentagem treino ham: " + str(num_mails_ham / num_mails * 100))
    print("percentagem treino spam: " + str(num_mails_spam / num_mails * 100))

    return [num_mails_ham, num_mails_spam]


def classify(documento, c, num_mails_ham, num_mails_spam):
    b = math.log(c, 10) + math.log(num_mails_ham, 10) - math.log(num_mails_spam, 10)
    t = -b
    classify_dict = dict()
    for word in documento.replace('\W', " ").lower().split():
        if not classify_dict.get(word):
            classify_dict.update({word: 1})
        else:
            classify_dict[word] += 1

    for j in range(len(p)):
        if saco_palavras[j] in classify_dict.keys():
            t += classify_dict.get(saco_palavras[j]) * (math.log(p[j][0], 10) - math.log(p[j][1], 10))

    return "spam" if t > 0 else "ham"


saco_palavras = []
global p

# Treino =====================================
tempo_i = time.time()
valores_de_treino = train("MailsDe_Treino.csv")
tempo_f = time.time() - tempo_i
print("Duração do treino: " + str(tempo_f) + "s")

# Validação ===================================
certos = 0
resultadosValida = {}
ficheiroMails = pandas.read_csv("MailsDe_Valida.csv", encoding='latin-1') # Carrega o ficheiro em alvo
ficheiroMails.drop(['Unnamed: 2', 'Unnamed: 3', 'Unnamed: 4'], axis=1, inplace=True) # remove as 3 tabelas vazias que existem no ficheiro no final
validacao_ham = 0
validacao_spam = 0
for v_c in numpy.arange(0.1, 1.5, 0.1):
    for linha in ficheiroMails.values: # Por cada linha de mail testa o grupo de validação para contar quantas tem certa
        if classify(linha[1], v_c, valores_de_treino[0], valores_de_treino[1]) == linha[0]:
            certos += 1
        if v_c == 1:
            if linha[0] == "spam":
                validacao_spam += 1
            else:
                validacao_ham += 1
    resultadosValida[v_c] = certos/len(ficheiroMails) * 100
    certos = 0 # Renicia a var
print("percentagem validação spam: " + str(validacao_spam/len(ficheiroMails)*100))
print("percentagem validação ham: " + str(validacao_ham/len(ficheiroMails)*100))
c = max(resultadosValida, key=resultadosValida.get) # Obtem o melhor valor para c
print("C escolhido: " + str(c))

# Teste =================================
ficheiroMails = pandas.read_csv("MailsDe_Teste.csv", encoding='latin-1') # Carrega o ficheiro em alvo
ficheiroMails.drop(['Unnamed: 2', 'Unnamed: 3', 'Unnamed: 4'], axis=1, inplace=True) # remove as 3 tabelas vazias que existem no ficheiro no final
certos = 0
validacao_ham = 0
validacao_spam = 0

tempo_i = time.time()
for row in ficheiroMails.values:
    if classify(row[1], c, valores_de_treino[0], valores_de_treino[1]) == row[0]:
        certos += 1

    if row[0] == "spam":
        validacao_spam += 1
    else:
        validacao_ham += 1
tempo_f = time.time() - tempo_i

print(certos/len(ficheiroMails) * 100)
print("percentagem teste spam: " + str(validacao_spam/len(ficheiroMails)*100))
print("percentagem teste ham: " + str(validacao_ham/len(ficheiroMails)*100))
print("Tempo Total de classficação do grupo de teste: " + str(tempo_f) + "s - Média de " + str(tempo_f/len(ficheiroMails)) + "s por cada mail")


