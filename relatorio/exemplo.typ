#import "relatorio.typ" : capa, imagem, imagemb, imagemc, codigo

#capa("Relatório 3", "Um subtítulo", "Engenharia de Telecomunicações", "BCD29008 - Banco de Dados", "Nome do Professor", ("João Pedro",), "16 de outubro de 2023")

#pagebreak()

#outline()

#pagebreak()

#imagem("imagens/ifsc-v.png", 70%, "Logomarca do Instituto Federal de Santa Catarina", "Autor: IFSC.")

#imagemb("imagens/ifsc-v.png", 70%, "Logomarca do Instituto Federal de Santa Catarina", "Autor: IFSC.")

#pagebreak()

#imagemc("imagens/ifsc-v.png", 70%, "Logomarca do Instituto Federal de Santa Catarina", "Autor: IFSC.")

#pagebreak()

#capa("Relatório 3", "Um subtítulo", "Engenharia de Telecomunicações", "BCD29008 - Banco de Dados", "Nome do Professor", ("Aluno 1","Aluno 2","Aluno 3"), "16 de outubro de 2023")

#codigo(
        numbers: true
    )[```matlab
    clc; close all; clear all;

    M = 200;
    N = M+1;
    O = M + N
    ```]


#codigo(
        numbers: true,
        firstnumber: 10
    )[```matlab
    clc; close all; clear all;

    M = 200;
    N = M+1;
    O = M + N
    ```]