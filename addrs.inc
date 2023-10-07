PPU_CTRL     = $2000  ; miscellaneous PPU-related flags
PPU_MASK     = $2001  ; for controlling which stuff the PPU draws
PPU_STATUS     = $2002  ; for figuring out how the PPU is doing
PPU_OAM_ADDR = $2003  ; OAM is object attribute memory, where sprite info lives
PPU_OAM_DATA = $2004
PPU_SCROLL     = $2005  ; for controlling the screen scroll
PPU_ADDR     = $2006
PPU_DATA     = $2007
PPU_OAM_DMA     = $4014  ; DMA is a way to copy a bunch of data into the OAM fast

APU_FRAMECNT = $4017  ; APU frame counter
APU_DMC_FREQ     = $4010  ; APU DMC (it has to do with sample playback)

CTRL_PORT1     = $4016  ; for reading controller data
CTRL_PORT2     = $4017