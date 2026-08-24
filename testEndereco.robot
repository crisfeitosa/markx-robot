*** Settings ***
Documentation    Testes E2E da Jornada de Consignado - Experiência: Consignado Varejo (Pendências Cadastrais - Endereço)
Library          AppiumLibrary

# Aplica as tags de negócio a TODOS os testes deste arquivo
Force Tags       jornada:consignado    experiencia:consignado-varejo    endereco

*** Variables ***
# ==========================================
# LOCATORS (Webview)
# ==========================================

# --- Botão de Entrada ---
${BTN_EDITAR_ENDERECO}          accessibility_id=botao_editar_endereco

# --- Modal: Preencha ou atualize seus dados ---
${MODAL_ATUALIZA_DADOS}         accessibility_id=modal_atualiza_dados
${INPUT_CEP}                    accessibility_id=input_cep
${CHECKBOX_NAO_SEI_CEP}         accessibility_id=checkbox_nao_sei_cep
${TXT_ENDERECO_PREENCHIDO}      accessibility_id=texto_endereco_preenchido  
${INPUT_RUA}                    accessibility_id=input_rua
${INPUT_NUMERO}                 accessibility_id=input_numero
${CHECKBOX_SEM_NUMERO}          accessibility_id=checkbox_sem_numero
${INPUT_COMPLEMENTO}            accessibility_id=input_complemento
${INPUT_BAIRRO}                 accessibility_id=input_bairro
${SELECT_ESTADO}                accessibility_id=select_estado
${INPUT_CIDADE}                 accessibility_id=input_cidade
${BTN_CONTINUAR}                accessibility_id=botao_continuar

# --- Tela: Revisão ---
${TELA_REVISAO}                 accessibility_id=tela_revisao_informacoes
${TXT_ENDERECO_REVISAO}         accessibility_id=texto_endereco_revisao


*** Keywords ***
# ==========================================
# KEYWORDS DE AÇÃO E VALIDAÇÃO (BDD)
# ==========================================

Dado que o usuário está na tela de atualização de endereço
    Wait Until Element Is Visible    ${BTN_EDITAR_ENDERECO}      timeout=10s
    Click Element                    ${BTN_EDITAR_ENDERECO}
    Wait Until Element Is Visible    ${MODAL_ATUALIZA_DADOS}     timeout=5s

Quando preenche um CEP válido
    [Arguments]    ${cep}
    Wait Until Element Is Visible    ${INPUT_CEP}                timeout=5s
    Input Text                       ${INPUT_CEP}                ${cep}

E aguarda o autopreenchimento do logradouro
    [Arguments]    ${logradouro_esperado}
    Wait Until Element Is Visible    ${TXT_ENDERECO_PREENCHIDO}  timeout=10s
    Element Should Contain Text      ${TXT_ENDERECO_PREENCHIDO}  ${logradouro_esperado}

E informa que o endereço não possui número
    Click Element                    ${CHECKBOX_SEM_NUMERO}

E informa o número e complemento
    [Arguments]    ${numero}    ${complemento}
    Input Text                       ${INPUT_NUMERO}             ${numero}
    Input Text                       ${INPUT_COMPLEMENTO}        ${complemento}

E clica em Continuar
    Wait Until Element Is Enabled    ${BTN_CONTINUAR}            timeout=5s
    Click Element                    ${BTN_CONTINUAR}

Então a tela de revisão deve exibir o endereço completo
    [Arguments]    ${endereco_revisao_esperado}
    Wait Until Element Is Visible    ${TELA_REVISAO}             timeout=10s
    Wait Until Element Is Visible    ${TXT_ENDERECO_REVISAO}     timeout=5s
    Element Should Contain Text      ${TXT_ENDERECO_REVISAO}     ${endereco_revisao_esperado}

Então o botão Continuar deve permanecer desabilitado
    Element Should Be Disabled       ${BTN_CONTINUAR}

Quando o usuário seleciona "Não sei o meu CEP"
    Click Element                    ${CHECKBOX_NAO_SEI_CEP}

Então os campos de endereço manual devem ser exibidos
    Wait Until Element Is Visible    ${INPUT_RUA}                timeout=5s
    Wait Until Element Is Visible    ${INPUT_BAIRRO}             timeout=5s
    Wait Until Element Is Visible    ${SELECT_ESTADO}            timeout=5s


*** Test Cases ***
# ==========================================
# CASOS DE TESTE
# ==========================================

CT01 - Atualizar Endereço com CEP valido e sem numero
    [Documentation]    Valida o fluxo completo utilizando a API de CEP e a flag "sem número".
    [Tags]             e2e    cep    happy_path
    Dado que o usuário está na tela de atualização de endereço
    Quando preenche um CEP válido    01310-100
    E aguarda o autopreenchimento do logradouro    Avenida Paulista
    E informa que o endereço não possui número
    E clica em Continuar
    Então a tela de revisão deve exibir o endereço completo    Avenida Paulista, S/N - Bela Vista

CT02 - Atualizar Endereço com CEP valido, numero e complemento
    [Documentation]    Valida o fluxo completo utilizando a API de CEP preenchendo número e complemento manualmente.
    [Tags]             e2e    cep    happy_path
    Dado que o usuário está na tela de atualização de endereço
    Quando preenche um CEP válido    01310-100
    E aguarda o autopreenchimento do logradouro    Avenida Paulista
    E informa o número e complemento    1578    Apto 204
    E clica em Continuar
    Então a tela de revisão deve exibir o endereço completo    Avenida Paulista, 1578 - Apto 204 - Bela Vista

CT03 - Validar Bloqueio do Botao Continuar sem preencher Numero
    [Documentation]    Garante que o formulário não pode ser submetido faltando o campo obrigatório "Número".
    [Tags]             validacao_front    bloqueio
    Dado que o usuário está na tela de atualização de endereço
    Quando preenche um CEP válido    01310-100
    E aguarda o autopreenchimento do logradouro    Avenida Paulista
    Então o botão Continuar deve permanecer desabilitado

CT04 - Validar fluxo de "Não sei o meu CEP"
    [Documentation]    Garante que ao marcar que não sabe o CEP, os campos manuais (Rua, Bairro, Estado, Cidade) ficam disponíveis para edição.
    [Tags]             fluxo_alternativo
    Dado que o usuário está na tela de atualização de endereço
    Quando o usuário seleciona "Não sei o meu CEP"
    Então os campos de endereço manual devem ser exibidos