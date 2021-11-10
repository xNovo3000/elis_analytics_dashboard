'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  ".git/COMMIT_EDITMSG": "bcfe09266c5d6f6fa5bc448f7accafd5",
".git/config": "ea4329ef0aef64a5c67fabc58531ad70",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "4cf2d64e44205fe628ddd534e1151b58",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "ea587b0fae70333bce92257152996e70",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "888d6d71b4fdfda7ff8afc7fab9050fb",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "44007b41f09fc4c9e6a2a1c59670074e",
".git/logs/refs/heads/master": "44007b41f09fc4c9e6a2a1c59670074e",
".git/logs/refs/remotes/origin/HEAD": "55c9c381da155747284fbf6586cd6b24",
".git/logs/refs/remotes/origin/master": "27b3ac3bd6610c4dfa8f2e5dc346b015",
".git/objects/03/91183950712727f7b314559ebea4f724c6cdc5": "00e4ca4d7202bef33cd9873f8c9435ee",
".git/objects/04/29c4e826f2fb60710d85aa550718c3e96b5889": "7e804a61159d7e81bcd88caad7eb63df",
".git/objects/05/02058656034824ddcf333ce3abf24530833f0b": "d496148ade84092290152b13a2d18779",
".git/objects/05/5181ea2c9a62d309cd067de234aa9a9f4835e9": "dde48d2032be96e3bcc6ad554b2790f7",
".git/objects/06/5ab46b2996787360a0d067f0c0684ac87f35fa": "614b5ed3b75030691bb24725193bbae7",
".git/objects/06/9ffd6a2441ffd5c8a145af1e958fc0d2c492e4": "ab45fcef2e910a389b12b7e524a48b25",
".git/objects/06/a828729191245824b0d9357c255566b7d4c9ff": "b0c1c0a0d8739a5a8ec4af14d0437660",
".git/objects/07/8f43c9cf8231b16be0b228b6e7abeb8876296b": "691eae281a0f3fa1a3413d2463f60c7c",
".git/objects/08/270afa910f52c5b045d00fd424a1158a94c42d": "ad597ea39541ad66cc1288c3024522b7",
".git/objects/0a/e54e4d0510d72bcf658104015b850df38db572": "1a0c6a20cc1f620b82e2d39d79b299c5",
".git/objects/0d/9a65e892b624e803bef9f4376c4b229f9d879b": "1f1226df99c8f5f63957ff1b82b71dbd",
".git/objects/0d/ce7552d5c1f5456990de18ca259c8dd19067a2": "21d7d0f75d96274003d2bd80961b2f5a",
".git/objects/0e/b1846f18e39fb9c3390e86b8014f5b0fc2e56a": "b34b39118eef1882f48a88166cffa443",
".git/objects/12/a31794f3a4abf3ddf5cf1e82681ea2fada1a3a": "2e4759e57a97357d8c3c4c87d5ab98ee",
".git/objects/15/6adbb8ba390ffc67405a080e0b89072eb4e073": "3edf04daac93fd0a60b50c050cb1e172",
".git/objects/15/a08e8c0629082ac77bac5a67c3b38dcf6998ff": "b04dd5643c72214e1347e1432975230a",
".git/objects/19/ddc2bd6b3dd91923cca221cbb6a8f7139a7514": "ac5510ef86a9a9071f59a1d567df3844",
".git/objects/1c/85ea985b4e1daf0069e0918d0ec35ea771afa0": "efa6a5c5d3f1536a5fda566ec9e9a7db",
".git/objects/1c/fb14da166403325b501bf11c2d8af199a75931": "1f42c0fb1664b6733d78ea8fe84c449e",
".git/objects/22/aa5386dcf1fadc9ac51a9fa88ed84514fa3a03": "339757c2a660c678aef0b046e13fc0c4",
".git/objects/23/697bd97b87805d7d2f60d7000f621df65fd4fc": "4dcc5d6a503b3a9c6ab49fab40df7f2a",
".git/objects/24/c2d89c25170ea990094c1d3590bcf03ab19cf7": "b444fc88f47e4eca6aef0410fcc23671",
".git/objects/25/17568fe0c5e97ab3ce3e5b78d0449e5eba59fa": "25f262abedcff7a43539d9e547328a92",
".git/objects/2b/2fe1b658012325b21e7d5c470255bdd4476b72": "7faeae1fc593288c6b8eefece06780af",
".git/objects/2b/ffb9fac0128a650893b87efe28dfb2f27ce662": "3d27c9efbfe0ecd68c6384b5569a3bfc",
".git/objects/2f/226fb836108c7e0373b3290b6903952f020c1f": "93ca12df9352012fa5a0bb73837c76c0",
".git/objects/30/e5db9cadc625a03f06e2f9c1ae9107ee07ed4e": "75b38efa3041177ba01afe85980abe9f",
".git/objects/31/892275bf3721fbc63ed6982aeae9854ba6283e": "e4c640564ba16b3683c23272e349186f",
".git/objects/37/7c15409e315a10a3453822327a31373356b82d": "cd4863809efefee223b7d208f06c72bf",
".git/objects/38/5956f661be2a45fe4439b6d688ae01f20e9fe1": "b80c97461d008b56e51e06c7c2d42c26",
".git/objects/3d/c6d80f595de922e40613b79dd5ed1ee62e0091": "338b19bd1c3b5ec4d9cd9c39e4218d53",
".git/objects/3d/ded8f3173bd13b09cbe1e8895fbab5dabbab30": "a92f23d04214c7f1e6a54e9e89ae4755",
".git/objects/3e/3c7713266027e8d09b3767ba607f4465a54f34": "17ecf20c1b1b754663e4bb2dc509a0af",
".git/objects/41/aff9648495b9b95200d239a2406e610494e52c": "d9a1c63c56243a1e175f4c839f536b4f",
".git/objects/44/4ee6a652b09188b67f9db97c041abc7b4f3fad": "ff064e60ae441d921459146ebb3163b4",
".git/objects/48/708ac5048dc9f76717bc1a60c6482a64b4b963": "c5fa5da06f02fbffcd81097d0026efda",
".git/objects/48/ca8d2b3ce9c5e52137698745dbd46c31eb5e48": "718f586bdba1920addfaf5ee990fcc9a",
".git/objects/4c/12c9bba2bae38ebd8b569c111d061815992dc5": "ac405deffdd497e145c5ed8716e29b62",
".git/objects/4d/2d826a0f316988ff44b4e160d2c423b99394a4": "827e5b625a5ed48a39815cfe6a939f0f",
".git/objects/50/6afd4d36adbc05bfec35836a7480799570f896": "6113e21e94b13c2083882e82592c7681",
".git/objects/52/cb1b06ac53735993ee5ee5648e631ece6d329e": "0de49010de0553ef1c864ff4aa68e66d",
".git/objects/55/a15c4be8e4974b5b092aad59924c5b4b093862": "8caf6c70f3be3c61bab207af1257bd2e",
".git/objects/56/7db876903efb2881731e9330034a3b3c88fec9": "bce9eac4f788cc75556aecae092a79e1",
".git/objects/57/216bd3d3f5ab4fb67ca7d492b257548c53173d": "6b7dbf88f96fde570284c62b60130169",
".git/objects/58/7758427fa548d80fc893e915dd1af2b9d22613": "8016c9888001ba1d0d9b87ff503375d7",
".git/objects/5a/193e8f60a737f586fd3cfe9177d0fade2be819": "0c330823576552db035a183879d3a82f",
".git/objects/5c/6aeff07819eb909a5c3c5fac96dac9e0a5da29": "4cb276588bdb9b298e509a911cdb6d53",
".git/objects/61/7e8ade960d8949e3bb918f3265eae4ac828acc": "814692e42cc3c8201d8ac62daa68621c",
".git/objects/63/fec54e14d881821215c57e18faa4b074e8f505": "de33fababff445204cf23949325a9e77",
".git/objects/64/76f34dfc6a6c91e98c1fa7ad611c11313f7830": "7228b1d513abde151e62b816797aa2ac",
".git/objects/65/caa6dbe678bc5569ea45686961818e99f7acb4": "29d3937ec44edd9557960a1ecbd7ca0a",
".git/objects/67/474afd6a9b97a4916fb1d5dd2334cf2bc6f579": "3f024139e398cc89ca61c9efe08347a4",
".git/objects/67/c646f7095df04c507047026b6f2549e4a03c4b": "5043a72e76cbaf2ca7018e72b2cc4307",
".git/objects/67/e6e4561141c0124e0127659e9772ef6f90cced": "d15fa3d983f84006f137807aed8d2acc",
".git/objects/68/cef82608bbf00ffd5b750019e3105491fcb35d": "7b710707fe7666a7f07bbdca765df803",
".git/objects/73/3387612c77698d23707c709ad5d8df822011b3": "849c597636cb4099e5df76f6916b1c6d",
".git/objects/74/611a5f2542ced0035446b830cfb28e2e67b305": "d40883a9992f30299c7b80cb48656224",
".git/objects/78/4c989c0befb0d0a4824ea7b85a2a091e2d1d63": "bae5452a31c6686ff7b54ceb171d8ec7",
".git/objects/79/576ba40164ba4b19401e5352c79fb56cfd2f40": "129a7c769fbed2119d57b8eda70b5a08",
".git/objects/7a/6cee3b104388d8acdbfa6a9a520c3782ce4a69": "9fb19807d68d571f54d8c39633f94d10",
".git/objects/7c/6d549c882a88f5fd0868598d6f6891add7f578": "0007092b27ffdb6a3ae63d53ff7e86bc",
".git/objects/7c/8c1032eea5b94b7e16ce7d41d8a87e0bf605d2": "af2be6ef3630d0029eb4176b6d7b0835",
".git/objects/7d/28b69d699371701e054ea74f6bc5e256c58284": "77dda762790338e8bbe6a4bdeb1e6d1f",
".git/objects/82/4ea1c3ba328e854d4f4921b11ecc5437b598ca": "3f8b3989797b2a111ea9d19b2de0e2d9",
".git/objects/83/67b7c7805a6b4b104efd248f8dc0b1b4138540": "f1ab582c2bd6fa0631f6cfb0ee565626",
".git/objects/86/96440ae2bde6698e0748f72e0d349d55b077de": "c62e983943f7934e08d5ce06c6ce4368",
".git/objects/86/9fb078472abd221fc3c91dcd3410532d3634b2": "52bf425315e3fb5aebc43e3f0c90c3da",
".git/objects/8b/57f7ff67c785ebfc4fee958470377a5afb8a3f": "a99b3ae791164e63429279b2e22a5b70",
".git/objects/8c/a3bf1edfd2e390d16bb70d92135bdbd7edf084": "0febe6de6f849713b10904eaef593016",
".git/objects/94/726a80378df2ce80cceb94d35d2ce2ee08e79a": "0d90e7f7b2be1f5fa1935eb44acb3c8f",
".git/objects/96/de966110fb342fa813715c3996d861469008fd": "04d7119bce02002fb0cdfa62bbd18e32",
".git/objects/96/e96492aef9362da7918af154ef97d70111ba02": "e3ecb503af5b4d32693f444813991c47",
".git/objects/9a/c7d843c048ccf812c8409ff6102b5a272e489f": "12430853725b093a6078e1fff7abc05e",
".git/objects/9f/5960caf64696d2e587ccce2872bbd77f7072f5": "a68d801e6c944a94ba00466c5cf950ce",
".git/objects/a7/d1d1613c7b0e7f39e8533e90147ebdaffd60a8": "4e71d33251062199e55cfa33d25e6884",
".git/objects/a8/fcf89da9c7d10050377f93b2d61ae612f7ac11": "0db2141e8e0ed512008bfc010ec5214a",
".git/objects/a9/d7c042d26735a580adf7be4676b949b3214df5": "aa9cbe38fb2631037f9340cb8fb20a23",
".git/objects/ab/91e55c688673666d33ab93fed137de7b1ae272": "80174746a5ff9ef9b3756b0eb0c81adb",
".git/objects/ac/9dd0bebc5955ea810cda302c8b1ba59e29ed4b": "53f3a2e3538f7176ec340f3f9d411d29",
".git/objects/af/3f856cb2611f6713d923f871513ff1e8377504": "c38d7c025c70252d8630126dd545801d",
".git/objects/b0/b305872d02a9c229db6b0c78b32547af878fde": "e43760d106639772657c8d84d5fd787e",
".git/objects/b2/d14fd7aea159da4e3901c3e3f5e4dfbac9a83f": "d4ad1a7b439c972246881d32277ad6e8",
".git/objects/b2/d984241baf4bd8eae6fea249781f28f6fb873c": "a6306f97406e1bf84a6c7fe08a96dfe7",
".git/objects/b3/7bcc090eab992effd65edd7a8d5d6df5ec2044": "83ee3959a7d1e7d79efd15208b791e4c",
".git/objects/b4/2f6291e171acebcba456d7e0cba9f604794d7f": "eec73859e6a19f47ed562d2496a5e65a",
".git/objects/b4/ac9e27c41f610e2391672f00817b6bb9cac696": "7cdce60a221f4e3dc4914b0ef78ed003",
".git/objects/b6/ce36b20b9a628fd46b4f9201e1ad375eda112a": "01c979e2a078ef4b5591a09f93496932",
".git/objects/b9/28d9b8e13e5ffa8f900a844f0467a92bb54206": "586ee0b736af59ffb7fd15bdcfceb528",
".git/objects/bb/1e2fe66de93fcf2cba30c91423c8c1326817fd": "1efd4e094637f473e9e4da337390f50f",
".git/objects/bc/e9bd94bcaac5c41fa7785fa2781491a9ef5ddc": "426f8d17ee35dc7454be97d0db93bca3",
".git/objects/be/a0c06f94fd1424276215d48975df75e2e649e0": "845da613b0efba3d0f2ec89f3e0f8828",
".git/objects/bf/377c0ffe86e8d20390c7a2d0938a7db6bab201": "2c706af57f24b19789de32391d94366a",
".git/objects/bf/9639732ba8e37765168d252290590ce48ffe49": "7351e81fd71d11edac6ebf1b7f5b708c",
".git/objects/c2/4df17a94332c32ee3d7f9b469540a0bee791ea": "6c8090ff7073e6c016ba1cbe9e8bf393",
".git/objects/c3/f6c7545c91fc8f2bb59f9eee9bb247ca42723b": "ddea273fee94771392602f68c60647ed",
".git/objects/c5/95e0e559f74cfe0e78fecf9cc59cda3a5100af": "639d5ebf54e74f25b63b9fd1eab40307",
".git/objects/c5/96865e4800bba4ec5963c134468a6d63cad35c": "862c1d924b260553640a7c1bb46c1b01",
".git/objects/c6/f5e7c6df2fa9430096b25fb8823e5bb549884f": "7fc018884a42851c03e5cf4f5246e865",
".git/objects/ca/2c840a9fa9f6c37b169a6f8994ffdd2de5eb11": "ff77de98ead92743caad72796a629712",
".git/objects/cc/a66a346a629e21ad1df6836e872a61a7ba6948": "a6b9f832af3e625c69f92889417b5580",
".git/objects/d1/22b1beed7a6695aa56dba292a293d415b3285e": "71b44f497d0ee381e7f1925f059b1d8b",
".git/objects/d1/9f696468076826b2e379a938673c9d5cd4587e": "99511c02a1b030dbc991e4b44752d693",
".git/objects/d2/6a418be82d50b1c4a4640efc589d603ac4c90f": "b7aad2ba0996913fefb985f785d243ab",
".git/objects/d3/0a84ba3e51bc28b67bfef1cdd39ccbc7579539": "9ac75a77d72b48d81927fb0b26094429",
".git/objects/d4/91c6cd98529181fc3e05f9e22a93b76d7c2789": "0ed3fb3e7327a00f9f1790edb1795478",
".git/objects/d4/abc78f2e9a0751472d0d1cccb19b81bbdbfefb": "2110f4669f893793a47b854002495944",
".git/objects/d4/cc272444e254f7f6e74fd89e263de7e5b9511e": "2b57b7aedc9a6abf129297b352385a65",
".git/objects/d4/fe7ea1bd5a5ba9f969b473d1030916869ca6fe": "764d0ea5ddb0c2a08d3422948326c5d4",
".git/objects/d5/50c7567388d913ffbbd952f32e8c1c2bb78c89": "97cbfb42ec112ee4d0d56f56d4c1722c",
".git/objects/d6/0cacd3bf09ac764283b8369765d414d4d7cffe": "3a355e1e61fb2c1d208f5f3f69809d8a",
".git/objects/d7/d08d9125c12c33aea13707c8f7dacd161c8496": "f4517da0963d5024d73d56a6382fd9c2",
".git/objects/d9/bfaf950be14071d5016f7fbd8b1a7835abe4c0": "9898f75bc2d56927c6d1a185a8878e87",
".git/objects/d9/cf0a911617a377ad3782ed91ab7d53210f5679": "fc2a072dfbc7129849f12a4430dd0134",
".git/objects/da/7017e3cf463e0ea1cd96386a882775216a7a20": "02bd39f9bd83b41b44b275b4bea371e2",
".git/objects/da/c8d8895e960ad007191c887756c7d7d3b27d76": "dcb6dc1ce687099e0170e4845de2563a",
".git/objects/db/fe50b6f3394803c27c9bb9a0027325d3eaf6e4": "49b7581a4459e8be5c358e58599809f7",
".git/objects/dd/92223ffabe247b6a125357579b06641716d2a3": "0ca833121722a059a0ee28773f8ff8bb",
".git/objects/dd/e638ddc34a76b53579d40655144e3ee107cfbf": "eec02508253b590b85a5dedc22ec5511",
".git/objects/e0/13abfec85c2bb8287878768d1c612739faba88": "04191b232cc0aac4ff74077493ff9c93",
".git/objects/e6/9ad35acc0c19a4c8ee3b68aba29a51f1b6f09b": "58b9aab23e9d3ec0786eb286109fb457",
".git/objects/e7/d6402482616ef3f5956cb1ff21023c0a95e38c": "9ce98872f4580a3a240efbcf13b96e7e",
".git/objects/e8/4f2833c38ede824378d0914115259fd9d482f8": "a5afd1d64f75411da385de0a4769617a",
".git/objects/e9/cfad79282bb0a3c5bb9bd5bc07ceeea7c71fc5": "cdf409859f493193e1cbc86973df21c9",
".git/objects/ec/c2a3777b29bdd7a497177f34659cd0b9963534": "f14636d2f9552c5886effa4473f04ef3",
".git/objects/ed/68366cb3ba9c3cd22826e9d33d03e7f7ca0c04": "2d74f490476ab3d4d2fc3bdc96d3989f",
".git/objects/f1/a016747b33ab100084a09445ab12c473db6a3b": "08ed9e937aebb720c63cc5bbfddccf97",
".git/objects/f4/10ce30ea125df5a446bd89b2bf1514ad19eb0f": "d9dc8707bea6c2efc5fa23257e2f5602",
".git/objects/f7/0f6d2fe6bc2f6fb51d26fa5195eb5379009f7d": "885a83394be4ac74ec0b9d667f587328",
".git/objects/f8/dd8c1dc9916a19b3c118a06649382a829ff2b8": "af7c468930803514caffb92002d5bb96",
".git/objects/fa/cb8cf19200c7a9a22d62300b858c11f6c3be8a": "a2ee566eeef754d073f13111e54a071e",
".git/objects/fb/8e93ba81cf973f52925a1c4020c116d025c9e6": "c072fed576436fb40bb1c55e876728c8",
".git/objects/fd/9d5f456a5dede41ea390bed6bdf2fcef413c1e": "93f246e7afc53cd83b3d2595d734dc26",
".git/objects/pack/pack-737f7bbcee12038ffd4fa4337bf5a3aad814a5f4.idx": "faa3e1d5bd32c76049dd57437ce6c814",
".git/objects/pack/pack-737f7bbcee12038ffd4fa4337bf5a3aad814a5f4.pack": "e6bd69a7ae1683d2ff3dbacd252069b1",
".git/packed-refs": "668cce18657ad01cbcc88c44e71e29d3",
".git/refs/heads/master": "efddf72e8c4f860db686752e8a9789a9",
".git/refs/remotes/origin/HEAD": "73a00957034783b7b5c8294c54cd3e12",
".git/refs/remotes/origin/master": "efddf72e8c4f860db686752e8a9789a9",
"assets/asset/font/OpenSans/OpenSans-Bold.ttf": "1025a6e0fb0fa86f17f57cc82a6b9756",
"assets/asset/font/OpenSans/OpenSans-BoldItalic.ttf": "3a8113737b373d5bccd6f71d91408d16",
"assets/asset/font/OpenSans/OpenSans-ExtraBold.ttf": "fb7e3a294cb07a54605a8bb27f0cd528",
"assets/asset/font/OpenSans/OpenSans-ExtraBoldItalic.ttf": "a10effa3ed22bb89dd148e0018a7a761",
"assets/asset/font/OpenSans/OpenSans-Italic.ttf": "f6238deb7f40a7a03134c11fb63ad387",
"assets/asset/font/OpenSans/OpenSans-Light.ttf": "2d0bdc8df10dee036ca3bedf6f3647c6",
"assets/asset/font/OpenSans/OpenSans-LightItalic.ttf": "c147d1302b974387afd38590072e7294",
"assets/asset/font/OpenSans/OpenSans-Regular.ttf": "3ed9575dcc488c3e3a5bd66620bdf5a4",
"assets/asset/font/OpenSans/OpenSans-SemiBold.ttf": "ba5cde21eeea0d57ab7efefc99596cce",
"assets/asset/font/OpenSans/OpenSans-SemiBoldItalic.ttf": "4f04fe541ca8be9b60b500e911b75fb5",
"assets/asset/image/GDPR.png": "39a6140e28c8699d0b0ed265c3f820c9",
"assets/asset/image/HOME_SCREEN_LOGO.jpg": "807f4a727f75672907b4abcb600e7478",
"assets/asset/image/Icon-512.png": "c3453c18d8d22032685f83fb619459ac",
"assets/asset/image/LOGO_GMOVE.png": "9ae0dabd5ef19a4442ef11787bff164d",
"assets/asset/image/LOGO_NETCOM.png": "ceb71b56a70742c41d87e6000f5d5b08",
"assets/asset/image/LOGO_VODAFONE.png": "369b36dbe1727f6d33eadeb1fa0325c3",
"assets/asset/image/presenze_lagrange.jpeg": "38ed0de20696cf14d7a18a16ae4d1c01",
"assets/asset/image/presenze_tesla.jpeg": "afff3d071288f09aa0a88b5280e531f4",
"assets/asset/image/visitatori_corridoio.jpeg": "a6ac4cf78cee2742d4f13f476cd7569f",
"assets/asset/image/visitatori_hall.jpeg": "53cfee5f870cb3f3289e7cee5db7eb71",
"assets/asset/image/visitatori_pascal.jpeg": "cdc31d737c7884c7f503c15043cfe6c7",
"assets/asset/image/visitatori_Pinnhub.jpeg": "7e8b69533860caffa336ffb72297da07",
"assets/asset/license/Creator/LICENSE.txt": "a235303ed3d95b4710f807ac5c84f1a1",
"assets/asset/license/GDPR/DIALOG.txt": "fa9a2a037b6bccd4717f9a96834b1208",
"assets/asset/license/GDPR/LICENSE.txt": "f5e25d0f04946d3231fc88299f9a96b1",
"assets/asset/license/OpenSans/LICENSE.txt": "d273d63619c9aeaf15cdaf76422c4f87",
"assets/asset/map/italy.geojson": "0c5fe475abf2f263e3513051f9358e7b",
"assets/AssetManifest.json": "c6046e8c13e5d8594c266934798e483e",
"assets/FontManifest.json": "f27c68fa85393887e1043278dd20fb28",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "58a6c04bf8fa4c1b7e00c72a5d8e9f60",
"assets/packages/weather_icons/lib/fonts/weathericons-regular-webfont.ttf": "4618f0de2a818e7ad3fe880e0b74d04a",
"favicon.ico": "9c1b025fc22703f5980110e271fa565d",
"icons/Icon-192.png": "a3329f585ba953efb78d1e9c063f80c0",
"icons/Icon-512.png": "c3453c18d8d22032685f83fb619459ac",
"index.html": "d7a9246468afbbecb146df8da6873a7a",
"/": "d7a9246468afbbecb146df8da6873a7a",
"main.dart.js": "16397fd1e4216e3c8a0a1df4ccafca44",
"manifest.json": "56c7d9eacd8b5ed0a2365db9f00778b5",
"version.json": "9e9cb6affa3b38a92bd4b025a8074b4a"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
