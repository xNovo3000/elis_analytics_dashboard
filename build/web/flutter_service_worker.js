'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
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
"index.html": "7b7946dfda5e2a42e1296e9eadaad1a5",
"/": "7b7946dfda5e2a42e1296e9eadaad1a5",
"main.dart.js": "16397fd1e4216e3c8a0a1df4ccafca44",
"manifest.json": "56c7d9eacd8b5ed0a2365db9f00778b5",
"version.json": "44edf6fd56642a81f10ee4e2c796a782"
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
