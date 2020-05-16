--Cackling Fiend
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--banish
	aux.EnableBattleWinSelfBanish(c)
end
