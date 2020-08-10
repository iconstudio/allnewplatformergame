{
  "optionsFile": "options.json",
  "options": [],
  "exportToGame": true,
  "supportedTargets": 2097160,
  "extensionVersion": "1.0.0",
  "packageId": "lpblock.eladga.me",
  "productId": "F6AD53DE0955964339FE48A03BCAFDAB",
  "author": "",
  "date": "2020-08-07T15:17:45.5514372+09:00",
  "license": "Free to use, also for commercial games.",
  "description": "",
  "helpfile": "",
  "iosProps": true,
  "tvosProps": false,
  "androidProps": true,
  "installdir": "",
  "files": [
    {"filename":"Luckypatcher_Blocker.ext","origname":"extensions\\Luckypatcher_Blocker.ext","init":"","final":"","kind":4,"uncompress":false,"functions":[
        {"externalName":"getSignature","kind":11,"help":"_HackCheck_GetSignature()","hidden":false,"returnType":1,"argCount":-1,"args":[],"resourceVersion":"1.0","name":"_HackCheck_GetSignature","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"checkSignature","kind":11,"help":"HackCheck_Signature(signature)","hidden":false,"returnType":2,"argCount":1,"args":[
            1,
          ],"resourceVersion":"1.0","name":"HackCheck_Signature","tags":[],"resourceType":"GMExtensionFunction",},
        {"externalName":"isLuckyPatcherInstalled","kind":11,"help":"HackCheck_HackInstalled","hidden":false,"returnType":2,"argCount":-1,"args":[],"resourceVersion":"1.0","name":"HackCheck_HackInstalled","tags":[],"resourceType":"GMExtensionFunction",},
      ],"constants":[],"ProxyFiles":[],"copyToTargets":9223372036854775807,"order":[
        {"name":"_HackCheck_GetSignature","path":"extensions/Luckypatcher_Blocker/Luckypatcher_Blocker.yy",},
        {"name":"HackCheck_Signature","path":"extensions/Luckypatcher_Blocker/Luckypatcher_Blocker.yy",},
        {"name":"HackCheck_HackInstalled","path":"extensions/Luckypatcher_Blocker/Luckypatcher_Blocker.yy",},
      ],"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMExtensionFile",},
  ],
  "classname": "",
  "tvosclassname": "",
  "tvosdelegatename": "",
  "iosdelegatename": "",
  "androidclassname": "HackCheck",
  "sourcedir": "",
  "androidsourcedir": "",
  "macsourcedir": "",
  "maccompilerflags": "",
  "tvosmaccompilerflags": "",
  "maclinkerflags": "",
  "tvosmaclinkerflags": "",
  "iosplistinject": "",
  "tvosplistinject": "",
  "androidinject": "",
  "androidmanifestinject": "",
  "androidactivityinject": "",
  "gradleinject": "",
  "iosSystemFrameworkEntries": [],
  "tvosSystemFrameworkEntries": [],
  "iosThirdPartyFrameworkEntries": [],
  "tvosThirdPartyFrameworkEntries": [],
  "IncludedResources": [
    "Scripts\\HackCheck_ShowCertificate",
    "Objects\\objHackDetect",
  ],
  "androidPermissions": [],
  "copyToTargets": 2097160,
  "parent": {
    "name": "AntiLuckyPatcher",
    "path": "folders/AntiLuckyPatcher.yy",
  },
  "resourceVersion": "1.0",
  "name": "Luckypatcher_Blocker",
  "tags": [],
  "resourceType": "GMExtension",
}