;;;;;;;;;;;;;;;;;;;;;;
;
; ON/OFF Switch Cooldown
; So Mario doesn't quintuple toggle it underwater
;  by leod
;
;;;;;;;;;;;;;;;;;;;;;;

;;;;;
; Defines
;;;;;

!Cooldown = $04
; How many frames the ON/OFF block stays inactive after being hit



;;;;;
; Freeram
;;;;;

!CooldownTimer = $18F6
; 1 byte, timer byte





;;;;;
; Address ranges and sprite tables for SA-1 hybrid
;;;;;

!bank	 = $800000
!addr	 = $0000
!dp	 = $0000

!9E	 = $9E
!AA	 = $AA
!B6	 = $B6
!C2	 = $C2
!D8	 = $D8
!E4	 = $E4
!14C8	 = $14C8
!14D4	 = $14D4
!14E0	 = $14E0
!14EC	 = $14EC
!14F8	 = $14F8
!1504	 = $1504
!1510	 = $1510
!151C	 = $151C
!1528	 = $1528
!1534	 = $1534
!1540	 = $1540
!154C	 = $154C
!1558	 = $1558
!1564	 = $1564
!1570	 = $1570
!157C	 = $157C
!1588	 = $1588
!1594	 = $1594
!15A0	 = $15A0
!15AC	 = $15AC
!15B8	 = $15B8
!15C4	 = $15C4
!15D0	 = $15D0
!15DC	 = $15DC
!15EA	 = $15EA
!15F6	 = $15F6
!1602	 = $1602
!160E	 = $160E
!161A	 = $161A
!1626	 = $1626
!1632	 = $1632
!163E	 = $163E
!164A	 = $164A
!1656	 = $1656
!1662	 = $1662
!166E	 = $166E
!167A	 = $167A
!1686	 = $1686
!186C	 = $186C
!187B	 = $187B
!190F	 = $190F
!1FD6	 = $1FD6
!1FE2	 = $1FE2

!SpriteTableSize = 12


; SA-1 detection and support
if read1($00FFD5) == $23
	sa1rom
	
	!bank	 = $000000
	!addr	 = $6000
	!dp	 = $3000
	
	!9E	 = $3200
	!AA	 = $9E
	!B6	 = $B6
	!C2	 = $D8
	!D8	 = $3216
	!E4	 = $322C
	!14C8	 = $3242
	!14D4	 = $3258
	!14E0	 = $326E
	!14EC	 = $74C8
	!14F8	 = $74DE
	!1504	 = $74F4
	!1510	 = $750A
	!151C	 = $3284
	!1528	 = $329A
	!1534	 = $32B0
	!1540	 = $32C6
	!154C	 = $32DC
	!1558	 = $32F2
	!1564	 = $3308
	!1570	 = $331E
	!157C	 = $3334
	!1588	 = $334A
	!1594	 = $3360
	!15A0	 = $3376
	!15AC	 = $338C
	!15B8	 = $7520
	!15C4	 = $7536
	!15D0	 = $754C
	!15DC	 = $7562
	!15EA	 = $33A2
	!15F6	 = $33B8
	!1602	 = $33CE
	!160E	 = $33E4
	!161A	 = $7578
	!1626	 = $758E
	!1632	 = $75A4
	!163E	 = $33FA
	!164A	 = $75BA
	!1656	 = $75D0
	!1662	 = $75EA
	!166E	 = $7600
	!167A	 = $7616
	!1686	 = $762C
	!186C	 = $7642
	!187B	 = $3410
	!190F	 = $7658
	!1FD6	 = $766E
	!1FE2	 = $7FD6
	
	!SpriteTableSize = 22
endif

!CooldownTimerFinal = !CooldownTimer+!addr






; Play ON/OFF Sound Routine hijack
org $02881E
autoclean JSL CheckCooldown
NOP



; Cooldown check code, double RTL if cooldown isn't up
freecode
CheckCooldown:
; Check if the cooldown is up
LDA !CooldownTimerFinal
BEQ .Coolup


; If the cooldown is not up:
  .Cooldown

; Double RTL to skip spawning bounce sprites
PLA
PLA
PLA
RTL


; If the cooldown is up:
  .Coolup
; Set cooldown timer
LDA.b #!Cooldown*4
STA !CooldownTimerFinal

; Hijack restore
LDA #$0B
STA $1DF9+!addr

LDA $04
RTL