--Sasha the Observer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--draw
	aux.AddTriggerEffect(c,0,EVENT_BATTLE_CONFIRM,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1),nil,scard.con1)
	--banish replace (discard)
	aux.AddSingleReplaceEffectBanish(c,1,scard.tg1)
end
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.UnblockedCondition(e,tp,eg,ep,ev,re,r,rp)
		and Duel.GetAttacker():GetControler()~=tp and Duel.GetAttackTarget()==nil
end
--banish replace (discard)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsReason(REASON_REPLACE)
		and Duel.IsExistingMatchingCard(Card.IsCreature,tp,LOCATION_HAND,0,1,nil) end
	if Duel.SelectYesNo(tp,aux.Stringid(sid,2)) then
		Duel.Hint(HINT_CARD,0,sid)
		Duel.DiscardHand(tp,Card.IsCreature,1,1,REASON_EFFECT)
		return true
	else return false end
end
