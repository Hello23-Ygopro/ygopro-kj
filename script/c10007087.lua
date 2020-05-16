--Cryptic Worm
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_VIRUS,RACE_ROT_WORM)
	--creature
	aux.EnableCreatureAttribute(c)
end
