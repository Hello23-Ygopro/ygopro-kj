--Alcadeus, Winged Justice
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--untap
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,aux.UntapOperation(PLAYER_SELF,scard.posfilter,LOCATION_BZONE,0,1))
end
--untap
function scard.posfilter(c)
	return c:IsFaceup() and c:IsManaCostBelow(5)
end
