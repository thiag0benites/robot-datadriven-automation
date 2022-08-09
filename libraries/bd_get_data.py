##################################################################################################################################
# Autor: Thiago Benites
# Decrição: Métodos para iteração com massa de dados
##################################################################################################################################
from ast import If

def cria_dicionario_componentes(cols):
    components = {}
    i = 0
    x = 0

    # Total colunas
    total = int(len(cols))

    # Localiza ultima coluna fixa (obrigatória)
    for i in range(i, total):
        if cols[i][0] == 'CASO_TESTE':
            i+= 1
            break

    # Cria lista de componentes
    for i in range(i, total):
        pos = cols[i][0].find('_')
        component = cols[i][0][0:pos]
        components[x] = component
        x+=1

    i = 0
    x = 0
    total = int(len(components))
    new_list = []

    # Tira duplicidades
    for i in range(i, total):
        if components[i] not in new_list:
            new_list.append(components[i])
            # print(components[i])

    return new_list

def cria_dicionario_de_dados(colunas, valores):
    dados = {}
    i = 0

    for valor in valores[0]:
        dados[colunas[i][0]] = valor
        i += 1

    return dados

def cria_dicionario_de_dados_robot(cols, values):
    data = ''
    i = 0

    for value in values[0]:
        value = str(value)
        if data=='':
            data = cols[i][0] + '=' + value
        else:
            data = data + '  ' + cols[i][0] + '=' + value

        i += 1

    return data