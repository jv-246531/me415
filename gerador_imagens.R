renv::restore()

library(png)
library(jsonlite)

set.seed(fromJSON("configuracoes.json")$semente)

escolhas <- rbinom(n = fromJSON("configuracoes.json")$tamanho,
                   size = 1,
                   prob = fromJSON("configuracoes.json")$probabilidade)

for (i in 1:fromJSON("configuracoes.json")$tamanho) {
  if (escolhas[i] == 1) {
    writePNG(image = readPNG("lado1.png"),
             target = paste0("saida/",i,".png"))
  }
  else {
    writePNG(image = readPNG("lado2.png"),
             target = paste0("saida/",i,".png"))
  }
}

write(toJSON(data.frame(Imagem = 1:fromJSON("configuracoes.json")$tamanho,
                        Observação = escolhas),
             pretty = TRUE),
      file = "saida/gabarito.json")
