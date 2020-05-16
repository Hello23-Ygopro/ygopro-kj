--Cavern Snapper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BRAIN_JACKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--banish
	aux.EnableAttackEndSelfBanish(c)
end
