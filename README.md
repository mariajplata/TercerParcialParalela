# Tercer parcial Computación Paralela: Algoritmos para Comparativa de Rendimiento "Benchmarks - Nodos de Cómputo"
 
En este repositorio encontrará el siguiente algoritmo para utilizar en el parcial #3 de Computación Paralela y Distribuida:

**final_exam:** benchmark que resuelve la ecuación del calor para imágenes de botellas de distintos tamaños (pequeña, mediana y grande)
 
### Instrucciones de uso y ejecución:
* Desde la consola de ubuntu dirígase a la carpeta correspondiente a **final_exam** en su máquina
* Ejecute el comando **make** para que este realice la compilación del código cython
* Ejecute el código **python3 heat_main.py** para ejecutar el programa
* En caso de necesitar ejecutarlo de nuevo es necesario primero borrar los archivos que este genera, puede usar el comando **make clean** para hacerlo de manera automática.
  Posteriormente deberá realizar los dos pasos anteriores de nuevo.
  
### NOTA:
* Al finalizar la ejecución del programa recuerde copiar desde la consola los resultados obtenidos. Antes de las 30 ejecuciones de cada botella se imprime el nombre de la misma
* Los pasos anteriores corresponden a la ejecución en cython del programa, si desea ejecutarlo en python debe hacer lo siguiente:
  1. En el archivo **heat_main.py** se debe cambiar el import de la línea 5, en vez de poner **from heat_cyt import init_fields, write_field, iterate** se debe colocar **from heat import init_fields, write_field, iterate**
  2. Tras realizar el cambio y guardar se puede ejecutar el archivo sin necesidad del **make**, solo usando **python3 heat_main.py**. No obstante, si se quiere ejecutar el programa de nuevo se debe utilizar el **make clean** para borrar las imágenes que se generan.
