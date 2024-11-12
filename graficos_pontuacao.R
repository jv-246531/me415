library(readr)
library(dplyr)
library(ggplot2)

dados <- read_csv("dados.csv")

numero <- 12

dados[numero,]$pontuacao %>% jsonlite::fromJSON() %>% {data.frame(x = 1:200,
                                                             y = rep(1,200),
                                                             cores = factor(., levels = c(-1,0,1)))} %>%
  ggplot() + 
  geom_tile(aes(x = x,
                y = y,
                fill = cores)) +
  scale_fill_manual(values = c("-1" = "#dd2020", "0" = "#111280", "1" = "#40dd40")) +
  theme_void() +
  theme(legend.position = "none")

dados[numero,]$probabilidade
dados[numero,]$informacao
dados[numero,]$observacoes
dados[numero,]$pontuacao_total
