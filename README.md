Woop README:

Escolhi não usar nenhum framework de rede, acabei construindo meu próprio. Uma dependencia a menos já que o projeto é super pequeno.

Nao adicionei a layer de allow arbitary loads por motivos de segurança, então allgumas imagens não estão carregando.

Usei carthage pois acredito ser mais seguro e transparente.
```
carthage bootstrap --platform iOS
```

Dependências:
R.swift
 // rswift binary is downloaded from "mac-cain13/R.swift" repository directilly and added to the project. 

 Kingfisher
 // Para lidar com cache de imagens

 Build Phases:
TODO: Falar sobre as Build Phases que foram adicionadas.

 //TODO:  Maybe add the outdated shell command:
 /usr/local/bin/carthage outdated --xcode-warnings


TODOs:

-[ ] Extract content od EventTableViewCell to EventView to a xib so it can be reused inside EventTableViewCell and in the EventDetailViewController.
-[ ] Create custon transition and replace navigation controller
-[ ] Update network lib to support post request so user can check-in
-[ ] Add inputs for user email and name.
-[ ] Add circular view to represent all the users
-[ ] Reesolve lat,long to address to populate detail view.