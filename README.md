# Wikia Demo
Novel architectural attempt for iOS apps

## Motivation and rationale

The code consists of custom Rx microframeworks for some common iOS programming tasks. Their names simply remind mechanisms observable in nature at great scale:

🌩 RxStorm - REST API networking client  
🌪 RxCyclone -  machine state container  
⛲️ RxCascade - paginable feed  
🧭 RxNavy - navigation through segues  
🛳 RxSinkEmAll - retriable error handler

Frameworks need further work in order to reach independent open source status.

## Proof of concept

The application main view shows a list of wikis leading to detailed wiki view and website view.

Each view controller is powered by **machine state** (aka redux store) and **events** residing inside it's **cyclone** (aka view model). Cyclone manages inputs and all necessary dependencies in order to achieve business logic goals. All necessary data is fetched from API, decoded from JSON to the thin model, spread by **data pool** (aka repository) and then transformed to UI model.

Navigation, for now, is done by intercepting storyboard segues and injecting necessary data to the input of destination cyclone.
