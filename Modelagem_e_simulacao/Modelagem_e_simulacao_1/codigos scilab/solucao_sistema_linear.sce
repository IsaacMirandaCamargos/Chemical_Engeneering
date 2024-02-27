clc
clear
mode(-1)

// VARIAVEIS

// n: nitrato ( 140g )
// f: fosfato ( 190g )
// p: potássio ( 205g )
// x: reagente 1
// y: reagente 2
// z: reagente 3
// w: reagente 4

// MATRIX, VECTOR AND ANSWER
matriz = [10 10 50 20; // nitrato
          10 100 20 40; // fostato
          100 30 20 35; // potassi
          5 6 5 15] // money
          
B = [140; 190; 205; 54]

r = (inv(matriz)*B)*1000 // reagentes em gramas


mprintf("Se deve misturar as seguintes quantidades de reagentes\nx = %f g\ny = %f g\nz = %f g\nw = %f g", r(1), r(2), r(3), r(4))


