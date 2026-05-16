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

datos$ingresos_totales <- as.numeric(gsub("\\.", "", datos$ingresos_totales))


# ingresos Real Madrid

datos %>%
  
  filter(equipo == "Real Madrid C.F.") %>%                          # filtramos por equipo Real Madrid
  filter(!is.na(ingresos_totales)) %>%                              # filtramos quitando valores nulos
  
  
  # creamos el gráfico -> eje x = año, eje y = ingresos_totales
  
  ggplot(aes(x = año, y = ingresos_totales)) +
  geom_line(color = "#7b68ee", linewidth = 1.2) +                   # ancho de la linea
  geom_point(color = "#7b68ee", size = 2.5) +                       # tamaño del punto
  
  
  # titulos de los ejes
  
  labs(
    title = "Evolución de los ingresos del Real Madrid C.F.",
    x = "Año",
    y = "Ingresos totales (miles de €)",
    ) +
  
  theme_minimal() +
  
  
  # personalizamos el diseño de la gráfica
  
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),      # estilo del título general
    axis.title.x = element_text(size = 11, margin = margin(t = 12)),       # estilo títlo eje x
    axis.title.y = element_text(size = 11, margin = margin(r = 12)),       # estilo títlo eje y
    axis.text = element_text(size = 9),                                    # tamaño de los numeros de los ejes
  ) +
  
  scale_y_continuous(                                                      # modifica el eje y
    breaks = seq(0, 1200000, by = 100000),                                 # saltos cada 100.000
    labels = scales::label_comma(big.mark = ".", decimal.mark = ",")       # para formato español con "." en cada mil y "," para decimales
  ) +
  scale_x_continuous(                                                      # modifica el eje x
    breaks = seq(2004, 2025, by = 1)                                       # saltos cada año
  )

    