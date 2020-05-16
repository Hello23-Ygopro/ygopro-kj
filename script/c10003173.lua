--Diabrost, Shadow Marshal
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,aux.SendtoHandOperation(PLAYER_SELF,aux.KJDPileFilter(scard.retfilter),LOCATION_DPILE,0,1))
end
--return
function scard.retfilter(c)
	return c:KJIsRace(RACE_SHADOW_CHAMPION)
end
