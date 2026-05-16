#
# Instalación de paquetes
#

install.packages("ggplot2")       # para gráficos
install.packages("dplyr")         # para tratamiento de datos

library(ggplot2)
library(dplyr)


datos <- read.csv("datos_finales.csv", sep = ";", colClasses = "character")         # para leer usa el separador de ; (en el csv están separados por ;) y va convirtiendo a texto

View(datos)                       # para confirmar que la tabla de datos está bien


# Convertimos la masa salarial y el año a numéricos -> quitamos los puntos "." y lo pasamos a número

datos$año <- as.numeric(datos$año)
datos$masa_salarial <- as.numeric(gsub("\\.", "", datos$masa_salarial))


# masa salarial Club Atlético de Madrid

datos %>%
  
  filter(equipo == "Club Atlético de Madrid") %>%                   # filtramos por equipo Atlético de Madrid
  filter(!is.na(masa_salarial)) %>%                                 # filtramos quitando valores nulos
  
  
  # creamos el gráfico -> eje x = año, eje y = masa_salarial
  
  ggplot(aes(x = año, y = masa_salarial)) +
  geom_line(color = "#ef0107", linewidth = 1.2) +                   # ancho de la linea
  geom_point(color = "#ef0107", size = 2.5) +                       # tamaño del punto
  
  
  # titulos de los ejes
  
  labs(
    title = "Evolución de la masa salarial del Club Atlético de Madrid",
    x = "Año",
    y = "Masa salarial (miles de €)",
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
    limits = c(0, 400000),                                                 # límites minimo y maximo
    breaks = seq(0, 400000, by = 50000),                                   # saltos cada 50.000
    labels = scales::label_comma(big.mark = ".", decimal.mark = ",")       # para formato español con "." en cada mil y "," para decimales
  ) +
  scale_x_continuous(                                                      # modifica el eje x
    breaks = seq(2005, 2025, by = 1)                                       # saltos cada año
  )

