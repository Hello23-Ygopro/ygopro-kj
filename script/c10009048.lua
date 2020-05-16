--Zoltara the Mercenary
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER,RACE_SPECTER)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,aux.HintTarget,scard.op1)
	--discard
	aux.AddSingleTriggerEffect(c,1,EVENT_COME_INTO_PLAY,nil,aux.HintTarget,aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,1))
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
	for tc in aux.Next(g) do
		--blocker
		aux.AddTempEffectBlocker(e:GetHandler(),tc,2,RESET_PHASE+PHASE_DRAW,reset_count)
	end
end
