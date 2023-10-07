.include "addrs.inc"

; imports and exports go here
; .import _main

.segment "HEADER"  ; 16-byte iNES header
ines_header:       ; you need it for an emulator to recognize the file
    .byte $4e, $45, $53, $1a  ; "NES" and then ms-dos eof character
    .byte $02                 ; size of prg rom (x 16kb)
    .byte $01                 ; size of chr rom (x 8kb)
    .byte $00                 ; flags 6
    .byte $00                 ; flags 7
    .byte $00                 ; flags 8
    .byte $00                 ; flags 9
    .byte $00                 ; flags 10
    .res 5, $00               ; five bytes of zero padding

.segment "STARTUP"  ; cc65 puts startup-related code here when building from C
startup:
    sei  ; disable IRQ
    cld  ; clear decimal mode (the 2a03 doesn't *have* a decimal mode but it's good practice)
    ldx #$40
    stx APU_FRAMECNT  ; disable APU frame IRQ
    ldx #$ff
    txs        ; Set up stack
    inx        ; now X = 0
    stx PPU_CTRL  ; disable NMI
    stx PPU_MASK  ; disable rendering
    stx APU_DMC_FREQ  ; disable DMC IRQs

    ; if we were using a mapper, this is where we would set it up

    bit PPU_STATUS  ; reading from $2002 here clears the vblank flag if it was set

@vblankwait1:  ; first of two vblank waits. these are here to make sure the PPU is stable
    bit PPU_STATUS
    bpl @vblankwait1

    ; We now have about 30,000 cycles to burn before the PPU stabilizes.
    ; One thing we can do with this time is put RAM in a known state.
    ; Here we fill it with $00, which matches what (say) a C compiler
    ; expects for BSS.  Conveniently, X is still 0.
    txa
@clrmem:
    sta $000,x
    sta $100,x
    sta $200,x
    sta $300,x
    sta $400,x
    sta $500,x
    sta $600,x
    sta $700,x
    inx
    bne @clrmem

    ; Other things you can do between vblank waits are set up audio
    ; or set up other mapper registers.
   
@vblankwait2:
    bit PPU_STATUS
    bpl @vblankwait2

    jmp _main

nmi:
irq:
    rti

; ...

.segment "VECTORS"  ; the 6502 looks here to figure out where to jump to when certain things happen 
rom_vectors:
    .word nmi    ; nmi vector
    .word startup  ; reset vector
    .word irq    ; irq/brk vector

.segment "CHARS"  ; 8kb (0x2000 bytes) of character (graphics) data
chars:
    .res $2000, $00