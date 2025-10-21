'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "0dc4eeacb5bf5b800a236e5505854bc7",
"assets/AssetManifest.bin.json": "1d0ed700132b88d33edb6dd2831b3c46",
"assets/AssetManifest.json": "a9c65f42f6ddb625fe5f554900c881d4",
"assets/assets/images/1989.jpg": "3e98ea91795dac417051ad4d87032113",
"assets/assets/images/2112.jpg": "99d2005d85bc104a6f4890d05fa798e8",
"assets/assets/images/25.jpg": "1042d57212f7ff05b7caaa21cf17f5ff",
"assets/assets/images/A%2520Love%2520Supreme.jpg": "bd97b422ee59a93b3dbc60cc7ba1c6d0",
"assets/assets/images/Abbey%2520Road.jpg": "9324bfc5d3bc383b4fa66d76e9b2d92d",
"assets/assets/images/Appetite%2520for%2520Destruction.jpg": "bb651e8040e6be913c300d6eb175969c",
"assets/assets/images/Arrival.jpg": "9a0410231709704bd806c0a31c4d7095",
"assets/assets/images/Back%2520in%2520Black.jpg": "d5ba01fe43546f103d9daaad9b3189df",
"assets/assets/images/Close%2520to%2520the%2520Edge.jpg": "9a645c2501eb4bc8ddacab84c7d7bda5",
"assets/assets/images/Core.jpg": "bd45c4eaa155acbf9e832309ff6d8a9b",
"assets/assets/images/Dirt.jpg": "7ff786376499ea8a886ce9e7eea26ba8",
"assets/assets/images/Discovery.jpg": "b6e2905292dad8bdb6bfb22b4db18f7e",
"assets/assets/images/Exile%2520on%2520Main%2520St.jpg": "ea7b2c7a1deecc13b44654af6a4cc931",
"assets/assets/images/Head%2520Hunters.jpg": "cf6079392a940c26b3bbe7f6cbba753a",
"assets/assets/images/In%2520the%2520Court%2520of%2520the%2520Crimson%2520King.jpg": "bdc77bb1cb7a1a9666ed289fc70a5f37",
"assets/assets/images/Kind%2520of%2520Blue.jpg": "f7f0f6911133b1003732ab1a943253c6",
"assets/assets/images/Like%2520a%2520Prayer.jpg": "206d254ea6aaab5b017218862804dda2",
"assets/assets/images/logo.png": "b8181c432295ca6d589e73719379a28e",
"assets/assets/images/Machine%2520Head.jpg": "31f18dde3ef3d584a491faa4314d2384",
"assets/assets/images/Mezzanine.jpg": "0bbdea336423732a388da96bc3acbab2",
"assets/assets/images/Mingus%2520Ah%2520Um.jpg": "dd0dd8d244023597e4f300036eecc70b",
"assets/assets/images/Nevermind.jpg": "368f86180eafc6300de7c31c93e8bbf7",
"assets/assets/images/Paranoid.jpg": "68f9b59d37aa7cde917993fc56ce5dee",
"assets/assets/images/Pepper.jpg": "37023ddec33942feab83e6f5c76cdae9",
"assets/assets/images/Qris.jpg": "8ab559bb8b827cd40bc5f6a284f14b18",
"assets/assets/images/Rumours.jpg": "6a1f24737bb315a02b282941c20b6183",
"assets/assets/images/Selected%2520Ambient%2520Works.jpg": "f236a6e30dc2f8455626509fc0490f54",
"assets/assets/images/Selling%2520England%2520by%2520the%2520Pound.jpg": "7d7cce29f7c8f0b4a44f9727c517b7d4",
"assets/assets/images/Superunknown.jpg": "a0196e210a9435ccf2717cd675315532",
"assets/assets/images/Ten.jpg": "725b154bb0601344ed9bef58adbcd9b2",
"assets/assets/images/The%2520Dark%2520Side%2520of%2520the%2520Moon.jpg": "88b37aff4ff72954c935cc0864e70741",
"assets/assets/images/The%2520Fat%2520of%2520the%2520Land.jpg": "275ba3cef0e7b73fe68743acebd58037",
"assets/assets/images/Thriller.jpg": "71ac33c11d4afdf582665af76e4a4529",
"assets/assets/images/Time%2520Out.jpg": "911df3787245c48ba0824efe7dd2738b",
"assets/assets/images/Untitled.jpg": "1318031b40b102454f6c264ecd53b5c2",
"assets/assets/images/Van%2520Halen.jpg": "348c918eec9c18291baf8b69bd17d433",
"assets/assets/images/velvetundergroundnico.jpg": "702fb881a4984cd4e0410e5244f24301",
"assets/assets/images/Whos%2520Next.jpg": "d18faade80b5303cb4952f024c4e86ac",
"assets/FontManifest.json": "c75f7af11fb9919e042ad2ee704db319",
"assets/fonts/MaterialIcons-Regular.otf": "c8e137b04d10f90879b760f8a8ad5413",
"assets/NOTICES": "58ad4dfc125367c39808ec746144b36c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Brands-Regular-400.otf": "9ece1af9708894a468d85c10830b0bd0",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Regular-400.otf": "43ef70816034a943040c0a8f3343846a",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Solid-900.otf": "2229270c61321a713d0f36ef9ecd93bd",
"assets/packages/getwidget/icons/dribble.png": "1e36936e4411f32b0e28fd8335495647",
"assets/packages/getwidget/icons/facebook.png": "293dc099a89c74ae34a028b1ecd2c1f0",
"assets/packages/getwidget/icons/google.png": "596c5544c21e9d6cb02b0768f60f589a",
"assets/packages/getwidget/icons/line.png": "da8d1b531d8189396d68dfcd8cb37a79",
"assets/packages/getwidget/icons/linkedin.png": "822742104a63a720313f6a14d3134f61",
"assets/packages/getwidget/icons/pinterest.png": "d52ccb1e2a8277e4c37b27b234c9f931",
"assets/packages/getwidget/icons/slack.png": "19155b848beeb39c1ffcf743608e2fde",
"assets/packages/getwidget/icons/twitter.png": "caee56343a870ebd76a090642d838139",
"assets/packages/getwidget/icons/wechat.png": "ba10e8b2421bde565e50dfabc202feb7",
"assets/packages/getwidget/icons/whatsapp.png": "30632e569686a4b84cc68169fb9ce2e1",
"assets/packages/getwidget/icons/youtube.png": "1bfda73ab724ad40eb8601f1e7dbc1b9",
"assets/packages/sign_in_button/assets/logos/2.0x/facebook_new.png": "dd8e500c6d946b0f7c24eb8b94b1ea8c",
"assets/packages/sign_in_button/assets/logos/2.0x/google_dark.png": "68d675bc88e8b2a9079fdfb632a974aa",
"assets/packages/sign_in_button/assets/logos/2.0x/google_light.png": "1f00e2bbc0c16b9e956bafeddebe7bf2",
"assets/packages/sign_in_button/assets/logos/3.0x/facebook_new.png": "689ce8e0056bb542425547325ce690ba",
"assets/packages/sign_in_button/assets/logos/3.0x/google_dark.png": "c75b35db06cb33eb7c52af696026d299",
"assets/packages/sign_in_button/assets/logos/3.0x/google_light.png": "3aeb09c8261211cfc16ac080a555c43c",
"assets/packages/sign_in_button/assets/logos/facebook_new.png": "93cb650d10a738a579b093556d4341be",
"assets/packages/sign_in_button/assets/logos/google_dark.png": "d18b748c2edbc5c4e3bc221a1ec64438",
"assets/packages/sign_in_button/assets/logos/google_light.png": "f71e2d0b0a2bc7d1d8ab757194a02cac",
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
"flutter_bootstrap.js": "794b24009158cbd99e253ba61e6a5d4f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "8822823f1d1552c97471006f2a25bc7b",
"/": "8822823f1d1552c97471006f2a25bc7b",
"main.dart.js": "7c99f2f38067855674019f5b7392261b",
"manifest.json": "f7c1ada9fe24ac59c4433d9a22a0b734",
"version.json": "f64b199673598bc0fd9adea9b68f6b18"};
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
