library(readr)
library(dplyr)

dados <- read_csv("dados.csv")

modelo <- dados %>%
  mutate(probabilidade = ifelse(probabilidade == "40-60", 1, -1),
         informacao = ifelse(informacao == "altera", 1, -1),
         observacoes = observacoes) %>%
  lm(data = ., observacoes ~ pontuacao_total + probabilidade*informacao) 

