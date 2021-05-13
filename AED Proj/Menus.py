    

    #==============================#
    #  GESTÃO DE FROTA - ESTAFETA  #
    #------------------------------#
    #Bruno Silva - 30003696        #
    #Diogo Mendes - 30003865       #
    #------------------------------#


import Classes #Chama classes
from pathlib import Path
import pickle

def itens_iniciais():
    
    '''
     2 Encomendas de mota 2 E de Automóvel e 1 de camião
     2 Motas, 2 Camiões, 2 Automoveis 
     2 Condutores de motas e 2 de camiões
    '''
    #Cria objetos para as listas e filas
    obj_mota = Classes.Mota("47-25-78", 80000)
    Listas.ListaMota.append(obj_mota)
    FMota.enqueue(obj_mota)
    
    obj_mota = Classes.Mota("T7-FE-7R", 80000)
    Listas.ListaMota.append(obj_mota)
    FMota.enqueue(obj_mota)
    
    obj_camiao = Classes.Camião("XZ-R5-B1", 2000000)
    Listas.ListaCamião.append(obj_camiao)
    FCamião.enqueue(obj_camiao) 
    
    obj_camiao = Classes.Camião("3T-BN-X6", 2000000)
    Listas.ListaCamião.append(obj_camiao)
    FCamião.enqueue(obj_camiao)    
    
    obj_automovel = Classes.Camião("K3-XD-L0", 1200000)
    Listas.ListaAutomóvel.append(obj_automovel)
    FAutomóvel.enqueue(obj_automovel) 
            
    obj_automovel = Classes.Camião("M3-AA-3N", 1200000)
    Listas.ListaAutomóvel.append(obj_automovel)
    FAutomóvel.enqueue(obj_automovel)       
    
    obj_entrega = Classes.Entrega("AX47WF4AW","Lisboa","Porto","Conjuntos pizzas congeladas",4000)
    Listas.ListaEntrega.append(obj_entrega)
    FEntregaMota.enqueue(obj_entrega) 
    
    obj_entrega = Classes.Entrega("AMDIWN33JF93N","Lisboa","Viseu","Roupas",8000)
    Listas.ListaEntrega.append(obj_entrega)
    FEntregaMota.enqueue(obj_entrega) 
    
    obj_entrega = Classes.Entrega("FAEA23F3F3F","Porto","Viseu","Ouro",100000)
    Listas.ListaEntrega.append(obj_entrega)
    FEntregaAutomóvel.enqueue(obj_entrega)
    
    obj_entrega = Classes.Entrega("DESFSE84877","Madrid","Lisboa","Prata",110000)
    Listas.ListaEntrega.append(obj_entrega)
    FEntregaAutomóvel.enqueue(obj_entrega)
    
    obj_entrega = Classes.Entrega("AJFU3N3NR3B","Lisboa","Berlin","Alimentos",180000)
    Listas.ListaEntrega.append(obj_entrega)
    FEntregaCamião.enqueue(obj_entrega)
    
    obj_condutor = Classes.Condutor("24976597","Bruno","971447958","bruno@mail.com")
    Listas.ListaCondutor.append(obj_condutor)
    FCondMota.enqueue(obj_condutor) 

    obj_condutor = Classes.Condutor("97488418","Diogo","924846497","diogo@mail.com")
    Listas.ListaCondutor.append(obj_condutor)
    FCondMota.enqueue(obj_condutor) 
    
    obj_condutor = Classes.Condutor("1234233","Dr. House","988178187","house@mail.com")
    Listas.ListaCondutor.append(obj_condutor)
    FCondCamião.enqueue(obj_condutor) 

    obj_condutor = Classes.Condutor("97488418","Batman","924846497","anoite@mail.com")
    Listas.ListaCondutor.append(obj_condutor)
    FCondCamião.enqueue(obj_condutor)
    
    obj_cliente = Classes.Cliente("128","Rafael","Rua que existe n5 3esq","922347420","raf@gmail.com")
    Listas.ListaCliente.append(obj_cliente)
    cliTree.Inserir(obj_cliente)
    
    obj_cliente = Classes.Cliente("325","Sara","Rua bonita n1 2esq","935556042","sar4@sapo.com")
    Listas.ListaCliente.append(obj_cliente)
    cliTree.Inserir(obj_cliente)
    
    obj_cliente = Classes.Cliente("158","Maria","Rua grande n1 1dir","935557152","ma84ia@gmail.com")
    Listas.ListaCliente.append(obj_cliente)
    cliTree.Inserir(obj_cliente)

def separador(): #Utilzado para separar visualmente menus
    print(25*"=")
    
def menu_inicial(): #Menu inicial
    #Recolhe input e retira espaços brancos se tiver no caso
    escolha = input("[1] - Veículos\n[2] - Entregas\n[3] - Condutores\n[4] - Clientes\n[5] - Enviar\n[6] - Filas\n[7] - Sair\n> ").strip() 
    if escolha == "1":
        veiculos()
    elif escolha == "2":
        entregas()
    elif escolha == "3":
        condutores()
    elif escolha == "4":
        clientes()
    elif escolha == "5":
        enviar()
    elif escolha == "6":
        filas()
    elif escolha == "7":
        print("Programa Terminado")
    else: menu_inicial()
        
def veiculos():
     separador()
     print("<> Veículos")
     escolha = input("[1] - Adicionar\n[2] - Modificar\n[3] - Ver\n[4] - Voltar\n> ").strip() #Recolhe input e retira espaços brancos se tiver no caso
     if escolha == "1":
        adiciona_veiculo()
     elif escolha == "2":
        modifica_veiculo()
     elif escolha == "3":
        ver_veiculo()
     elif escolha == "4":
        menu_inicial()
     else: veiculos()

def entregas():
     separador()
     print("<> Entregas")
     escolha = input("[1] - Adicionar\n[2] - Modificar\n[3] - Ver\n[4] - Ver Entregas.txt\n[5] - Voltar\n> ").strip() #Recolhe input e retira espaços brancos se tiver no caso
     if escolha == "1":
        adiciona_entregas()
     elif escolha == "2":
        modifica_entrega()
     elif escolha == "3":
        ver_objetos(2)
     elif escolha == "4":
        f = open("Entregas.txt","r")
        print(f.read())
        f.close()
        entregas()
     elif escolha == "5":
        menu_inicial()
     else: entregas()

def condutores():
     separador()
     print("<> Condutores")
     escolha = input("[1] - Adicionar\n[2] - Modificar\n[3] - Ver\n[4] - Voltar\n> ").strip() #Recolhe input e retira espaços brancos se tiver no caso
     if escolha == "1":
        adiciona_condutor()
     elif escolha == "2":
        modifica_condutores()
     elif escolha == "3":
        ver_objetos(0)
     elif escolha == "4":
        menu_inicial()
     else: condutores()

def clientes():
     separador()
     print("<> Clientes")
     escolha = input("[1] - Adicionar\n[2] - Modificar\n[3] - Ver\n[4] - Ver Árvore\n[5] - Procurar\n[6] - Voltar\n> ").strip() #Recolhe input e retira espaços brancos se tiver no caso
     if escolha == "1":
        adiciona_clientes()
     elif escolha == "2":
        modifica_clientes()
     elif escolha == "3":
        ver_objetos(1)
     elif escolha == "4":
        arvore_ordem()
     elif escolha == "5":
        arvore_procura()
     elif escolha == "6":
        menu_inicial()
     else: clientes()

def arvore_ordem():
    print(" - ".join(cliTree.Ordena()))
    clientes()
    
def arvore_procura():
    nome = input("Nome para pesquisar: ").strip()
    if cliTree.Procura(nome):
        print(nome + " - Existe")
    else:
        print(nome + " - Não existe")
    clientes()
    
def ver_veiculo():
    print("<> Ver veiculos")
    escolha = input("[1] - Motas\n[2] - Camiões\n[3] - Automóveis\n[4] - Voltar\n> ").strip() #Recolhe input e retira espaços brancos se tiverem em no caso
    
    if escolha == "1": 
        print("<> Ver Motas")
        for i in range(len(Listas.ListaMota)):
            print(Listas.ListaMota[i])
        ver_veiculo()
    elif escolha == "2": 
        print("<> Ver Camiões")
        for i in range(len(Listas.ListaCamião)):
            print(Listas.ListaCamião[i])
        ver_veiculo()
    elif escolha == "3": 
        print("<> Ver Automóveis")
        for i in range(len(Listas.ListaAutomóvel)):
            print(Listas.ListaAutomóvel[i])
        ver_veiculo()
    elif escolha == "4": veiculos()
    else: ver_veiculo()
    
def adiciona_veiculo():
    try: #Impede erros de partir o programa caso haja inputs não esperados, caso haja repete a função novamente 
        separador()
        print("<> Adicionar Veículo")
        tipo = input("[1] - Mota\n[2] - Camião\n[3] - Automóvel\n[4] - Voltar\n> ").strip()

        
        if tipo == "4": veiculos()
        matri = input("Matricula: ").strip().upper() #Input de uma matricula que é colocada em maiúsculas 
        #Cria o objeto do veiculo a depender do tipo
        if tipo == "2":
            obj_camiao = Classes.Camião(matri, 2000000)
            Listas.ListaCamião.append(obj_camiao)
            FCamião.enqueue(obj_camiao)
        elif tipo == "1":
            obj_mota = Classes.Mota(matri, 80000)
            Listas.ListaMota.append(obj_mota)
            FMota.enqueue(obj_mota)
        elif tipo == "3": 
            obj_auto = Classes.Automovel(matri, 1200000)
            Listas.ListaAutomóvel.append(obj_auto)
            FMota.enqueue(obj_auto)
        else:
            print("<!> Erro ao adicionar um veículo")
            adiciona_veiculo()
        guardar_binario()
        print("Veiculo com matricula {" + matri + "} adicionado")
        veiculos()
    except:
        print("<!> Erro ao adicionar um veiculo")
        adiciona_veiculo()
        
def adiciona_condutor():
    try: #Impede erros de partir o programa caso haja inputs não esperados, caso haja repete a função novamente 
        separador()
        print("<> Adicionar condutor\n(Número,Nome,Telefone,Email)")
        condutor = input("(Utilize, para separar cada atributo) >").split(",")  
        condutor_obj = Classes.Condutor(*condutor)
        print("Tipo de condutor:\n[1] Motas\n[2] Camião\n[3] Automóvel\n")
        tipo = input("> ").strip()
        if tipo == 1:
            FCondMota.enqueue(condutor_obj)
        elif tipo == 2:
            FCondCamião.enqueue(condutor_obj)
        elif tipo == 3:
            FCondAutomóvel.enqueue(condutor_obj)
        Listas.ListaCondutor.append(condutor_obj) 
        guardar_binario()
        print("Condutor Adicionado")
        condutores()  
    except:
         print("<!> Erro ao adicionar um condutor")
         adiciona_condutor()
    
def adiciona_clientes():
    try: #Impede erros de partir o programa caso haja inputs não esperados, caso haja repete a função novamente 
        separador()
        print("<> Adicionar cliente\n(Número,Nome,Morada,Telefone,Email)")
        cliente = input("(Utilize, para separar cada atributo) >").split(",")  
        cliente_obj = Classes.Cliente(*cliente)
        Listas.ListaCliente.append(cliente_obj)
        guardar_binario()
        print("Adicionado Cliente " + cliente[0])
        cliTree.Inserir(cliente_obj)
        clientes()
    except:
         print("<!> Erro ao adicionar um cliente")
         adiciona_clientes()
    
def adiciona_entregas():
    try: #Impede erros de partir o programa caso haja inputs não esperados, caso haja repete a função novamente 
        separador()
        print("<> Adicionar entregas\n(Identificador, Ponto recolha, Ponto entrega, Mercadoria descrição, Mercadoria volume)")
        entrega = input("(Utilize, para separar cada atributo) \n> ").split(",")
        entrega_obj = Classes.Entrega(*entrega)
            
        volume_entrega = int(entrega[4]) #Ao depender do input da entrega o volume vai escolher em qual veiculo a entrega vai ser entregue, colocando na fila do objeto veiculo respetivo 
        if  volume_entrega < 0:
                 print("<!> Erro ao adicionar uma entrega\nEncomenda não pode ser negativa")
                 adiciona_entregas()
        if volume_entrega <= 80000:
                FEntregaMota.enqueue(entrega_obj)
        if volume_entrega > 1200000:
                FEntregaCamião.enqueue(entrega_obj)
        if volume_entrega > 80000 and volume_entrega <= 1200000:
                FEntregaAutomóvel.enqueue(entrega_obj)
        
        Listas.ListaEntrega.append(entrega_obj)
        guardar_binario()
        guarda_txt()
        print("Adicionado uma entrega")
        entregas()
    except:
         print("<!> Erro ao adicionar uma entrega")
         adiciona_entregas()

def ver_objetos(tipo):
    comandos = ["ListaCondutor","ListaCliente","ListaEntrega"] #lista que junta as listas respetivas que guardam os objetos que vão ser mostrados
    separador()
    if tipo == 2: print("> Histórico de Entregas\n")
    if tipo == 1: print("> Histórico de Clientes\n")
    if tipo == 0: print("> Histórico de Condutores\n")
    for i in range(eval("len(Listas."+comandos[tipo]+")")): #Eval interpreta um string para python, executando um comando, neste caso obtem um comprimento de uma lista
            print(eval("Listas."+comandos[tipo]+"["+str(i)+"]"))
            print("-----------")
    menu_inicial()
    
def modifica_clientes():
    try: #Impede erros de partir o programa caso haja inputs não esperados, caso haja repete a função novamente 
        separador()
        print("<> Modificar Clientes\nModifique um cliente ao escolher o seu indicador\n[X] Voltar")
        #Mostra clientes e o seu index na lista para o utilizador poder escolher 
        for i in range(len(Listas.ListaCliente)):
            print("["+str(i)+"] "+str(Listas.ListaCliente[i]))
        tipo = input("> ").strip()
        if (tipo.upper() == "X"): 
            veiculos()
        else:
            novo = input("(Utilize, para separar cada atributo) \n(Número,Nome,Morada,Telefone,Email)\n> ").split(",") #Recebe input e separa o input pela virgula para uma lista
            index_objeto = int(tipo)
            Classes.Cliente.modifica_Cliente(Listas.ListaCliente[index_objeto],*novo) #usando (*) é possivel distribuir uma lista por atributos de um objeto ou função de uma só vez  
            print("Cliente modificado")
            guardar_binario()
            clientes()
    except:
        print("<!> Erro ao modificar clientes")
        modifica_condutores()
    
def modifica_condutores():
    try: #Impede erros de partir o programa caso haja inputs não esperados, caso haja repete a função novamente 
        separador()
        print("<> Modificar Condutores\nModifique um condutor ao escolher o seu indicador\n[X] Voltar")
        #Mostra condutores e o seu index na lista para o utilizador poder escolher 
        for i in range(len(Listas.ListaCondutor)):
            print("["+str(i)+"] "+str(Listas.ListaCondutor[i]))
        tipo = input("> ").strip()
        if (tipo.upper() == "X"): 
            condutores()
        else:
            novo = input("(Utilize, para separar cada atributo) \n(Número, Nome, Telefone, Email)\n> ").split(",")
            index_objeto = int(tipo)
            Classes.Condutor.modifica_Condutor(Listas.ListaCondutor[index_objeto],*novo) #usando (*) é possivel distribuir uma lista por atributos de um objeto ou função de uma só vez  
            print("Condutor modificado")
            guardar_binario()
            condutores()
    except:
        print("<!> Erro ao modificar condutores")
        modifica_condutores()
    
def modifica_veiculo():
    try: #Impede erros de partir o programa caso haja inputs não esperados, caso haja repete a função novamente 
        separador()
        print("<> Modificar Veiculo\nModifique um veiculo ao escolher o seu indicador\n[X] Voltar")
         #Mostra veiculos e o seu index na lista para o utilizador poder escolher e coloca letra inicial para diferenciar de cada tipo de objeto
        print("\n<> Camiões")
        for i in range(len(Listas.ListaCamião)):
                print("[C"+str(i)+"] "+str(Listas.ListaCamião[i]))
        print("\n<> Motas")
        for i in range(len(Listas.ListaMota)):
                print("[M"+str(i)+"] "+str(Listas.ListaMota[i]))
        print("\n<> Automóveis")
        for i in range(len(Listas.ListaAutomóvel)):
                print("[A"+str(i)+"] "+str(Listas.ListaAutomóvel[i]))
                
        tipo = input("> ").strip().upper()
        if (tipo[0] == "C"):
            novo = input("(Utilize, para separar cada atributo) (Matricula, Capacidade)\n>").split(",")
            index_objeto = int(tipo[1:]) #Retira letra e deixa o index no objeto da lista
            matri_antiga = Listas.ListaCamião[index_objeto].matri
            Classes.Camião.modifica_Viatura(Listas.ListaCamião[index_objeto],*novo)
            print("Veículo modificado")
            guardar_binario()
            modifica_veiculo()
        elif (tipo[0] == "M"):
            novo = input("(Utilize, para separar cada atributo) (Matricula, Capacidade)\n>").split(",") 
            index_objeto = eval(tipo[1:]) #Retira letra e deixa o index no objeto da lista
            matri_antiga = Listas.ListaMota[index_objeto].matri
            Classes.Mota.modifica_Viatura(Listas.ListaMota[index_objeto],*novo)
            print("Veículo modificado")
            guardar_binario()
            modifica_veiculo()
        elif (tipo[0] == "A"):
            novo = input("(Utilize, para separar cada atributo) (Matricula, Capacidade)\n>").split(",") 
            index_objeto = int(tipo[1:]) #Retira letra e deixa o index no objeto da lista
            matri_antiga = Listas.ListaAutomóvel[index_objeto].matri
            Classes.Automovel.modifica_Viatura(Listas.ListaAutomóvel[index_objeto],*novo)
            print("Veículo modificado")
            guardar_binario()
            modifica_veiculo()
        elif (tipo == "X"): veiculos()
        else:
            separador()
            print("<!> Erro ao modificar um veiculo")
            modifica_veiculo()   
    except:
         print("<!> Erro ao modificar veiculo")   
         modifica_veiculo()

    
def modifica_entrega():
    try: #Impede erros de partir o programa caso haja inputs não esperados, caso haja repete a função novamente 
        separador()
        print("<> Modificar Entregas\nModifique uma entrega ao escolher o seu indicador\n[X] Voltar")
        for i in range(len(Listas.ListaEntrega)):
            print("["+str(i)+"] "+str(Listas.ListaEntrega[i]))
        tipo = input("> ").strip()
        if (tipo.upper() == "X"): 
            entregas()
        else:
            novo = input("(Identificador, Ponto Recolha, Ponto Entrega, Mercadoria descrição, Mercadoria volume)\n> ").split(",") #Recebe input e separa por virgula e poem numa lista
            index_objeto = int(tipo)
            Classes.Entrega.modifica_Entrega(Listas.ListaEntrega[index_objeto],*novo)
            print("Entrega modificada")
            guardar_binario()
            guarda_txt()
            entregas()
    except:
         print("<!> Erro ao modificar entrega")
         modifica_entrega()

def enviar():
    separador()
    print("<> Entregas em motas\n")
    while not FEntregaMota.isEmpty(): #Enquanto existir encomendas repete estas ações debaixo
        if not (FCondMota.isEmpty() or FMota.isEmpty()): #Vê se as filas de condutores e veiculos não estão vazias, se não tiverem prepara a entrega para o veiculo 
            OFEntregaMota = FEntregaMota.dequeue()
            OFMota = FMota.dequeue()
            OFCondMota = FCondMota.dequeue()
            OFMota.capa = int(OFMota.capa) - int(OFEntregaMota.mercadoria_v) #Coloca a entrega
            print("Entrega: "+ str(OFEntregaMota.identificador) + "\nCarregada para a mota: "+ str(OFMota.matri)) #Informa o utilizador que o veiculo saiu
            print("Mota "+str(OFMota.matri)+" saiu com o condutor: " + str(OFCondMota.nome)) #informa o utilizador qual é o condutor que saiu com o veiculo
            print("----")
        else:
            print("<!> Não há mais condutores ou motas para poder fazer entregas")
            break
    if FEntregaMota.isEmpty(): print("Não há mais entregas para as motas")
    print("\n------\n<> Entregas em camiões\n")  
    while not FEntregaCamião.isEmpty():
        if not (FCondCamião.isEmpty() or FCamião.isEmpty()):
            OFEntregaCamião = FEntregaCamião.dequeue()
            OFCamião = FCamião.dequeue()
            OFCondCamião = FCondCamião.dequeue()
            OFCamião.capa = int(OFCamião.capa) - int(OFEntregaCamião.mercadoria_v) #Coloca a entrega
            print("Entrega: "+ str(OFEntregaCamião.identificador) + "\nCarregada para a mota: "+ str(OFCamião.matri)) #Informa o utilizador que o veiculo saiu
            print("Mota "+str(OFCamião.matri)+" saiu com o condutor: " + str(OFCondCamião.nome)) #informa o utilizador qual é o condutor que saiu com o veiculo
            print("----")
        else:
            print("<!> Não há mais condutores ou camiões para poder fazer entregas")
            break
    if FEntregaCamião.isEmpty(): print("Não há mais entregas para os camiões")
    print("\n------\n<> Entregas em automóveis\n")        
    while not FEntregaAutomóvel.isEmpty():
        if not (FCondAutomóvel.isEmpty() or FAutomóvel.isEmpty()):
            OFEntregaAutomóvel = FEntregaAutomóvel.dequeue()
            OFAutomóvel = FAutomóvel.dequeue()
            OFCondAutomóvel = FCondAutomóvel.dequeue()
            OFAutomóvel.capa = int(OFAutomóvel.capa) - int(OFEntregaAutomóvel.mercadoria_v) #Coloca a entrega
            print("Entrega: "+ str(OFEntregaAutomóvel.identificador) + "\nCarregada para a automóvel: "+ str(OFAutomóvel.matri))
            print("Automóvel "+str(OFAutomóvel.matri)+" saiu com o condutor: " + str(OFCondAutomóvel.nome))
            print("----")
        else:
            print("<!> Não há mais condutores ou automóveis para poder fazer entregas")
            break
    if FEntregaCamião.isEmpty(): print("Não há mais entregas para os automóveis")
    
    menu_inicial()        
        
def filas():
    print("<> Filas <>\n")
    #Listas de titulos e de lista de filas dos objetos
    titulos = ["<> Entregas de Mota","<> Condutores de Motas", "<> Motas","<> Entregas de Camião","<> Condutores de Camião","<> Camiões","<> Entregas de Automóvel","<> Condutores de Automóveis","<> Automóveis"]
    comandos = ["FEntregaMota","FCondMota","FMota","FEntregaCamião","FCondCamião","FCamião","FEntregaAutomóvel","FCondAutomóvel","FAutomóvel"]
    #Mostra todas filas
    for c in range(0,len(comandos)):
        print(titulos[c])
        for i in range(eval(comandos[c]+".size()")-1,-1,-1): #eval Interpreta comando para python obtendo o tamanho da lista e começar no inicio da fila
            print(str(abs(i-2))+"º " + str(eval(comandos[c]+".items[i]"))) #Mosta posição na fila e objeto
        print("-----") #Separador entre filas
    menu_inicial()


def guardar_binario():
    pickle.dump(Listas, open("EstafetaListas.bin", 'wb'))
    
def abrir_binario():
    ficheiro = Path("EstafetaListas.bin")
    if ficheiro.is_file():
        return pickle.load(open("EstafetaListas.bin", 'rb'))
    else:
        return False    
    
def guarda_txt():
    txt_ficheiro = open("Entregas.txt","w") 
    txt_ficheiro.writelines("<> Entregas de Camião:\n")
    for i in FEntregaCamião.items: txt_ficheiro.writelines(str(i)+"\n-------\n")
    txt_ficheiro.writelines("\n<> Entregas de Automóvel:\n")
    for i in FEntregaAutomóvel.items: txt_ficheiro.writelines(str(i)+"\n-------\n")
    txt_ficheiro.writelines("\n<> Entregas de Mota:\n") 
    for i in FEntregaMota.items: txt_ficheiro.writelines(str(i)+"\n-------\n")
    txt_ficheiro.close()
    
if __name__ == "__main__": #Main do programa
    
    if not abrir_binario(): #Se não existe não pode apresentar escolha
        Listas = Classes.Programa()       
        FCamião = Classes.Queue()
        FAutomóvel = Classes.Queue()
        FMota = Classes.Queue()  
        FCondCamião = Classes.Queue()
        FCondAutomóvel = Classes.Queue()
        FCondMota = Classes.Queue()
        FEntregaCamião = Classes.Queue()
        FEntregaAutomóvel = Classes.Queue()
        FEntregaMota = Classes.Queue()
        cliTree = Classes.Tree()
        itens_iniciais() # Carrega objetos iniciais
        guarda_txt()
        guardar_binario()
    else:
        opcao = input("Deseja abrir Listas.bin ou iniciar default\n[1] - EstafetaListas.bin\n[2] - Default\n> ")
        if opcao == "1":
            Listas = abrir_binario()
            cliTree = Classes.Tree()
            for i in Listas.ListaCliente:
                cliTree.Inserir(i)
        else:
            Listas = Classes.Programa()       
            FCamião = Classes.Queue()
            FAutomóvel = Classes.Queue()
            FMota = Classes.Queue()  
            FCondCamião = Classes.Queue()
            FCondAutomóvel = Classes.Queue()
            FCondMota = Classes.Queue()
            FEntregaCamião = Classes.Queue()
            FEntregaAutomóvel = Classes.Queue()
            FEntregaMota = Classes.Queue()
            cliTree = Classes.Tree()
            itens_iniciais() # Carrega objetos iniciais
            guarda_txt()
            guardar_binario()
    
    
    
    print("+=====================================+")
    print("|     GESTÃO DE FROTA  - ESTAFETA     |")
    print("+=====================================+")
    menu_inicial() #Mostra primeio menu
    