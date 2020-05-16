--Caustic Tachavore
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_EARTH_EATER)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--clash (get ability)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.ClashTarget(PLAYER_SELF),scard.op1)
end
--clash (get ability)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if not Duel.Clash(tp) or g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--cannot be blocked
		aux.AddTempEffectCannotBeBlocked(e:GetHandler(),tc,1)
	end
end
