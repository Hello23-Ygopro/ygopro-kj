--Void Seer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_AQUAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--clash (draw)
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,aux.ClashTarget(PLAYER_SELF),scard.op1)
end
--clash (draw)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Clash(tp) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
