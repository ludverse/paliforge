# paliforge

this tool makes any distro that uses apt declaritive, e.g. makes debian work become able to be configured similar to nixos, except it uses lua as config language

## why?

because, i liked nixos, but i felt out of control of what it was doing to my setup and it kept installing bloat. so i switched to debian which is solid as a rock, and made my own tool to make debian declarative.

## installation

### prerequisites

- the apt, and apt-get command
- `make`
- `lua5.4`
- a c compiler ig

```
sudo make
```

its not hard

## removal

```
sudo make clean
```

I often have problems with software that leave garbage around on my fs even after ive removed the software

I promise, this will delete everything that `sudo make` did

Note: any stuff in the config directory will not be removed obviously

## configuration

so ill probably make a more detailed guide later, but its configured using lua in `$HOME/.config/paliforge/config.lua`
