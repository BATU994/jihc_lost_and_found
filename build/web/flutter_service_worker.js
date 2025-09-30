'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "a8297d555dd34879e8e48e1cf12acefa",
".git/config": "e57a0d5c3cbff0126bea437f99bbcac8",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "26252203f22e0f4b05e3dc2d976b88e4",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "3f4e8b654265cf56169e6bb9e9ad7269",
".git/logs/refs/heads/main": "cd6e097acaad6ac8dd7984d284d26d4a",
".git/logs/refs/remotes/origin/main": "7627152fe251226e40bfa7088beaf91b",
".git/objects/02/1d4f3579879a4ac147edbbd8ac2d91e2bc7323": "9e9721befbee4797263ad5370cd904ff",
".git/objects/0c/2343cb8d1745d48059df627412130adf43d2b3": "a6f9626aedd0bec75fdda38571c4db3c",
".git/objects/10/273439ef8f4bb40149413442dff73aa77710f7": "69514591c0106144781492bd61b405b0",
".git/objects/12/eb2aeda5afa9e8a5e3fcc5a5af5b9f86be2a2a": "6205fd41f8277329668d421d75b99a0b",
".git/objects/20/3a3ff5cc524ede7e585dff54454bd63a1b0f36": "4b23a88a964550066839c18c1b5c461e",
".git/objects/29/f22f56f0c9903bf90b2a78ef505b36d89a9725": "e85914d97d264694217ae7558d414e81",
".git/objects/2e/9612f3cc3077454693bf8de03c70ffc65f8f7c": "6cbe6d8c68d95e41e71d44ed2ad05a23",
".git/objects/38/bd26ba75c7112c1d8741e8e70cae1e75ed5c43": "07871047c2d0eb1d8cac9cded77f9cb8",
".git/objects/44/dbeb9785b1620b6d756f5e9c5d0e8c4436f173": "dd8572d2745cc47de6ae309bd7ef5dc0",
".git/objects/45/90129c802a492860d0a7420626c4e8e771c6f8": "871e1f88c3eb3282e7a5d6c6a4a4154d",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/4d/bf9da7bcce5387354fe394985b98ebae39df43": "534c022f4a0845274cbd61ff6c9c9c33",
".git/objects/4f/af2211ddfd506a1c4787c85852d1bc3f5669c2": "71f4ffeea96ec24e4e2d31c2021c05a5",
".git/objects/4f/fbe6ec4693664cb4ff395edf3d949bd4607391": "2beb9ca6c799e0ff64e0ad79f9e55e69",
".git/objects/51/a3ba37b77f45c5337d817e480bf577118a4499": "c55a667f4c8134022ae49c2623238971",
".git/objects/57/a01416f3d1e150f6fa9e1159447c8392fc4cee": "b8b2326a215fca4044fe10c268e5f1cf",
".git/objects/62/40956628bd13b799749346e6014aebf645280d": "4c663b6353d37b53dcfbd8bacab91b44",
".git/objects/65/3c10a9130192b9433d8bcbd1bfc5c05ff2f400": "a98eadf8b083fa48e5094464576607c0",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/7a/6c1911dddaea52e2dbffc15e45e428ec9a9915": "f1dee6885dc6f71f357a8e825bda0286",
".git/objects/83/ed97739a6ba149075e13a4325555c26ddbb79c": "bcf72ef9c399ba0eb181101ab3437f33",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8e/8550b28c567027afba9012b90d48993be84c94": "6e92d883b5ac08f177aaa59bdb5c106f",
".git/objects/90/73eb04589aa09831098b6fd71d3afc20d4f0c6": "192f68a9d56b466ee95ef2d555fa9876",
".git/objects/98/0d49437042d93ffa850a60d02cef584a35a85c": "8e18e4c1b6c83800103ff097cc222444",
".git/objects/98/7cb5766a66af104f2313dd39aa1eff9107c78d": "dc4c8e211c7aa21815b65d35feae17c7",
".git/objects/9b/3ef5f169177a64f91eafe11e52b58c60db3df2": "91d370e4f73d42e0a622f3e44af9e7b1",
".git/objects/9c/2aec1c97eae430f430f0bbcb5a62e41c5bf5f6": "507c329a3052ca85484705d45958d9cd",
".git/objects/9e/013506d822e929177a9c9cea191a5fc9e99c3d": "1c0cafe9627a3685de7c2e9fce4155e2",
".git/objects/9e/3b4630b3b8461ff43c272714e00bb47942263e": "accf36d08c0545fa02199021e5902d52",
".git/objects/a6/8dc3e848f6ef6e2fe08978e857f30442a5b2e2": "479db9f0e04e2b07a448aab4b519d48d",
".git/objects/b6/b8806f5f9d33389d53c2868e6ea1aca7445229": "b14016efdbcda10804235f3a45562bbf",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/c4/016f7d68c0d70816a0c784867168ffa8f419e1": "fdf8b8a8484741e7a3a558ed9d22f21d",
".git/objects/ca/3bba02c77c467ef18cffe2d4c857e003ad6d5d": "316e3d817e75cf7b1fd9b0226c088a43",
".git/objects/ca/733ea9ebcb46e460599869b726623e45094c19": "9cb7e44cc2a4a05bb4272a75b61465dc",
".git/objects/d1/79a438217083779f14536cb1617557548dcf19": "e14a0d0c7b4831093f579b2a4b1be3c8",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d7/7cfefdbe249b8bf90ce8244ed8fc1732fe8f73": "9c0876641083076714600718b0dab097",
".git/objects/d9/78fdc89907e0f9874bb88cc56a5b49884e56c7": "060ab878a9a4dd1a13529edad08b7959",
".git/objects/de/e67ff06531bd8549ef58c19bf3752a99b23d10": "2d2a70be6a399067255dcfe3472e66a8",
".git/objects/e0/714f49534624b541d6135bb8f0c37e2ac6a1e8": "8a1e866a49c0be860ef40b346b380db8",
".git/objects/e2/b11039e4fabff7e65b6dadbcbbd1690bdf04d3": "56662a5a963d50e195a97c28d857760f",
".git/objects/e3/e9ee754c75ae07cc3d19f9b8c1e656cc4946a1": "14066365125dcce5aec8eb1454f0d127",
".git/objects/e6/360488f32c4280fd7ae1b9efe0736aeb1692d8": "8581fd0f3d226ae27adeb55b97727210",
".git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391": "c70c34cbeefd40e7c0149b7a0c2c64c2",
".git/objects/e8/99ea07f439196f791d549a3b375ccad15d8cca": "0b9fb0e1f48be22e8cbd4c5024be903c",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ed/b55d4deb8363b6afa65df71d1f9fd8c7787f22": "886ebb77561ff26a755e09883903891d",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f3/993a74a380d1f00e68c9fddfeaba3fae572f01": "6cfb6dd4d7beb0c37127dccbe7eecd40",
".git/objects/f5/3ebb028d24d38ef0ee7c6cbec8c062c70df13e": "8d80a6ebc56ea1948c9d5eb2e2ae5c60",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/fd/5e944da29624cdc580bc124fb8a1b753c3c75e": "741cf9eb8c3afda7559587e62ac79578",
".git/objects/fe/3b987e61ed346808d9aa023ce3073530ad7426": "dc7db10bf25046b27091222383ede515",
".git/refs/heads/main": "32145361bd851ed64bd76893ab3b1ac4",
".git/refs/remotes/origin/main": "32145361bd851ed64bd76893ab3b1ac4",
"assets/AssetManifest.bin": "71af754374acd90bdf2b74a9474fa4a3",
"assets/AssetManifest.bin.json": "d7740f3931e0298c4cb4c00bb62fa3b0",
"assets/AssetManifest.json": "1602062826fd94713bbfbb800ea18c1e",
"assets/assets/chat.svg": "bee573c27055e9531179d3772615d4c6",
"assets/assets/google_logo.png": "1888a63d59c4719fb3e84d9254a29504",
"assets/assets/home.svg": "8af025e74ef46158a34fea2c8da51294",
"assets/assets/items.json": "997712ce32bcbe8555857b62a05c0151",
"assets/assets/jihc_logo.png": "aa5006f721f9bf3559f9ac36c7e66f0a",
"assets/assets/jihc_logo.svg": "a97e5696aaf339f0512664998dc59def",
"assets/assets/post.svg": "8cbe4814d76eeb26ccbe67bc1a03d793",
"assets/assets/profile.svg": "31e9500bf7b167c5d6f49ba15b902cf2",
"assets/assets/rectangle_layOut.svg": "1cbae22c5a60575054b4c6ff1374dfaa",
"assets/assets/rectangle_layOut_act.svg": "b0bf7ad475416eaf937f711258193776",
"assets/assets/search.svg": "a148cb4e26bcf694fc1a3671dcd97c4a",
"assets/assets/square_layOut.svg": "cd75ff55e023ce80e5962cb0952d1ee5",
"assets/assets/square_layOut_act.svg": "47af22c6155e0515a8153f082e2988e4",
"assets/assets/users.json": "d41d8cd98f00b204e9800998ecf8427e",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "406f6a017399cd089350a7fdbafe4d45",
"assets/NOTICES": "b14d57b22e9d100ef9f72457103f1858",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "3e45aa6e470a2622ef5d026bf16c9070",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "59face4188458145f810804f5d3c2481",
"/": "59face4188458145f810804f5d3c2481",
"main.dart.js": "7cbaf2bce7f8aea133d8d4b8c289bba4",
"manifest.json": "ada963c95f1bbb0847fe5da621051b86",
"version.json": "a91567d6f29c2c83ead7686de9db525c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
