'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "43828eea4a5446fbe5b2206425860a8c",
"version.json": "009c9e65172e010890f7f65fde438006",
"index.html": "5b1aa18857128c4bdf1934fe3a922ce8",
"/": "5b1aa18857128c4bdf1934fe3a922ce8",
"main.dart.js": "5fece401ff92d4cb786094a514438ed3",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"README.md": "fefe63f22c078f3ee3fb93a1486f978e",
"favicon.png": "a2a33432919cd920280d243b7db1d90c",
"icons/Icon-192.png": "a2a33432919cd920280d243b7db1d90c",
"icons/Icon-maskable-192.png": "a2a33432919cd920280d243b7db1d90c",
"icons/Icon-maskable-512.png": "a2a33432919cd920280d243b7db1d90c",
"icons/Icon-512.png": "a2a33432919cd920280d243b7db1d90c",
"manifest.json": "0ed92f01cd1d608aa5adf1c5e1e92c42",
"assets/AssetManifest.json": "9a718831045dbe12b850923d6ef81c53",
"assets/NOTICES": "32b95e95e17bc4ad938a229a681b69e4",
"assets/FontManifest.json": "c499749bd27151880143f7abc6a010a5",
"assets/AssetManifest.bin.json": "3fa727a4b6921b4703af89da85f99d5f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/Font%2520Awesome%25207%2520Free-Solid-900.otf": "e151d7a6f42f17e9ea335c91d07b3739",
"assets/packages/font_awesome_flutter/lib/fonts/Font%2520Awesome%25207%2520Free-Regular-400.otf": "df86a1976d76bd04cf3fcaf5add2dd0f",
"assets/packages/font_awesome_flutter/lib/fonts/Font%2520Awesome%25207%2520Brands-Regular-400.otf": "58dafdb7e56677d71ea619f270f5c820",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "0d8068c04ee48c6a0afc1669023d2f45",
"assets/fonts/MaterialIcons-Regular.otf": "4beba451a80bda2af3965b16ad6d963f",
"assets/assets/images/about_me.png": "5422e2096f5f05aff270dc7b6e656f8e",
"assets/assets/images/home.png": "1e06295e76392b96cf766f701fc01aa2",
"assets/assets/icons/visual_studio_code_icon.png": "71033b864ec54e0f8357de1c50990d0d",
"assets/assets/icons/firebase_icon.png": "0574a03af5dce7c4b00f4d035e756951",
"assets/assets/icons/git.png": "bf5d867312a91a1aa33a7fb6f5d3db6b",
"assets/assets/icons/gmail_icon.png": "a637f37b892621b24a4502740da0fbfc",
"assets/assets/icons/linkedin_icon.png": "854d61c8e9389bdf2aa2b419b9badcf5",
"assets/assets/icons/fastlane_icon.png": "46a1d18ed6f400412cfded49e785087c",
"assets/assets/icons/flutter_icon.png": "8d91d7e64c0fad6fbefac02b94968dd3",
"assets/assets/icons/postgresql.png": "346a3b37ca9e71d1cfcefe3ba5e231bb",
"assets/assets/icons/mysql.png": "759df09364c451e64c1d76996b6e4940",
"assets/assets/icons/react.png": "6217193e2120f462934c20423ac14139",
"assets/assets/icons/postman.png": "b9b9c51cd1d7bfc7a53139880445dab0",
"assets/assets/icons/android_studio_icon.png": "06ab8e8d6da356467085f3c24a27a0cf",
"assets/assets/icons/swiftui.png": "d156cf1f6af9c31c14435fa149ac7d15",
"assets/assets/icons/swift_icon.png": "e00d14246a29c8d13fdc92db38209f0f",
"assets/assets/icons/xcode_icon.png": "82620c23e657da703f5f0179526fdd33",
"assets/assets/icons/aws_icon.png": "b1a83121f4592f602c6e55f6d7219035",
"assets/assets/icons/github_icon.png": "84865efa48df36c6433d9dd2f2a82eea",
"assets/assets/fonts/NotoSansJP-Bold.ttf": "485e5ded4ecbe334b90b239f662c968b",
"assets/assets/fonts/NotoSansThai-Regular.ttf": "427671697e1a490b1e0015e2d7eb4653",
"assets/assets/fonts/RobotoCondensed-Bold.ttf": "202c1be912f2a6bce818bbae9961917a",
"assets/assets/fonts/Bungee-Regular.ttf": "2ff657685f7890df4950b68f55691e28",
"assets/assets/fonts/Mulish-Regular.ttf": "77f8944e5a3366e1840f14d9391fb886",
"assets/assets/fonts/NotoSansThai-Bold.ttf": "41916065aee5eae670ae746bea86426f",
"assets/assets/fonts/BebasNeue-Regular.ttf": "b2b293064f557c41411aac04d6f6710d",
"assets/assets/fonts/NotoSansJP-Regular.ttf": "d7b3c0ac56050de4c152bd8394a16c9a",
"assets/assets/fonts/Mulish-Bold.ttf": "146da79a7bbf3dad6d6621986cfb20b0",
"assets/assets/fonts/RobotoCondensed-Regular.ttf": "68297c594eb0b804f02ca8ba0918b98f",
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
