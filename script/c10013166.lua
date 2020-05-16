--Trox the Merciless
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionCivilization,CIVILIZATION_DARKNESS))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--unleash (banish)
	aux.EnableUnleash(c,0,aux.CheckCardFunction(scard.banfilter1,0,LOCATION_BZONE),scard.op1)
end
--unleash (banish)
function scard.banfilter1(c)
	return c:IsFaceup() and c:KJIsBanishable()
end
function scard.banfilter2(c,code)
	return scard.banfilter1(c) and c:IsCode(code)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ANNOUNCENAME)
	local code=Duel.AnnounceCard(tp)
	local g=Duel.GetMatchingGroup(scard.banfilter2,tp,0,LOCATION_BZONE,nil,code)
	Duel.KJBanish(g,REASON_EFFECT)
end
