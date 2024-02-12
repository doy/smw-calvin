db $42 ; or db $37
JMP MarioBelow : JMP MarioAbove : JMP MarioSide
JMP SpriteV : JMP SpriteH : JMP MarioCape : JMP MarioFireball
JMP TopCorner : JMP BodyInside : JMP HeadInside
; JMP WallFeet : JMP WallBody ; when using db $37

MarioBelow:

;if mario is travelling downwards continue or else rtl
LDA $7D
CMP #$80
BCS Return


MarioAbove:
MarioSide:

TopCorner:
BodyInside:
HeadInside:

;WallFeet:	; when using db $37
;WallBody:

SpriteV:
SpriteH:

MarioCape:
MarioFireball:

;act as 25
LDA #$25
STA $1693|!addr
LDY #$00

Return:
RTL

print "An invisible block, whose contents depend on the Act As setting."