# Passwd.

A beautiful, encrypted password manager, built using Flutter and Dart.

[Actual release](https://ci.rustzzdev.ru/)

## Features

- Fully encrypted using XSalsa20-Poly1305 (including the database stored on-device)
- Support for TOTP
- Secure Password Generation (Diceware and Random)
- A beautiful UI
- Really compact database, allowing for efficient disk operations (Thanks to MsgPack)
- Desktop Support (Linux is still untested, any contibutions on the same are welcome)
  - TouchBar support (Beta)
- Responsive UI (Kinda)
- Support for autofill on android (Beta)
- Cloud Sync (Highly Experimental)
  - See [Passwd Box](https://github.com/passwdapp/box) for the server
- Support for multiple languages (feel free to make an issue if you want to contribute)
  - English
  - Hindi
  - Dutch
  - Polish (not fully up to date)
  - Brazilian Portuguese
  - Russian

## Screenshots

Nothing is complete without screenshots :P

<p align="left">
  <img src="./screenshots/splash_new.png" height="440px" />
  <img src="./screenshots/pin_new.png" height="440px" />
  <img src="./screenshots/home_new.png" height="440px" />
  <img src="./screenshots/details.png" height="440px" />
  <img src="./screenshots/diceware.png" height="440px" />
  <img src="./screenshots/random.png" height="440px" />
  <img src="./screenshots/deletion_notice_new.png" height="440px" />
</p>

## Building

Check instructions in [.jenkins-pipeline](./.jenkins-pipeline)

## Changelog

See [CHANGELOG.md](./CHANGELOG.md)

## Contributors

See [CONTRIBUTORS.md](./CONTRIBUTORS.md).

## Roadmap

See [ROADMAP.md](./ROADMAP.md).
