--Boom Skull
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DREAD_MASK,RACE_MELT_WARRIOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--protector
	aux.EnableProtector(c)
	--guard
	aux.EnableGuard(c)
	--banish
	aux.EnableBattleWinSelfBanish(c)
end
