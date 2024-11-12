library(readr)
library(dplyr)
library(ggplot2)

dados <- read_csv("dados.csv")

numero <- 3

dados[numero,]$chutes %>% jsonlite::fromJSON() %>% {data.frame(x = 1:200,
                                                             y = rep(1,200),
                                                             cores = .)} %>%
  mutate(cores = ifelse(is.na(cores), 2, cores)) %>%
  mutate(cores = factor(cores)) %>%
  ggplot() + 
  geom_tile(aes(x = x,
                y = y,
                fill = cores)) +
  scale_fill_manual(values = c("2" = "#111280", "0" = "#efa500", "1" = "#902d50")) +
  theme_void() +
  theme(legend.position = "none")

dados[numero,]$probabilidade
dados[numero,]$informacao
dados[numero,]$observacoes
dados[numero,]$pontuacao_total

