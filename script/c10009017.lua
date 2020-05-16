--Curse-Eye Black Feather
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPECTER)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddTriggerEffect(c,0,EVENT_DISCARD,true,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,aux.DiscardHandCondition(PLAYER_OPPO))
end
--draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,eg:GetCount(),REASON_EFFECT)
end
