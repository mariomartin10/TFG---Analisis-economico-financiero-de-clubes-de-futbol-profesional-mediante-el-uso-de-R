
# Primero instalamos paquetes. Aunque solo haga falta hacerlo una vez, está hecho en todos los
# scripts para tener presente todas las partes del proceso a generar gráficos

install.packages("ggplot2")       # para gráficos
install.packages("dplyr")         # para tratamiento de datos
install.packages("tidyr")         # para transformar tablas para el gráfico de barras


# Después cargamos las librerías de los paquetes instalados para poder usar sus funciones

library(ggplot2)
library(dplyr)
library(tidyr)