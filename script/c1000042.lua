--Cyber Seer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw, discard
	aux.AddTriggerEffectPlayerCastSpell(c,0,PLAYER_SELF,nil,true,aux.DrawTarget(PLAYER_SELF),scard.op1)
end
--draw, discard
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,1,REASON_EFFECT)==0 then return end
	Duel.ShuffleHand(tp)
	Duel.DiscardHand(tp,aux.TRUE,1,1,REASON_EFFECT)
end
