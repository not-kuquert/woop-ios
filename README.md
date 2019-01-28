# Eventos Woop
Esse é a implementação de uma solução para o [teste]((https://github.com/WoopSicredi/jobs/issues/3)) do Woop Sicredi

## Setup

Foi desenvolvido usando `Xcode Version 10.1 (10B61)`


Esse projeto usa o [Carthage](https://github.com/Carthage/Carthage)<sup>*</sup>, para instalar as dependências use
```
carthage bootstrap --platform iOS
```

Caso não queria instalar as depências, foi criado um [release](colocar.link.do.release) que inclui todas as dependecias 

> *Não sou muito fã das mágicas que o Cocoapods faz com workspaces, acredito que o carthage é mais seguro<sup>**</sup> e transparente.


> ** Hipoteticament daria pra rodar scripts aleatórios que estivessem no Podspec de alguma depeniedncia


## Dependências
Tentei usar a menor quantidade de dependências que eu consegui, 

[RSwift](https://github.com/mac-cain13/R.swift)
> Foi inspirado no R, do android, e funciona criando um arquivo swift com todos os recursos que ele consegue indexar no projeto (strings, nib, storyboards e etc)

[Kingfischer](https://github.com/onevcat/Kingfisher)
> Para carregamento e cache de imagens, usado para imagens das celulas, fiquei entre esse e o [Haneke](https://github.com/Haneke/HanekeSwift), mas escolhi o Kingfischer pois tem commits mais recentes e menos issues.

## Explicações

- Algumas imagens não carregam pois usam `http://`, foi criado uma propriedade computada que substitui por `https://`, mas alguns dominios não tem suporte. Não foi adicionada a configuração de `allow arbitary loads` por motivos de segurança.

- Como é um projeto de teste, decidi construir minha propria bibloteca para requests, ela não é robusta como o [Alamofire](https://github.com/Alamofire/Alamofire), mas para o simplicidade do projeto ela é o suficiente. 

- As configurações boilerplate(delegate, dataSource, separators, etc) de views foram feitas no storyboard para o códico das ViewControllers ficar mais limpo


## Build phases

Foram adicionadas dois scripts nas Build Phases:
- R.swift, que roda o binário que está salvo no diretório `RSwift`
- Carthage copy frameworks, que resolve um bug que acontece durante o Archive.

 
## Oraganização do projeto

The project is organized with the fallowing structure:
 - Views 
 	> Todas as views e xibs
- ViewControllers 
	> ViewControllers usadas no projeto
- Model 
	> Estruturas usadas para representar os dados
- Network 
	> Protocolos e implemntações de serviços e a faxada expor de forma simples requests de evento
- Utils 
	> Extensões e utilidades
- MockData
	> arquivos json com respostas mockadas

## Oportunidades de melhoria

 - [ ] Usar uma custom transition para mostrar os detalhes do card como é feito no app da AppStore
 - [ ] Mostrar lista com todas as pessoas que estão num determinado evento.
 - [ ] Adicionar certificate pinning, caso consumissemos os todos dados de apenas um domínio de API.
 - [ ] Melhorar os testes