--Sledge Bot
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STOMPER)
	--creature
	aux.EnableCreatureAttribute(c)
	--protector
	aux.EnableProtector(c)
	--skirmisher
	aux.EnableSkirmisher(c)
end
