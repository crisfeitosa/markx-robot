*** Settings ***
Documentation    Suite de testes E2E para a Tela Principal de Oferta - Jornada Consignado Varejo

# Importa a Page, que já traz tudo (BDD + Componentes) encapsulado
Resource         ../../resources/pages/oferta/consignado/consignadoVarejo.resource

Force Tags       jornada:consignado_varejo    experiencia:consignado-iu    e2e

*** Test Cases ***
# ==========================================
# CASOS DE TESTE
# ==========================================

CT01 - Validar Abertura e Fechamento do Modal de Beneficios
    [Documentation]    Garante que o modal de informações gerais (More Info) abre e fecha corretamente.
    [Tags]             modal    more_info
    Dado que estou na tela principal da oferta de Consignado Varejo
    Quando clico no icone de informacoes da conta
    Então o modal de informacoes gerais deve ser exibido
    # Ação direta do componente para fechar e limpar a tela ao final do teste
    Clicar Em Entendi No Varejo More Info

CT02 - Validar Redirecionamento para Edicao de Endereco
    [Documentation]    Garante que o usuario consegue acessar a tela de alterar o endereco.
    [Tags]             endereco
    Dado que estou na tela principal da oferta de Consignado Varejo
    Quando clico no link para editar o endereço
    Então a tela de edição de endereço deve ser exibida

CT03 - Validar Aceite da Oferta (Caminho Feliz)
    [Documentation]    Garante o prosseguimento da jornada ao aceitar simular o consignado.
    [Tags]             aceite    caminho_feliz
    Dado que estou na tela principal da oferta de Consignado Varejo
    Quando clico no botão para simular o consignado
    Então a jornada deve seguir para a simulação de crédito

CT04 - Validar Recusa da Oferta
    [Documentation]    Garante o acionamento correto do fluxo de recusa da oferta.
    [Tags]             recusa
    Dado que estou na tela principal da oferta de Consignado Varejo
    Quando clico em "Não quero conta e Consignado"
    Então o fluxo de recusa deve ser acionado
