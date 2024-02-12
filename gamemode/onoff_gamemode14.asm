!CooldownTimer = $18F6|!addr

main:
	; Tick down the cooldown
	LDA !CooldownTimer
	BEQ .NoTick

	DEC !CooldownTimer

	  .NoTick
	RTL