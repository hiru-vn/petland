Step to intergrate inbox module:

- copy lib/modules/inbox folder to your project
- import your navigatorKey from your MaterialApp to it
- create your firebase project
- enable firestorage and firestore in your firebase project
- get an account at agora.io
- create a app in agora and get app key, remember use unsecured option, if not, agora will need a token to join room call
- parse your APP_ID agora to app_id.dart file
- the _authBloc is used to get userId, userAvatar and userName, you can remove it and replace with params from outside
- finally, do not forget to take a look at intergrate document for all the package this module use, both Android and IOS-
