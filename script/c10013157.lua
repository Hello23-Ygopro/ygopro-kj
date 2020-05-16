--Hydrobot Scarab
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_UNDERTOW_ENGINE,RACE_MEGABUG)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.DrawTarget(PLAYER_SELF),scard.op1)
end
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_BZONE,0,e:GetHandler())
	Duel.Draw(tp,ct,REASON_EFFECT)
end
