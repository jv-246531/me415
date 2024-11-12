library(dplyr)
library(readr)

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

pontuacao_final <- sum(resultado$pontuacao)
total_observacoes <- sum(resultado$observou)
total_esquerda <- sum(resultado$chute == 1, na.rm = TRUE)
total_direita <- sum(resultado$chute == 0, na.rm = TRUE)
identificacao <- fromJSON("configuracoes.json")$semente
informacao <- fromJSON("configuracoes.json")$tipo
probabilidades <- ifelse(fromJSON("configuracoes.json")$probabilidade %in% c(0.4,0.6), "40-60", "30-70")
chutes <- toJSON(resultado$chute, auto_unbox = TRUE)
pontuacao <- toJSON(resultado$pontuacao, auto_unbox = TRUE)

read_csv("dados.csv") %>%
  rbind(c(identificacao,
          probabilidades,
          informacao,
          total_esquerda,
          total_direita,
          total_observacoes,
          pontuacao_final,
          chutes,
          pontuacao)) %>%
  write_csv("dados.csv")