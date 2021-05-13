# -*- coding: utf-8 -*-
class Viatura:
   def __init__(self, matricula, capacidade):
       self.matri = matricula
       self.capa = capacidade
       
   def __str__(self):
       return "Matricula: " + self.matri + " | Capacidade livre: " + str(self.capa)
   
   def modifica_Viatura(self, matricula, capacidade):
       self.matri = matricula
       self.capa = capacidade
       
class Camião(Viatura):
    def __init__(self,matricula, capacidade):
        super().__init__(matricula,capacidade)

        
class Automovel(Viatura):
    def __init__(self,matricula, capacidade):
        super().__init__(matricula,capacidade)

        
class Mota(Viatura):
    def __init__(self,matricula, capacidade):
        super().__init__(matricula,capacidade)


class Condutor:
    def __init__(self,numero,nome,telefone,email):
        self.numero = numero
        self.nome = nome
        self.telefone = telefone
        self.email = email
        
    def modifica_Condutor(self,numero,nome,telefone,email):
        self.numero = numero
        self.nome = nome
        self.telefone = telefone
        self.email = email
        
    def __str__(self):
        return "Número: " + self.numero + "\nNome: " + self.nome + "\nTelefone: " + self.telefone + "\nEmail: " + self.email
        
class Cliente:
    def __init__(self,numero,nome,morada,telefone,email):
        self.numero = numero
        self.nome = nome
        self.telefone = telefone
        self.email = email
        self.morada = morada
        
    def modifica_Cliente(self,numero,nome,morada,telefone,email):
        self.numero = numero
        self.nome = nome
        self.telefone = telefone
        self.email = email
        self.morada = morada
        
    def __str__(self):
        return "Número: " + self.numero + "\nNome: " + self.nome + "\nTelefone: " + self.telefone + "\nEmail: " + self.telefone + "\nMorada: " + self.morada 

class Entrega:
    def __init__(self,Identificador, Ponto_Recolha, Ponto_Entrega, Mercadoria_descrição, Mercadoria_volume):
        self.identificador = Identificador
        self.ponto_recolha = Ponto_Recolha
        self.ponto_entrega = Ponto_Entrega
        self.mercadoria_desc = Mercadoria_descrição
        self.mercadoria_v = Mercadoria_volume
        
    def modifica_Entrega(self, Identificador, Ponto_Recolha, Ponto_Entrega, Mercadoria_descrição, Mercadoria_volume):
        self.identificador = Identificador
        self.ponto_recolha = Ponto_Recolha
        self.ponto_entrega = Ponto_Entrega
        self.mercadoria_desc = Mercadoria_descrição
        self.mercadoria_v = Mercadoria_volume
        
    def __str__(self):
        return "Identificador: " + str(self.identificador) + "\nPonto de recolha: " + self.ponto_recolha +  "\nPonto de entrega: " + self.ponto_entrega + "\nDescrição da mercadoria: " + self.mercadoria_desc + "\nVolume da mercadoria: " + str(self.mercadoria_v)

class Programa: 
    def __init__(self):
        self.ListaCamião = []
        self.ListaAutomóvel = []
        self.ListaMota = []
        self.ListaCondutor = []
        self.ListaCliente = []
        self.ListaEntrega = []    
        
class Queue:
    def __init__(self):
        self.items = []

    def isEmpty(self):
        return self.items == []

    def enqueue(self, item):
        self.items.insert(0,item)

    def dequeue(self):
        return self.items.pop()
    
    def size(self):
        return len(self.items)

class Node:
    def __init__(self, val):
        self.value = val
        self.leftChild = None
        self.rightChild = None
        
    def Inserir(self, data):
        if self.value == data: #Impede duplicados caso haja
            return False
        elif self.value > data:
            if  self.leftChild:
                    return self.leftChild.Inserir(data)
            else:
                self.leftChild = Node(data)
                return True
        else:
            if self.rightChild:
                return self.rightChild.Inserir(data)
            else:
                self.rightChild = Node(data)
                return True
    
    def Procura(self, data):
        if (self.value == data):
            return True
        elif self.value > data:
            if self.leftChild:
                return self.leftChild.Procura(data)
        else:
            if self.rightChild:
                return self.rightChild.Procura(data)
            else:
                return False
        
    def Ordena(self):
       x = []
       y = []
       if self:
           if self.leftChild:
               x = self.leftChild.Ordena()
           if self.rightChild:
               y = self.rightChild.Ordena()
           return x + [self.value] + y
       else:
            return []

class Tree:
        def __init__(self):
            self.root = None
            
        def Procura(self, data):
            if self.root:
                return self.root.Procura(data)
            else:
                return False

        def Inserir(self, data):
            if self.root:
                return self.root.Inserir(data.nome)
            else:
                self.root = Node(data.nome)
                return True
        
        def Ordena(self):
            return self.root.Ordena()
