'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "67321ce95451f141f11cbc2260a84476",
"version.json": "009c9e65172e010890f7f65fde438006",
"index.html": "068706087670dd706ca39464c524d83e",
"/": "068706087670dd706ca39464c524d83e",
"main.dart.js": "4c09a0b2b145d1cf1bcba3a60e52bdf2",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"README.md": "fefe63f22c078f3ee3fb93a1486f978e",
"favicon.png": "a2a33432919cd920280d243b7db1d90c",
"icons/Icon-192.png": "a2a33432919cd920280d243b7db1d90c",
"icons/Icon-maskable-192.png": "a2a33432919cd920280d243b7db1d90c",
"icons/Icon-maskable-512.png": "a2a33432919cd920280d243b7db1d90c",
"icons/Icon-512.png": "a2a33432919cd920280d243b7db1d90c",
"manifest.json": "0ed92f01cd1d608aa5adf1c5e1e92c42",
".git/config": "e50409f46cf72edbdadf0d2b8a5694b3",
".git/objects/59/62efb2dffef4c259bda261b128fcab4b659c34": "11e1a7683fedc73b6a0da57ee3c6a112",
".git/objects/50/c4b4813c7f078b56a43b83b5317cc84b1ebb70": "0fee23879ef9a5d47a454b60dbee35ae",
".git/objects/9b/d3accc7e6a1485f4b1ddfbeeaae04e67e121d8": "784f8e1966649133f308f05f2d98214f",
".git/objects/93/3c047ba6543e7342b8a59a1c2ebe574eddef21": "266a2f28eefb38dbcf393745e469b7c2",
".git/objects/9d/0f0d101f7120cb47c030f8f0509b658996e191": "16e9aeb1ad623153a340dd3d35f85dfb",
".git/objects/a4/9e935686d483949804e5985603a8330d8ffd1d": "42cd22e89a739b4c394ce92b8615bb7f",
".git/objects/b2/9cd99df84e943ebc3c4d73d2b6ffdeb867c2b0": "00e6a0a80b2edf72b4afecc1e3b541bf",
".git/objects/d7/7cfefdbe249b8bf90ce8244ed8fc1732fe8f73": "9c0876641083076714600718b0dab097",
".git/objects/d0/8ae86456cca188e2365cf3d50575de7ecad888": "f541e13e63a0564f52f4a6afd30fd444",
".git/objects/a2/70048928b6fa8f0a827339e96dc3ffbdcce000": "3a079537a734d527c0f6b35383301cbd",
".git/objects/bc/57e5e845167d4651d1e28fd5377bc73c68a86c": "0da5c68ca4d2261c2d73c88b58af316b",
".git/objects/ee/e57ff2cbde2a70352a204fd2ba8e4558c555af": "43da9be29b665a43a812c87570527131",
".git/objects/ee/0e319c5539dbb17d9167d3b7194b5e1a963b42": "b8904b0dc33f998f23b01fa587059178",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f2/8c953037f941125d0b6327df5ff7d4779476c7": "8778a7d33201475953dbfb33214c07a7",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/e4/40081876df135f6d27f5cf764233f85ac6194b": "f62aaa149c5552e5da6461af2ba85e52",
".git/objects/c8/08fb85f7e1f0bf2055866aed144791a1409207": "92cdd8b3553e66b1f3185e40eb77684e",
".git/objects/fb/05504daaede9883fc893fabdd8a095d45f21e1": "d5b3001dad09fd1bf427ad30fa7e81da",
".git/objects/c1/05bb9f17e047d094dc208d032a471a9930a530": "d308ad0501c3b59d232e53ef288d4989",
".git/objects/ec/9382fabe42c497f2748dfc7e30312e34aab777": "11a60ea18150eebf38d77c10506cf955",
".git/objects/18/e516909c8f79557584c2ccf45f0cbab8f40982": "ad4b562bd1fd9d3e32c158adb756291d",
".git/objects/45/f2b0a85c4a164ed5430c5609d353c806b19bc7": "8901f9fb212460b436f384f93f57be99",
".git/objects/73/0b240135e9dad181b93117a5eac69c7713e9e5": "be0b61f586e7a06bd1e80d6486678cfc",
".git/objects/73/c63bcf89a317ff882ba74ecb132b01c374a66f": "6ae390f0843274091d1e2838d9399c51",
".git/objects/1a/d7683b343914430a62157ebf451b9b2aa95cac": "94fdc36a022769ae6a8c6c98e87b3452",
".git/objects/28/c61ff7698db1f0b2ebd932be5d726b4c7e5ed4": "dca610d3b611363df569b324f7dd727b",
".git/objects/17/8b3ba3a6bd99bbd8e5739b5eaf8afbf7e28241": "1511afe32d088f4346a4f402e79d9631",
".git/objects/86/35cb51d061a1867f5b74b19a96c690ea9c45fc": "046ddd94fc761b1ab87b2283b38525cc",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/31/1cf0e1a4760a45719db3bd8b43c37576f61b94": "c219b3e7bae4fe73cc1df70a1c79b744",
".git/objects/53/18a6956a86af56edbf5d2c8fdd654bcc943e88": "a686c83ba0910f09872b90fd86a98a8f",
".git/objects/53/3d2508cc1abb665366c7c8368963561d8c24e0": "4592c949830452e9c2bb87f305940304",
".git/objects/37/6fe21555dc8e3cb35e365a95a5478e021ddd21": "04baa2e9ece96a59be609a05f9573d8e",
".git/objects/08/37db8c2965592cbf0561e53adbce3608612b1a": "41050a1100fa7ce5fcb9d5772b0ae984",
".git/objects/39/69e78c777329aaee3a79e169b1087db5655e54": "e93a78904d656bea7b48dadddf0ed166",
".git/objects/97/23c6400087a6f968752a215e05bab995ea545a": "5ba26249703ee2631a667066e0f15b77",
".git/objects/97/b16933552218e13902ffc268e94d4380f19ff6": "3e41fe6685c0a4439dd85860b4e4b675",
".git/objects/0f/182c1a7977fda9a3ccf278be530dca38035941": "d3d116fa957569fe27b4a0974d2ea00e",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/dc/11fdb45a686de35a7f8c24f3ac5f134761b8a9": "761c08dfe3c67fe7f31a98f6e2be3c9c",
".git/objects/b6/a8eed39faf63c40a200533f354cf764c76b456": "b833110687f5e0157f7db8ca18d86b84",
".git/objects/d5/c33a3fbb4ab3087433079686a51d11dc6f114f": "f20e560268f999b1d99884896959f3de",
".git/objects/b7/41ac4c35f850efc52cff43341965f7cb56e4c4": "80ace6e74913df17f49db086e6ae13b1",
".git/objects/b7/fd57afe494f12e532e04c9e2ff853afb844fbb": "e882176eee73c2518453f51f4c32c3c9",
".git/objects/b9/6a5236065a6c0fb7193cb2bb2f538b2d7b4788": "4227e5e94459652d40710ef438055fe5",
".git/objects/c4/2765bf211e90b130b4897abf3c8dc5ee8ead42": "c09afafbc27eef0cf6399dcd6c87d99e",
".git/objects/c4/5992245552a6595181fb504fa7a26d1f0b1375": "d0b89db9a7389f0266d9f6186f1f62a4",
".git/objects/ea/2f5935fca201b6b963366b405014321c81af19": "98c6b9ac0f9ca2736f65eb3e2e6c7ef7",
".git/objects/e1/aa1b785a4d5740097d6895f05062b1026a21bf": "585f45e2deffd5e20ba2b50c5b05a2b8",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/f8/488343138aae52ad7448ef74fba6ddf5921a9c": "008688f0df5af01e0382e084156d7d34",
".git/objects/e0/7ac7b837115a3d31ed52874a73bd277791e6bf": "74ebcb23eb10724ed101c9ff99cfa39f",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/70/a234a3df0f8c93b4c4742536b997bf04980585": "d95736cd43d2676a49e58b0ee61c1fb9",
".git/objects/70/a3b3cfcb1bbcce1fa85a38a9332b6e6e371706": "43de2665fcf2b07e67725a1224a61a86",
".git/objects/12/9862ec867d2474c7fe65dfb06638eb9a789ff9": "206a9cfde1808c3bbbf833572dff5df5",
".git/objects/1d/916e096cd662e6f625bafd74c6e20939d381fc": "adbc301a720a2103a4b9925a7f93df9c",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "8230192e82c59cd8cb989e0148a3db76",
".git/logs/refs/heads/gh-pages": "8230192e82c59cd8cb989e0148a3db76",
".git/logs/refs/remotes/origin/gh-pages": "a5435acf1c42529632c6c304eed7702e",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/gh-pages": "11ab0f3d1b0aab966d47b38bf96ba239",
".git/refs/remotes/origin/gh-pages": "11ab0f3d1b0aab966d47b38bf96ba239",
".git/index": "b587c8546b813fc70b771969b2a51fa5",
".git/COMMIT_EDITMSG": "45c9eb7fa6e6a781268f8a3b8d62d8b9",
"assets/AssetManifest.json": "0049d3dc5b5cca0448a76764577eda83",
"assets/NOTICES": "dbc1cf56ba186e204d342b874d4e3db0",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "9fd1bbf68f4c10c056bc51ab726ce5b6",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "9218a37e5906f23de377f3f118166654",
"assets/fonts/MaterialIcons-Regular.otf": "7e16f0915501ceb4a957759a066e9fdd",
"assets/assets/images/mobile_coding.png": "8cfe0ea01637dcd0d6987115e87b9863",
"assets/assets/images/about_me.png": "a6011a3c6dd53b10495bf719c21ad343",
"assets/assets/images/home.png": "6846c25db1e174833ec086a565691cdc",
"assets/assets/icons/visual_studio_code_icon.png": "46d0b9a6884215ce1eee7f9ef235bc66",
"assets/assets/icons/firebase_icon.png": "c4bea424d0684abdef5051bd29c5cb14",
"assets/assets/icons/git.png": "5b2255699fcb506b570720cdbc8ade1b",
"assets/assets/icons/gmail_icon.png": "6d464e088afbd327044ffb75d917a597",
"assets/assets/icons/linkedin_icon.png": "1bd9393274cf845f18dd14e465871a1a",
"assets/assets/icons/fastlane_icon.png": "c526b6d33ce575400d528510d53d2cdb",
"assets/assets/icons/flutter_icon.png": "55043bf8b1aaa1266070c79286425fa4",
"assets/assets/icons/postgresql.png": "52231567c0fbe562894dc4e2d1c41fb5",
"assets/assets/icons/mysql.png": "2020e22050def67c1b77794df10e4faa",
"assets/assets/icons/android_studio_icon.png": "47fa39f297d9144e74ccd7addcb273d8",
"assets/assets/icons/swift_icon.png": "2ea5f97896d35269f2fab70fd10cf80a",
"assets/assets/icons/xcode_icon.png": "0911121b529a23028ff23c86127871b4",
"assets/assets/icons/aws_icon.png": "091f24e7a003365ef31b8e9074decd49",
"assets/assets/icons/github_icon.png": "b37b05a713d8eebcbb475119e587859b",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
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
