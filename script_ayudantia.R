library(rvest)

pagina <- read_html('https://www.tribunalconstitucional.cl/ver2.php?id=6399')

texto <- pagina %>%
  html_nodes('p') %>%
  html_text()


texto


parlamentarios <- c("Carmen Gloria Aravena Acuña",
                    "Jacqueline Van Rysselberghe Herrera",
                    "Ena Von Baer Jahn, Juan Castro Prieto",
                    "Rodrigo Galilea Vial",
                    "David Sandoval Plaza",
                    "Luz Ebensperger Orrego")

texto_corregido <- gsub("\r\n", " ", texto)

for (parlamentario in parlamentarios){
  if (sum(grepl(parlamentario, texto_corregido)) >= 1){
    print(parlamentario)
  }
}


df <- data.frame()

for (parlamentario in parlamentarios){
  aux <- grepl(parlamentario, texto_corregido)
  df <- rbind.data.frame(df, aux)
  
}

as.numeric(colSums(df))




pagina <- read_html('https://www.tribunalconstitucional.cl/ver2.php?id=391')

parrafos <- pagina %>%
  html_nodes('p') %>%
  html_text()


parrafos


parlamentarios <- c("Carmen Gloria Aravena Acuña",
                    "Jacqueline Van Rysselberghe Herrera",
                    "Ena Von Baer Jahn, Juan Castro Prieto",
                    "Rodrigo Galilea Vial",
                    "David Sandoval Plaza",
                    "Luz Ebensperger Orrego",
                    "Iván Moreira Barros",
                    "Andrés Chadwick Piñera")

parrafos_corregido <- gsub("\r\n", " ", parrafos)
parrafos_corregido <- gsub("\n", " ", parrafos_corregido)

for (parlamentario in parlamentarios){
  if (sum(agrepl(parlamentario, parrafos_corregido,
                 ignore.case = FALSE, max.distance = 0.4)) >= 1){
    print(parlamentario)
  }
}


df <- data.frame()

for (parlamentario in parlamentarios){
  aux <- agrepl(parlamentario, parrafos_corregido,
                ignore.case = FALSE, max.distance = 0.4)
  df <- rbind.data.frame(df, aux)
}

as.numeric(colSums(df))

parrafos_corregido[7]