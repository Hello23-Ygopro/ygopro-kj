--Prowling Chimera
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--banish
	aux.EnableBattleWinSelfBanish(c)
end
