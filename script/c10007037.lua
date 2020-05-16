--Skeleton Soldier
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ZOMBIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
	--banish
	aux.EnableBattleWinSelfBanish(c)
end
