--Midnight Crawler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EARTH_EATER)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.DrawTarget(PLAYER_SELF),scard.op1)
end
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,0,LOCATION_BZONE,nil)
	Duel.Draw(tp,ct,REASON_EFFECT)
end
