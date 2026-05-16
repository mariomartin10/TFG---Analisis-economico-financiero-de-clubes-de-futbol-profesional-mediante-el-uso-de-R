#
# Instalación de paquetes
#

install.packages("ggplot2")       # para gráficos
install.packages("dplyr")         # para tratamiento de datos

library(ggplot2)
library(dplyr)


datos <- read.csv("datos_finales.csv", sep = ";")         # para leer usa el separador de ; (en el csv están separados por ;) y va convirtiendo a texto

View(datos)                       # para confirmar que la tabla de datos está bien


# Convertimos los gastos a numéricos -> quitamos los puntos "." y lo pasamos a número

datos$gastos_totales <- as.numeric(gsub("\\.", "", datos$gastos_totales))


# Gastos totales

datos %>%
  
  filter(!is.na(gastos_totales)) %>%                                 # filtramos quitando valores nulos
  
  
  # creamos el gráfico -> eje x = año, eje y = gastos_totales, color = cada equipo
  
  ggplot(aes(x = año, y = gastos_totales, color = equipo)) +
  geom_line(linewidth = 1.2) +                                       # ancho de la linea
  geom_point(size = 2) +                                             # tamaño del punto
                                                                                          
                                                                                           
  # titulos de los ejes
  
  labs(
    title = "Evolución de los gastos totales",
    x = "Año",
    y = "Gastos totales (miles de €)",
    color = "Club"
  ) +
  
  theme_minimal() +                                                        
  
  
  # personalizamos el diseño de la gráfica
  
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),      # estilo del título general
    axis.title.x = element_text(size = 11, margin = margin(t = 12)),       # estilo títlo eje x
    axis.title.y = element_text(size = 11, margin = margin(r = 12)),       # estilo títlo eje y
    axis.text = element_text(size = 9),                                    # tamaño de los numeros de los ejes
    legend.title = element_text(size = 10, face = "bold"),                 # estilo título leyenda
    legend.text = element_text(size = 9)                                   # tamaño texto leyenda
  ) +
  
  scale_y_continuous(                                                   # modifica el eje y
    breaks = seq(0, 1200000, by = 100000),                              # saltos cada 100.000
    labels = scales::label_comma(big.mark = ".", decimal.mark = ",")    # para formato español con "." en cada mil y "," para decimales
  ) +
  scale_x_continuous(                                                   # modifica el eje x
    breaks = seq(2005, 2025, by = 2)                                    # saltos cada 2 años
  ) +
  
  scale_color_manual(values = c(                 # asignamos colores a cada equipo
    "Real Madrid C.F." = "#7b68ee",
    "F.C. Barcelona" = "#8b0000",
    "Club Atlético de Madrid" = "#ffd700",
    "Manchester United F.C." = "#ff8c00",
    "Manchester City F.C." = "#a6d8f5",
    "Arsenal F.C." = "#ef0107",
    "Juventus F.C." = "#000000",
    "A.C. Milan" = "#2e8b57"
  ))

