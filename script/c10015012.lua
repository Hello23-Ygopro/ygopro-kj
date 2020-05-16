--Intrepid Invader
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_INVADER)
	--creature
	aux.EnableCreatureAttribute(c)
	--untap
	aux.EnableTurnEndSelfUntap(c)
	--blocker
	aux.EnableBlocker(c,scard.con1)
	aux.AddEffectDescription(c,1,scard.con1)
end
--blocker
function scard.con1(e)
	return Duel.GetShieldCount(e:GetHandlerPlayer())<=2
end
