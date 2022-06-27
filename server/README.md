# Skriešanas applikācija

## Projekta apraksts
Projekts ir domāts cilvēkiem, kuriem nav interesanti izmantot parastu aplikāciju, lai sekotu līdzi savam progressam. Šī aplikācija padara skriešanu vēlamāku, padarot to par spēli. Tādā veidā cilvēkam būs skriešana jautrāka nekā iepriekš. Kā arī ļaus izmantot funkcija, kas ir vairākām populārām skriešanas aplikācijām, kā vesture ar skriešanas datiem, sirdspukstu sensors

## Izmantotās tehnoloģijas
Projektā tiek izmantots:
- Flutter (priekš mobīlās aplikācijas veidošanas)
- NodeJS priekš servera
- GraphQL lai varētu viegli veikt pieprasījumus
- MySQL priekš datu bāzes

## Izmantotie avoti
[Flutter testēšana](https://www.youtube.com/playlist?list=PL6tu16kXT9PrzZbUTUscEYOHHTVEKPLha) - Tiks veikta automātiskā testēšana, lai atrastu kļūdas

[Flutter](https://flutter.dev/docs/get-started/editor) - Dokumentācija un kā uzstādīt flutter priekš programmas veidošanas

[Google maps](https://pub.dev/packages/google_maps_flutter) - Iepakojums, kas varbūt tiks izmantots, lai strādātu ar google maps

[Kā izmantot google maps iepakojumu](https://codelabs.developers.google.com/codelabs/google-maps-in-flutter/#3) - Piemērs, kā izmantot google maps

[Kā uzstādīt graphql-yoga un nodemon](https://medium.com/@gbolahanolawuyi/setting-up-a-graphql-server-with-node-graphql-yoga-prisma-a3f59d33dac0) - Kā uzstādīt graphql-yoga ar automātisko servera restartēšanu

[Modulārs veids taisīt graphql resolverus](https://github.com/prisma-labs/graphql-yoga/tree/master/examples/modular-resolvers) - Modulārāks veids, kā visu taisīt, lai samazinātu konfliktus un kļūdas kodā

[Trello](https://trello.com/) - Sekot līdzi saviem uzdevumiem, lai viss būtu organizēts

[GitLab Flow](https://docs.gitlab.com/ee/topics/gitlab_flow.html) - pamats, priekš branch veidošanas un mergošanas

[Docker](https://www.docker.com/) - varbūt tiks izmantots, lai atvieglotu uzstādīšanas processu (ir jāpēta vai tas ir izdevīgi)

[Formas validācija](https://www.freecodecamp.org/forum/t/how-to-validate-forms-and-user-input-the-easy-way-using-flutter/190377) - Kā taisīt form iekš flutter.

[Kā pievienot custom flutter ikonas](https://www.youtube.com/watch?v=uojqV6hUEDc) - Flutter ir unikāls veids, kā to dara

[Kā iegūt attālumu no divām kooridnātēm](https://stackoverflow.com/questions/17787235/creating-a-method-using-haversine-formula-android-v2/17787472#17787472) - Attālums metros no diām gps koordinātēm

[Popup](https://dev.to/mightytechno/flutter-alert-dialog-to-custom-dialog-1ok4) - Uztaisīt popup logu

[Pievienot aizvēršanas pogu priekš popup](https://stackoverflow.com/questions/57709298/how-to-design-custom-dialog-box-using-close-icon-with-flutter) - Lai lietotājam būtu intuitīvs veids, kā aiztaisīt logu

[Datubāzes migrācija uz NodeJS](https://www.jernejsila.com/2016/09/04/creating-database-migrations-seeds-node-js/) - Lai vieglāk būtu taisīt datubāzes tabulas

## Uzstādīšanas instrukcijas
1. Lai lietotu git lejupielādējam [Git for windows](https://git-scm.com/download/win)
2. Instalējam git.
3. Ielādējam [NodeJs](https://nodejs.org/en/download/)
4. Izveidojam mapīti priekš projekta un ieejam tajā
5. Klonejam projektu
```git clone git@github.com:rvtprog-kvalifikacija-20/d42-NiksKozlovs-RunningApp.git .```
6. Ielādējam node_modules ierakstot konsolē
```npm ci```
7. Mapītē nomainam nosaukumu .env.example uz .env un ieliekam vajadzīgos iestatījumus
8. Palaižam wamp serveri vai jebkuru citu aplikāciju, kas ieslēdz mysql
9. Palaižam graphql server ar komandu
```npm run start-production```
10. Ģenerējam keytool priekš google sign in un google maps [sekojot "Setup Firebase project"](Setup Firebase project)
11. Iegaumēt SHA-1 un android package name
12. Izveidot kontu ieks google maps api console [šeit](https://console.cloud.google.com/google/maps-apis/overview)
13. Izveidot projektu
14. Projektā uzstādīt API "Maps SDK for Android"
15. Kur prasa ievietot SHA-1 un android package name
16. Pieslēdzam ierīci ar USB debugging ieslēgtu (īstu vai emulatoru)
17. Ieejam mapītē RunningApp
```cd RunningApp```
18. Nomainam nosaukumu no .env.example uz .env un ieliekam vajadzīgos iestatījumus
19. Palaižam android aplikāciju
```flutter run```
