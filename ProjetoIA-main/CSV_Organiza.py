import pandas
import random


def cortaFicheiro():
    mails = pandas.read_csv('spam.csv', encoding='latin-1') # abre o ficheiro
    mails = mails.sample(frac=1, random_state=random.randint(1, 100))  # Ordena os mails aleatoriamente

    # Corta 70/30
    mails_Treino = mails[:int(len(mails) * 0.70)].reset_index(drop=True)
    mails_Restantes = mails[int(len(mails) * 0.70):].reset_index(drop=True)

    # Corta 15/15
    mails_Restantes = mails_Restantes.sample(frac=1, random_state=random.randint(1, 100))  # Ordena os mails restantes aleatoriamente
    mails_Teste = mails_Restantes[:int(len(mails_Restantes) * 0.50)].reset_index(drop=True)
    mails_Verifica = mails_Restantes[int(len(mails_Restantes) * 0.50):].reset_index(drop=True)

    # Guarda os Mails em ficheiros csv separados
    mails_Treino.to_csv(r'MailsDe_Treino.csv', index=False, header=True)
    mails_Teste.to_csv(r'MailsDe_Teste.csv', index=False, header=True)
    mails_Verifica.to_csv(r'MailsDe_Valida.csv', index=False, header=True)
