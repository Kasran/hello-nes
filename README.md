# nes devlog example project: episode 3

hi github! i'm writing a devlog/tutorial for making nes games [over on cohost][def]. follow along with me there if you want to keep an eye on what i'm doin for this

### what it does so far
it turns the screen white. that's it

### how to compile
this is gonna get a little twistier later on, but for now all you need to do is:
```
cl65 crt0.s main.s -t nes -o hello.nes
```
and then run the hello.nes rom in mesen or some other nes emulator

[def]: https://cohost.org/typhlosion/tagged/nes%20devlog