--Fanged Horror
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROT_WORM)
	--creature
	aux.EnableCreatureAttribute(c)
	--banish
	aux.EnableAttackEndSelfBanish(c)
end
