Yet another simple package manager, not powerful at all.

Install
-------

### via `make`

```sh
git clone https://github.com/weakish/wkg
cd wkg
make
```

This will install `wkg` to `/usr/local/bin/`.
Edit `config.mk` to install to other path.

The Makefile is compatible with both GNU make and BSD make.

### via `wkg` itself

```sh
wkg add weakish/wkg
```

Uninstall
---------

If installed with `make`:

```sh
make uninstall
```

If installed with `wkg`:

```sh
wkg rm weakish/wkg
```

Usage
-----

Run `wkg help`.

Packages
--------

Packages are simply git repositories (`username/repo`).
You may also specify a site (`site/username/repo`).

Currently only the following sites are supported:

- gh (github)

The following sites may be supported in future:

- bb (BitBucket)
- notabug
- gitlab
- try.gogs.io
- coding (coding.net)

Pull requests for new sites are welcome.

All repositories must contain a `Makefile` with `install` and `uninstall` action.
They may contain an optional `config.mk` file to specify installation `PREFIX` (currently unused).

### Fallback packages

Unimplemented yet.

There are also fallback packages `package-name-without-slashes`.
The installation of these packages are delegated to system package managers.

Currently supported system:

- FreeBSD (pkg)
- NetBSD (pkgsrc)
- Mac OS X (pkgsrc)
- Windows (Chocolatey)
- msys2 (pacman)
- Devuan/Debian/Ubuntu/Mint (apt)
- Arch (pacman)		
- Slackware (slapt-get)
- Alpine (apkg)
- Void (xbps)
