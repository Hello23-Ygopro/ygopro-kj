--Aeronaut Glu-urrgle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	aux.AddNameCategory(c,NAMECAT_GLUURRGLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--summon for free
	aux.EnableEffectCustom(c,EFFECT_SUMMON_FOR_FREE,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
	--shield blast
	aux.EnableShieldBlast(c,scard.con2)
end
--summon for free
function scard.con1(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_HAND,0)>=8
end
--shield blast
function scard.con2(e,tp,eg,ep,ev,re,r,rp)
	--excluded e:GetHandler() because "shield blast" abilities are not supposed to trigger in a player's hand
	return Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())>=8
end
