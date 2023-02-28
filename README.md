# Projeto do Processador Ahmes em VHDL

Este relatório tem como objetivo fornecer uma descrição detalhada da implementação do Processador Ahmes que é descrito na linguagem de descrição de hardware VHDL (VHSIC Hardware Description Language) e consiste em três componentes principais:

- `A memória:` é descrita como um componente genérico que é utilizado para armazenar dados. Ele possui portas de entrada e saída para a leitura e escrita de dados, respectivamente.
- `O datapath:` descreve a estrutura de dados da CPU e inclui todas as operações que são executadas pelo CPU. Ele inclui as portas para controlar as operações que são executadas e a troca de dados.

- `A unidade de controle:` descreve a lógica de controle da CPU e inclui todas as decisões sobre as operações que devem ser executadas.

<div align="center">
<img src="https://user-images.githubusercontent.com/61710159/221974005-c9dc32c0-9e8b-458a-b591-bb94f2c29842.png" width="1000px" />

Figura 1 : Descição dos Componentes do Processador Ahmes.
</div>

# Descrição do Datapath:

O datapath é o caminho de dados do processador e é composto por vários componentes, incluindo registradores, unidades de controle e multiplexadores, que trabalham juntos para realizar as operações de processamento. O datapath do processador Ahmes é composto por:

- `Registrador acumulador:`Armazena o resultado de operações da ULA.

- `Registrador de programa contador:` Armazena o endereço da próxima instrução a ser executada.

- `Registrador de instrução:` Armazena a instrução atual.

- `Registrador de Flags:` Armazena as flags geradas pela ULA.

- `Registrador de endereço remoto:` Armazena o endereço de memória remoto.

- `Unidade lógico-aritmética (ULA):` Realiza as operações aritméticas e lógicas.

- `Multiplexador 1:` Seleciona a entrada para a memória.

- `Multiplexador 2:` Seleciona a entrada para a ULA, Reg_RI e Reg_REM.

# Processamento:

O processamento no datapath do processador Ahmes é controlado por sinais de entrada e por seus registradores internos.

- `Carga_acumulador:` Se este sinal estiver ativo, a saída da ULA será armazenada no registrador acumulador.

- `Inc_PC:` Se este sinal estiver ativo, o contador de programa será incrementado em um.

- `Carga_PC:` Se este sinal estiver ativo, o contador de programa será carregado com a entrada de endereço.

- `Reset:` Se este sinal estiver ativo, todos os registradores serão reiniciados.

- `Carga_rem:` Se este sinal estiver ativo, o registrador de endereço remoto será carregado com a entrada de endereço.

- `Sel_mux:` Seleciona a entrada para o multiplexador 1.

- `Sel_mux2:` Seleciona a entrada para o multiplexador 2.

- `Carga_RI:` Se este sinal estiver ativo, o registrador de instrução será carregado com a entrada de dado.

- `Sel_ULA:` Seleciona a operação a ser realizada pela ULA.

Qual componente FPGA escolheste para a síntese? Spartan3E.
Quantos registradores tem o datapath do RAMSES? 5.
Quantas operações diferentes tem a ULA? 10.

A área do DATAPATH em # LUTs: 116 e #ffps: 37.

# Descrição da Unidade de Controle:

A entidade "unidade_de_controle" é definida com vários elementos de entrada e saída. Os elementos de entrada incluem o clock, o reset, várias instruções, flags de condições, entre outros. Já os portos de saída incluem informações sobre a carga de flags, o selecionador da ULA, o selecionador do MUX2, a carga de ACC, o selecionador do MUX1, a incrementação do PC, a carga do PC, a carga do REM, a escrita na memória e a instrução HLT.

A UC é implementada como uma FSM com 8 estados. Cada estado representa uma etapa do ciclo de clock da UC e é determinado pela combinação de entrada de instruções e flags de condições. A constante é utilizada para definir o valor de saída para o selecionador da ULA de acordo com a instrução de entrada.

O processo principal da UC consiste em ler a entrada atual e decidir qual será o próximo estado e as saídas. No estado inicial, S0, a UC aguarda a recepção do reset para inicializar. Em seguida, a UC entra em um estado determinado pelo tipo de instrução recebida e pela condição das flags.

<div align="center">
<img src="https://user-images.githubusercontent.com/61710159/221974237-17446c56-a5a3-4f26-b5bb-0fb4919a1a7c.png" width="600px" />

</div>


<div align="center">
<img src="https://user-images.githubusercontent.com/61710159/221974790-a537c598-61ab-451e-bc39-01e69ad4619f.png" width="600px" />

</div>

|Tempo |SHR |SHL |ROR |ROL |SUB |
| - | - | - | - | - | - |
|T0 |sel\_MUX1=0, Carga\_REM |sel\_MUX1=0, carga\_REM |sel\_MUX1=0, carga\_REM|sel\_MUX1=0, carga\_REM|sel\_MUX1=0, carga\_REM|
|T1 |Read, Inc\_PC |Read,  inc\_PC |Read,  inc\_PC|Read,  inc\_PC|Read,  inc\_PC|
|T2 |carga\_RI |carga\_RI |carga\_RI|carga\_RI|carga\_RI|
|T3 |ULA(SHR), carga\_ACC, carga\_FLAG, Goto t0 |ULA(SHR), carga\_ACC, carga\_FLAG, Goto t0 |ULA(SHR), carga\_ACC, carga\_FLAG, Goto t0|ULA(SHR), carga\_ACC, carga\_FLAG, Goto t0|sel\_MUX1=0, carga\_REM|
|T4 |||||Read, inc\_PC|
|T5 |![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.006.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.007.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.008.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.009.png)|sel\_MUX1=1, carga\_REM|
|T6 |||||Read|
|T7 |![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.010.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.011.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.012.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.013.png)|ULA(SUB), carga\_ACC, carga\_FLAG, Goto t0|




|Tempo |JP (N=0) |JP (N=1) |JV (V=1) |JV (V=0) |JNV (V=0) |JNV (V=1) |
| - | - | - | - | - | - | - |
|T0 |sel\_MUX1=0, Carga\_REM|sel\_MUX1=0, Carga\_REM|sel\_MUX1=0, Carga\_REM|sel\_MUX1=0, Carga\_REM|sel\_MUX1= 0, Carga\_REM|sel\_MUX1= 0, Carga\_REM|
|T1 |Read, Inc\_PC|Read, Inc\_PC|Read, Inc\_PC|Read, Inc\_PC|Read, Inc\_PC|Read, Inc\_PC|
|T2 |carga\_RI|carga\_RI|carga\_RI|carga\_RI|carga\_RI|carga\_RI|
|T3 |sel\_MUX1=0, carga\_REM|inc\_PC, goto t0|sel\_MUX1=0, carga\_REM|inc\_PC, goto t0|sel\_MUX1= 0, carga\_REM|inc\_PC, goto t0|
|T4 |Read ||Read||Read||
|T5 |carga\_PC, Goto t0|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.014.png)|carga\_PC, Goto t0|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.015.png)|carga\_PC, Goto t0|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.016.png)|
|T6 |||||||
|T7 |![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.017.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.018.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.019.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.020.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.021.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.022.png)|


|Tempo |JC (C=1) |JC (C=0) |JNC (C=0) |JNC (C=1) |JB (B=1) |JB (B=0) |
| - | - | - | - | - | - | - |
|T0 |sel\_MUX1=0, Carga\_REM|sel\_MUX1=0, Carga\_REM|sel\_MUX1=0, Carga\_REM|sel\_MUX1=0, Carga\_REM|sel\_MUX1= 0, Carga\_REM|sel\_MUX1= 0, Carga\_REM|
|T1 |Read, Inc\_PC|Read, Inc\_PC|Read, Inc\_PC|Read, Inc\_PC|Read, Inc\_PC|Read, Inc\_PC|
|T2 |carga\_RI|carga\_RI|carga\_RI|carga\_RI|carga\_RI|carga\_RI|
|T3 |sel\_MUX1=0, carga\_REM|inc\_PC, goto t0|sel\_MUX1=0, carga\_REM|inc\_PC, goto t0|sel\_MUX1= 0, carga\_REM|inc\_PC, goto t0|
|T4 |Read ||Read||Read||
|T5 |carga\_PC, Goto t0|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.023.png)|carga\_PC, Goto t0|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.024.png)|carga\_PC, Goto t0|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.025.png)|
|T6 |||||||
|T7 |![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.026.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.027.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.028.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.029.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.030.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.031.png)|


|Tempo |JNB (B=0) |JNB (B=1) |
| - | - | - |
|T0 |sel\_MUX1=0, Carga\_REM|sel\_MUX1=0, Carga\_REM|
|T1 |Read, Inc\_PC|Read, Inc\_PC|
|T2 |carga\_RI|carga\_RI|
|T3 |sel\_MUX1=0, carga\_REM|inc\_PC, goto t0|
|T4 |Read ||
|T5 |carga\_PC, Goto t0|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.032.png)|
|T6 |||
|T7 |![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.033.png)|![](Aspose.Words.4332f374-fb20-4d0b-8a48-be05b6f828d1.034.png)|

# Descrição do Decodificador: 

O decodificador de instruções é responsável por identificar a instrução a ser executada a partir da sa da do Registrador de Instrução (RI). Ele decodifica a saída do RI, sinalizando com o valor 1 a flag da instrução correta. As entradas são a sa da do RI, enquanto as saídas são as flags de instruções, como NOP, STA, LDA, ADD, OR, AND, NOT, SUB, JMP, JN, JP, JV, JNV, JZ, JNZ, JC, JNC, JB, JNB, SHR, SHL, ROR, ROL e HLT.  

A lógica do decodificador é implementada com um processo que observa a saída do RI. Todas as flags de instruções são inicializadas com o valor 0 e, em seguida, o processo verifica a saída do RI para identificar a instrução correta. Se a saída  do  RI  corresponder  a uma  das  opções  previamente  definidas,  a  flag  da instrução correspondente é sinalizada com o valor 1. 

# Tabela de Instruções: 


|Código em binário |Instrução |
| - | - |
|00000000 |NOP |
|00010000 |STA |
|00100000 |LDA |
|00110000 |ADD |
|01000000 |OR |
|01010000 |AND |
|01100000 |NOT |
|01110000 |SUB |
|10000000 |JMP |
|10010000 |JN |
|10010100 |JP |
|10011000 |JV |
|10011100 |JNV |
|10100000 |JZ |
|10100100 |JNZ |
|10101000 |JC |
|10101100 |JNC |
|10110000 |JB |
|10110100 |JNB |
|11000000 |SHR |
|11010000 |SHL |
|11100000 |ROR |
|11110000 |ROL |
|11111111 |HLT |


# Operação de multiplicação: (4 x 2 = 8)

NOP  
LDA 29  
STA 33  
LDA 35  
STA 30  
LDA 30  
ADD 28  
STA 30  
LDA 33  
SUB 34  
STA 33  
JZ 25  
JMP 9  
HLT  

### Assembly do arquivo .coe : 

MEMORY\_INITIALIZATION\_RADIX= 10; MEMORY\_INITIALIZATION\_VECTOR= 0, 32, 29, 16, 33, 32, 35, 16, 30, 32, 30, 48, 28, 16, 30, 32, 33, 112, 34, 16, 33, 160, 25, 128, 9, 240, 0, 0, 4, 2, 0, 0, 0, 0,  1, 0; 


# Operação de SHL e Decrementador com desvio (JZ) e (JMP):

NOP  
NOP  
NOP  
LDA 24  
SHL  
STA 25  
LDA 24  
SUB 26  
LDA 24  
JZ 20  
JMP 8  
STA 24   
NOP  
HLT  

Assembly do arquivo .coe : 

MEMORY\_INITIALIZATION\_RADIX= 10; MEMORY\_INITIALIZATION\_VECTOR= 0, 0, 0, 32, 24, 225, 16, 25, 32, 24, 112, 26, 16, 24, 32, 24, 160, 20, 128, 8, 16, 24, 0, 240, 10, 0, 1; 


# Simulações sem e com atraso com detalhes e flechas mostrando inicio meio e final do programa e resultados: 

### Sem Atraso:

<div align="center">
<img src="https://user-images.githubusercontent.com/61710159/221975504-b5112b7c-34f0-431e-b074-203260282fa5.png" width="1000px" />

</div>


### Atraso: 

<div align="center">
<img src="https://user-images.githubusercontent.com/61710159/221976013-0061d0be-52ce-4bff-aff8-07d29c99f2fe.png" width="1000px" />

</div>

<div align="center">
<img src="https://user-images.githubusercontent.com/61710159/221976292-c83f925d-07ef-4429-8c3d-2c5d70f997a8.png" width="1000px" />

</div>

</div>
<div align="center">
<img src="https://user-images.githubusercontent.com/61710159/221976483-532a87fa-2935-4bba-9066-e1e4a158c17d.png" width="1000px" />

</div>

# Dados de área, tempo de execução em ciclos de relógio e em ns deve ser apresentado dado um determinado clock usado: 

|Programa |Nœmero de Instruções Executadas |<p>Tempo de execução em ciclos de relógio (c.c.) </p>|Tempo de execução em Segundos (Ahmes operando a 50 MHz) |
| - | :-: | - | :-: |
|Multiplicaço por somas sucessivas |19 |148 |1480 ns |
|Programa com SUB e SHL |64 |454 |4540 ns |
