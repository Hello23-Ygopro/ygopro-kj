--Waveforce Seer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_AQUAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_DRAW,nil,nil,scard.op1,nil,aux.EventPlayerCondition(PLAYER_SELF))
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,eg:GetCount(),eg:GetCount(),nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	--cannot be blocked
	aux.AddTempEffectCannotBeBlocked(e:GetHandler(),g:GetFirst(),1)
end
