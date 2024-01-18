impossible stuff day project

- first to unblock, follow hello gleam on fly: https://gleam.run/deployment/fly/
- first issue, need to update gleam

```
The package gleeunit requires a Gleam version satisfying >= 0.33.0 but you are using v0.32.4.
```

- how do I update gleam? looked for the command in release notes, not found
- I think it is installation dependent. In my case: `brew upgrade gleam` (after running `brew update`)
- wow it has a lot of dependencies! (Upgrading 20 dependents of upgraded formulae). numpy, libsodium, mpdecimal, imagemagick, also upgrading python! Hey but no, this is all due to brew and I can disable it (but having it by default on is... mmmh, maybe it is good, do not know)
- anyway, now I do not have anymore issues.