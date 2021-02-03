--Fearfeather the Scavenger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--evolution
	aux.AddEvolutionProcedure(c,aux.FilterBoolFunction(Card.IsEvolutionRace,RACE_CHIMERA,RACE_TREE_KIN))
	--discard, to mana zone
	aux.AddSingleTriggerEffectWinBattle(c,0,nil,nil,scard.op1)
end
--discard, to mana zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.RandomDiscardHand(1-tp,1,REASON_EFFECT)
	if Duel.IsPlayerCanSendDecktoMZone(tp,1) and Duel.SelectYesNo(tp,YESNOMSG_TOMZONE) then
		Duel.BreakEffect()
		Duel.SendDecktoMZone(tp,1,POS_FACEUP_UNTAPPED,REASON_EFFECT)
	end
end
