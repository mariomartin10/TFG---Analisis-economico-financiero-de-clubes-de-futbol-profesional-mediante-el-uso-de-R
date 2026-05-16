#
# Instalación de paquetes
#

install.packages("ggplot2")       # para gráficos
install.packages("dplyr")         # para tratamiento de datos
install.packages("tidyr")         # para transformar tablas para el gráfico de barras

library(ggplot2)
library(dplyr)
library(tidyr)


datos <- read.csv("datos_finales.csv", sep = ";", colClasses = "character")         # para leer usa el separador de ; (en el csv están separados por ;) y va convirtiendo a texto

View(datos)                       # para confirmar que la tabla de datos está bien


# Convertimos las variables del desglose a numéricas -> quitamos los puntos "." y lo pasamos a número

datos$ingresos_matchday <- as.numeric(gsub("\\.", "", datos$ingresos_matchday))

datos$ingresos_broadcasting <- as.numeric(gsub("\\.", "", datos$ingresos_broadcasting))

datos$ingresos_comerciales <- as.numeric(gsub("\\.", "", datos$ingresos_comerciales))

datos$otros <- as.numeric(gsub("\\.", "", datos$otros))


# ponemos el orden de los clubes a mostrar

orden_clubes <- c(
  "Real Madrid C.F.",
  "F.C. Barcelona",
  "Club Atlético de Madrid",
  "Manchester United F.C.",
  "Juventus F.C.",
  "A.C. Milan"
)


# Desglose de ingresos 2025

datos %>%
  
  filter(año == 2025) %>%                                         # filtramos por año 2025
  
  filter(equipo %in% orden_clubes) %>%                            # filtramos para que los equipos salgan en el orden establecido
  
  
  # tratamos al año como una categoría y que aparezca en ese orden
  
  mutate(equipo = factor(equipo, levels = orden_clubes)) %>%
  
  
  # ahora cada categoría (año) tiene varias variables (matchday...) y pasan a ser una columna (categoria) con sus nombres (name_to) 
                                                                                # y otra columna (ingresos) con sus valores (values_to)
  
  pivot_longer(
    cols = c(ingresos_matchday, ingresos_broadcasting, ingresos_comerciales, otros),     # cols = columnas que se juntan
    names_to = "categoria",                                                              # names_to = guarda nombres de categorías en cada año
    values_to = "ingresos"                                                               # values_to = guarda los 4 tipos de ingresos en ingresos
  ) %>%
  
  
  # cambiamos los nombres de las categorías por nombres bonitos
  
  mutate(
    categoria = factor(
      categoria,
      levels = c("ingresos_matchday", "ingresos_broadcasting", "ingresos_comerciales", "otros"),    # nombres originales
      labels = c("Matchday", "Broadcasting", "Comercial", "Otros")                                  # nombres que aparcerán en el gráfico
    )
  ) %>%
  
  
  # creamos el gráfico -> eje x = año, eje y = ingresos, fill = según categoría
  
  ggplot(aes(x = equipo, y = ingresos, fill = categoria)) +
  geom_col(position = position_dodge2(width = 0.8, preserve = "single"), width = 0.7) +    # geom_col crea barras
                                                                                           # position_dodge2() separa barras por categoría
                                                                                           # width = separacion entre grupos
                                                                                           # single = mantiene el ancho individual
                                                                                           # width 2 = ancho de las barras
  # titulos de los ejes
  
  labs(
    title = "Desglose de los ingresos por club en 2025",
    x = "Club",
    y = "Ingresos (miles de €)",
    fill = "Categoría:   "
  ) +
  
  theme_minimal() +
  
  
  # personalizamos el diseño de la gráfica
  
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),         # estilo del título general
    axis.title.x = element_text(size = 11, margin = margin(t = 12)),          # estilo títlo eje x
    axis.title.y = element_text(size = 11, margin = margin(r = 12)),          # estilo título eje y
    axis.text.x = element_text(size = 9, angle = 30, hjust = 1),              # tamaño números eje x
    axis.text.y = element_text(size = 9),                                     # tamaño números eje y
    legend.title = element_text(size = 10, face = "bold"),                    # estilo título leyenda
    legend.text = element_text(size = 9),                                     # tamaño texto leyenda
    legend.position = "bottom"                                                # dónde ponemos la leyenda
  ) +
  
  scale_y_continuous(                                                   # modifica el eje y
    limits = c(0, 600000),                                              # límite mínimo y límite máximo
    breaks = seq(0, 600000, by = 50000),                                # saltos cada 50.000
    labels = scales::label_comma(big.mark = ".", decimal.mark = ",")    # para formato español con "." en cada mil y "," para decimales
  ) +
  
  scale_fill_manual(values = c(                 # asignamos colores a cada barra
    "Matchday" = "#ffd700",
    "Broadcasting" = "#a6d8f5",
    "Comercial" = "#7b68ee",
    "Otros" = "#2e8b57"
  ))