library(dplyr)

resultado <- fromJSON("saida/gabarito.json") %>%
  left_join(read.delim("anotacoes.csv", sep = ":"), by = "Imagem") %>%
  mutate(chute = ifelse(chute == "e",
                        1,
                        ifelse(chute == "d",
                               0,
                               NA))) %>%
  mutate(pontuacao = ifelse(is.na(chute),
                            0,
                            ifelse(chute == Observação,
                                   1,
                                   -1))) %>%
  mutate(observou = ifelse(is.na(chute),
                           1,
                           0))

(pontuacao_final <- sum(resultado$pontuacao))
(total_observacoes <- sum(resultado$observou))

