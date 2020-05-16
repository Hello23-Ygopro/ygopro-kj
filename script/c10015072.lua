--Gullet Ghost
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_SPECTER)
	--creature
	aux.EnableCreatureAttribute(c)
	--clash (discard)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.ClashTarget(PLAYER_SELF),scard.op1)
end
--clash (discard)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Clash(tp) then
		Duel.DiscardHand(1-tp,aux.TRUE,1,1,REASON_EFFECT)
	end
end
