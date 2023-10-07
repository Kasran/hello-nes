.include "addrs.inc"

; .export _main

.segment "CODE"
_main:
    ; lets try to set background color (in this case white is $30)
    ldx #$3f
    ldy #$00
    stx PPU_ADDR  ; write $3f00 to the PPU address register
    sty PPU_ADDR  ; i.e. the VRAM address we're gonna change is at $3f00
    lda #$30
    sta PPU_DATA  ; write $30 to the PPU data register (white)

    lda #%00011000  ; turn on bg and sprite rendering
    sta PPU_MASK    ; so we can see the change
:
    jmp :-  ; loop forever